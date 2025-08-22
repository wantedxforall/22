<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Withdraw;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Support\LevelBenefits;

class WithdrawController extends Controller
{
    // لا تعرّف $activeTemplate هنا، الكلاس الأب يوفّرها كـ public

    public function index(Request $request)
    {
        $user = $request->user();

        $withdraws = Withdraw::where('user_id', $user->id)
            ->latest()
            ->paginate(15);

        // صفحة لعرض السجل
        return view($this->activeTemplate . 'user.withdraw.index', compact('withdraws'));
    }

    public function phoneForm()
{
    $pageTitle  = 'Withdraw via Phone';
    $user       = auth()->user();

    $withdraws  = Withdraw::where('user_id', $user->id)
                    ->where('method', 'phone')
                    ->latest()
                    ->paginate(15);

    // ===== الحد الأدنى بالرصيد (عملة) من الإعدادات + تخفيضات المزايا (بالعملة) =====
    $minPhoneBalance = (float) (optional(gs())->withdraw_min_phone ?? 0);

    $reductionBalance = 0.0;
    foreach (\App\Support\LevelBenefits::getActive($user) as $benefit) {
        if ($benefit['type'] === 'withdraw_min_phone_reduction_fixed' || $benefit['type'] === 'withdraw_min_reduction_fixed') {
            $reductionBalance += (float) $benefit['value']; // نفترض أنها بالعملة
        }
    }
    $minPhoneBalance = max(0, $minPhoneBalance - $reductionBalance);

    // ===== سعر الصرف: نقاط لكل 1 عملة =====
    $ratePhone = (float) (optional(gs())->withdraw_rate_phone ?? optional(gs())->withdraw_rate ?? 1);
    if ($ratePhone <= 0) { $ratePhone = 1; } // منع القسمة على صفر

    // ===== الحد الأدنى بالنقاط المطلوب إدخاله =====
    $minPhoneCredits = $minPhoneBalance * $ratePhone;

    return view($this->activeTemplate . 'user.withdraw.phone', compact(
        'pageTitle','withdraws',
        'minPhoneBalance','ratePhone','minPhoneCredits'
    ));
}

public function usdtForm()
{
    $pageTitle  = 'Withdraw via USDT';
    $user       = auth()->user();

    $withdraws  = Withdraw::where('user_id', $user->id)
                    ->where('method', 'usdt')
                    ->latest()
                    ->paginate(15);

    // ===== الحد الأدنى بالرصيد (عملة) من الإعدادات + تخفيضات المزايا (بالعملة) =====
    $minUsdtBalance = (float) (optional(gs())->withdraw_min_usdt ?? 0);

    $reductionBalance = 0.0;
    foreach (\App\Support\LevelBenefits::getActive($user) as $benefit) {
        if ($benefit['type'] === 'withdraw_min_usdt_reduction_fixed' || $benefit['type'] === 'withdraw_min_reduction_fixed') {
            $reductionBalance += (float) $benefit['value']; // نفترض أنها بالعملة
        }
    }
    $minUsdtBalance = max(0, $minUsdtBalance - $reductionBalance);

    // ===== سعر الصرف: نقاط لكل 1 عملة =====
    $rateUsdt = (float) (optional(gs())->withdraw_rate_usdt ?? optional(gs())->withdraw_rate ?? 1);
    if ($rateUsdt <= 0) { $rateUsdt = 1; }

    // ===== الحد الأدنى بالنقاط المطلوب إدخاله =====
    $minUsdtCredits = $minUsdtBalance * $rateUsdt;

    return view($this->activeTemplate . 'user.withdraw.usdt', compact(
        'pageTitle','withdraws',
        'minUsdtBalance','rateUsdt','minUsdtCredits'
    ));
}

public function store(Request $request)
{
    // method افتراضيًا phone إن لم تُرسل
    if (!$request->filled('method')) {
        $request->merge(['method' => 'phone']);
    }

    $method = $request->input('method');
    if (!in_array($method, ['phone','usdt'], true)) {
        $method = 'phone';
        $request->merge(['method' => $method]);
    }

    $user = auth()->user();

    // ===== أسعار الصرف (نقاط لكل 1 عملة) =====
    $ratePhone = (float) (optional(gs())->withdraw_rate_phone ?? optional(gs())->withdraw_rate ?? 1);
    if ($ratePhone <= 0) { $ratePhone = 1; }

    $rateUsdt  = (float) (optional(gs())->withdraw_rate_usdt  ?? optional(gs())->withdraw_rate ?? 1);
    if ($rateUsdt <= 0) { $rateUsdt = 1; }

    // ===== الحدود الدنيا بالعملة من الإعدادات =====
    $minPhoneBalance = (float) (optional(gs())->withdraw_min_phone ?? 0);
    $minUsdtBalance  = (float) (optional(gs())->withdraw_min_usdt  ?? 0);

    // ===== التخفيضات (نفترض أنها بالعملة) =====
    $reductionPhoneBalance = 0.0;
    $reductionUsdtBalance  = 0.0;

    foreach (\App\Support\LevelBenefits::getActive($user) as $benefit) {
        if ($benefit['type'] === 'withdraw_min_phone_reduction_fixed') {
            $reductionPhoneBalance += (float) $benefit['value'];
        } elseif ($benefit['type'] === 'withdraw_min_usdt_reduction_fixed') {
            $reductionUsdtBalance += (float) $benefit['value'];
        } elseif ($benefit['type'] === 'withdraw_min_reduction_fixed') {
            $reductionPhoneBalance += (float) $benefit['value'];
            $reductionUsdtBalance  += (float) $benefit['value'];
        }
    }

    // ===== صافي الحدود الدنيا بالعملة =====
    $minPhoneBalance = max(0, $minPhoneBalance - $reductionPhoneBalance);
    $minUsdtBalance  = max(0, $minUsdtBalance  - $reductionUsdtBalance);

    // ===== تحويل الحدود الدنيا إلى نقاط مطلوبة =====
    $minPhoneCreditsRequired = $minPhoneBalance * $ratePhone;
    $minUsdtCreditsRequired  = $minUsdtBalance  * $rateUsdt;

    // ===== تحقق أساسي =====
    $request->validate([
        'credits'    => ['required','numeric','min:1'],
        'phone'      => $method === 'phone' ? ['required','numeric'] : ['nullable'],
        'binance_id' => $method === 'usdt'  ? ['required','string']  : ['nullable'],
        'method'     => ['required','string','in:phone,usdt'],
    ]);

    // ===== التحقق من الحد الأدنى بالنقاط حسب الطريقة =====
    $dynamicMinCredits = $method === 'usdt' ? $minUsdtCreditsRequired : $minPhoneCreditsRequired;
    if ((float)$request->credits < $dynamicMinCredits) {
        // نعرض رسالة توضح المطلوب بالنقاط وبالعملة
        $neededBalance = ($method === 'usdt') ? $minUsdtBalance : $minPhoneBalance;

        return back()
            ->withInput()
            ->withErrors([
                'credits' => __(
                    'Minimum withdraw for :type is :min_credits credits (≈ :min_balance balance).',
                    [
                        'type'        => strtoupper($method),
                        'min_credits' => number_format($dynamicMinCredits, 2, '.', ''),
                        'min_balance' => number_format($neededBalance, 2, '.', ''),
                    ]
                ),
            ]);
    }

    return \DB::transaction(function () use ($request, $user, $method, $ratePhone, $rateUsdt) {

        $user->refresh();

        if ($user->credits < $request->credits) {
            return back()->withErrors(['credits' => __('Insufficient credits')])->withInput();
        }

        // اختر سعر الصرف المخزَّن مع العملية
        $rate = $method === 'phone' ? $ratePhone : $rateUsdt;

        $withdraw = \App\Models\Withdraw::create([
            'user_id'    => $user->id,
            'credits'    => $request->credits,
            'phone'      => $request->phone,
            'binance_id' => $request->binance_id,
            'method'     => $method,       // phone | usdt
            'rate'       => (float) $rate, // نقاط لكل 1 عملة
            'status'     => 0,             // pending
        ]);

        // خصم النقاط
        $user->credits -= $request->credits;
        $user->save();

        $notify[] = ['success', __('Withdraw request submitted')];

        return redirect()
            ->route('user.withdraw.' . ($method === 'phone' ? 'phone' : 'usdt'))
            ->withNotify($notify);
    });
}


    public function create()
    {
        $pageTitle = 'Withdraw Credits';
        $user = auth()->user();

        $withdraws = Withdraw::with('user')
            ->where('user_id', $user->id)
            ->latest()
            ->get();

        return view($this->activeTemplate . 'user.withdraw.create', compact('pageTitle', 'withdraws'));
    }

    public function cancel(Request $request)
{
    $request->validate([
        'id' => ['required', 'integer'],
    ]);

    $user = auth()->user();

    return DB::transaction(function () use ($request, $user) {
        $withdraw = Withdraw::where('id', $request->id)
            ->where('user_id', $user->id)
            ->whereIn('status', [0, '0', 'pending'])
            ->firstOrFail();

        // رجّع الرصيد
        $user->credits = $user->credits + (float) $withdraw->credits;
        $user->save();

        // ✅ ثبّت المصدر هنا دائمًا
        $withdraw->status       = 2;         // cancelled
        $withdraw->cancelled_by = 'user';    // ← مهم: خارج أي شرط
        if (method_exists($withdraw, 'isFillable') && $withdraw->isFillable('cancelled_at')) {
            $withdraw->cancelled_at = now();
        }
        $withdraw->save();

        $notify[] = ['success', __('Withdraw request canceled')];
        return back()->withNotify($notify);
    });
}

}
