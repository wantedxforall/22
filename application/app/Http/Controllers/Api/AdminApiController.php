<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\Transaction;
use App\Models\User;
use App\Services\LevelingService;
use App\Models\UserLevel;
use App\Services\ServiceCreditChecker;
use Illuminate\Http\Request;
use App\Models\Deposit;
use Illuminate\Support\Carbon;

class AdminApiController extends Controller
{
    public function handleRequest(Request $request)
    {
        \Log::info('📩 Incoming Request', [
            'method'  => $request->method(),
            'url'     => $request->fullUrl(),
            'ip'      => $request->ip(),
            'headers' => $request->headers->all(),
            'query'   => $request->query(),
            'body'    => $request->all(),
        ]);

        if ($request->query('action') === 'addPayment') {
            return $this->addPayment($request);
        }

        return response()->json([
            'status' => 'fail',
            'error' => 'invalid_action'
        ]);
    }

    public function addPayment(Request $request)
{
    $data = $request->query();

    $validator = validator($data, [
        'key' => 'required',
        'amount' => 'required|numeric|gt:0',
        'details' => 'nullable|string|max:255',
        'affiliate_commission' => 'nullable',
        'username' => 'required_without:id',
        'id' => 'nullable|integer'
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => 'fail',
            'error' => $validator->errors()->first()
        ]);
    }

    $admin = Admin::where('api_token', $data['key'])->first();
    if (!$admin) {
        return response()->json([
            'status' => 'fail',
            'error' => 'bad_key'
        ]);
    }

    // جلب المستخدم
    $userQuery = User::query();
    if (!empty($data['username'])) {
        $userQuery->where('username', $data['username']);
    }
    if (!empty($data['id'])) {
        $userQuery->orWhere('id', $data['id']);
    }

    $user = $userQuery->first();
    if (!$user) {
        return response()->json([
            'status' => 'fail',
            'error' => 'bad_username'
        ]);
    }

    // 1) أضف الرصيد وسجّل Transaction
    $user->balance += $data['amount'];
    $user->save();

    $transaction = new Transaction();
    $transaction->user_id = $user->id;
    $transaction->amount = $data['amount'];
    $transaction->charge = 0;
    $transaction->post_balance = $user->balance;
    $transaction->trx_type = '+';
    $transaction->trx = getTrx();
    $transaction->details = $data['details'] ?? 'API Topup';
    $transaction->remark = 'balance_add';
    $transaction->save();

    ServiceCreditChecker::run($user);

    // 2) حدّث أقرب إيداع Pending لليبيانا إلى نجاح بقيمة المزوّد
    //    (نافذة 15 دقيقة تكفي عادة؛ غيّرها كما يلزمك)
    // 2) اختياري: حدّث Pending للمزودين 115/116 إن وُجد خلال 15 دقيقة
$methodCodes = [115, 116];

$pending = \App\Models\Deposit::where('user_id', $user->id)
    ->whereIn('method_code', $methodCodes)
    ->where('status', 2) // Pending
    ->where('created_at', '>=', \Illuminate\Support\Carbon::now()->subMinutes(15))
    ->latest('id')
    ->first();

if ($pending) {
    // عدّل فقط المبلغ وحالة النجاح. اترك final_amo (LYD) كما هو.
    $pending->amount = (float) $data['amount']; // USD المؤكد
    $pending->status = 1; // Success
    $pending->save();

    \Log::info('✅ Deposit updated from pending to success', [
        'deposit_id' => $pending->id,
        'user_id'    => $user->id,
        'amount'     => $data['amount'],
    ]);
    } else {
        // لا داعي للـ warning — الأمر معتاد لأننا نعتمد Approved مباشرة في الداشبورد
        \Log::info('deposit_update_skipped', [
            'reason'  => 'no_recent_pending',
            'user_id' => $user->id,
        ]);
    }


    // 3) الآن أرجع الرد
    return response()->json([
        'status'      => 'success',
        'user_id'     => $user->id,
        'new_balance' => $user->balance,
    ]);
}


    public function setPointsSpentTotal(Request $request, User $user)
    {
        $data = $request->all();

        $validator = validator($data, [
            'key' => 'required',
            'points' => 'required|integer|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'fail',
                'error'  => $validator->errors()->first(),
            ]);
        }

        $admin = Admin::where('api_token', $data['key'])->first();
        if (!$admin) {
            return response()->json([
                'status' => 'fail',
                'error'  => 'bad_key',
            ]);
        }

        $service = new LevelingService();
        $service->setPointsSpentTotal($user, (int) $data['points']);

        $userLevel = UserLevel::firstOrCreate(
            ['user_id' => $user->id],
            ['points_spent' => 0]
        );

        return response()->json([
            'status'             => 'success',
            'user_id'            => $user->id,
            'points_spent_total' => $userLevel->points_spent,
        ]);
    }


}
