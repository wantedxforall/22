<?php

namespace App\Http\Controllers\User;

use App\Models\Form;
use App\Models\Plan;
use App\Models\Proof;
use App\Models\Report;
use App\Models\Deposit;
use App\Models\Service;
use App\Models\Category;
use App\Lib\FormProcessor;
use App\Models\ServiceView;
use App\Models\SocialCheck;
use App\Models\Transaction;
use App\Services\ApifyService;
use App\Events\PointsSpent;
use Illuminate\Http\Request;
use App\Rules\FileTypeValidate;
use App\Lib\GoogleAuthenticator;
use App\Http\Controllers\Controller;
use App\Events\PostCompleted;

// ✅ إضافات
use App\Support\LevelBenefits;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    public function home()
    {
        $pageTitle = 'Dashboard';
        $user = auth()->user();

        try {
        // عدد الإكمالات الفعلي لهذا المستخدم
        $completedCount = \DB::table('service_views')
            ->where('user_id', $user->id)
            ->count();

        // المستوى المناسب بناء على القيم الحالية للمستويات
        $level = \App\Models\Level::where('is_active', 1)
            ->where('min_points_spent', '<=', $completedCount)
            ->orderBy('min_points_spent', 'desc')
            ->orderBy('priority', 'desc')
            ->first();

        // نحضّر بيانات التحديث/الإدراج
        $payload = [
            'level_id'     => $level?->id,
            'points_spent' => $completedCount,
            'updated_at'   => now(),
            'created_at'   => now(), // لن تؤثر إذا السجل موجود
        ];

        // حدّث achieved_at في كل مزامنة (حسب طلبك)
        if (\Illuminate\Support\Facades\Schema::hasColumn('user_levels', 'achieved_at')) {
            $payload['achieved_at'] = now();
        }

        // تحديث أو إنشاء السجل
        \DB::table('user_levels')->updateOrInsert(
            ['user_id' => $user->id],
            $payload
        );

        // نفلّش كاش مزايا المستويات لهذا المستخدم لتظهر القيم الصحيحة فورًا
        \App\Support\LevelBenefits::flushUser($user);

    } catch (\Throwable $e) {
        \Log::warning('dash_user_level_autosync_failed', [
            'user_id' => $user->id,
            'err'     => $e->getMessage(),
        ]);
    }

    // === (الباقي كما هو) ===
    // Monthly Deposit  Report Graph
    $deposits = Deposit::selectRaw("SUM(amount) as amount, MONTHNAME(created_at) as month_name, MONTH(created_at) as month_num")
        ->whereYear('created_at', date('Y'))
        ->whereStatus(1)
        ->where('user_id',$user->id)
        ->groupBy('month_name', 'month_num')
        ->orderBy('month_num')
        ->get();

    $depositsChart['labels'] = $deposits->pluck('month_name');
    $depositsChart['values'] = $deposits->pluck('amount');

    $widget['total_services']   = Service::where('user_id',$user->id)->count();
    $widget['pending_services'] = Service::where('user_id',$user->id)->where('status',0)->count();

    return view($this->activeTemplate . 'user.dashboard', compact('pageTitle','depositsChart','widget'));


        // Monthly Deposit  Report Graph
        $deposits = Deposit::selectRaw("SUM(amount) as amount, MONTHNAME(created_at) as month_name, MONTH(created_at) as month_num")
            ->whereYear('created_at', date('Y'))
            ->whereStatus(1)
            ->where('user_id',$user->id)
            ->groupBy('month_name', 'month_num')
            ->orderBy('month_num')
            ->get();

        $depositsChart['labels'] = $deposits->pluck('month_name');
        $depositsChart['values'] = $deposits->pluck('amount');

        $widget['total_services']   = Service::where('user_id',$user->id)->count();
        $widget['pending_services'] = Service::where('user_id',$user->id)->where('status',0)->count();

        return view($this->activeTemplate . 'user.dashboard', compact('pageTitle','depositsChart','widget'));
    }

    public function depositHistory(Request $request)
    {
        $pageTitle = 'Deposit History';
        $deposits = auth()->user()->deposits();
        if ($request->search) {
            $deposits = $deposits->where('trx',$request->search);
        }
        $deposits = $deposits->with(['gateway'])->orderBy('id','desc')->paginate(getPaginate());
        return view($this->activeTemplate.'user.deposit_history', compact('pageTitle', 'deposits'));
    }

    public function show2faForm()
    {
        $general = gs();
        $ga = new GoogleAuthenticator();
               $user = auth()->user();
        $secret = $ga->createSecret();
        $qrCodeUrl = $ga->getQRCodeGoogleUrl($user->username . '@' . $general->site_name, $secret);
        $pageTitle = '2FA Setting';
        return view($this->activeTemplate.'user.twofactor', compact('pageTitle', 'secret', 'qrCodeUrl'));
    }

    public function create2fa(Request $request)
    {
        $user = auth()->user();
        $this->validate($request, [
            'key' => 'required',
            'code' => 'required',
        ]);
        $response = verifyG2fa($user,$request->code,$request->key);
        if ($response) {
            $user->tsc = $request->key;
            $user->ts = 1;
            $user->save();
            $notify[] = ['success', 'Google authenticator activated successfully'];
            return back()->withNotify($notify);
        } else {
            $notify[] = ['error', 'Wrong verification code'];
            return back()->withNotify($notify);
        }
    }

    public function disable2fa(Request $request)
    {
        $this->validate($request, [
            'code' => 'required',
        ]);

        $user = auth()->user();
        $response = verifyG2fa($user,$request->code);
        if ($response) {
            $user->tsc = null;
            $user->ts = 0;
            $user->save();
            $notify[] = ['success', 'Two factor authenticator deactivated successfully'];
        } else {
            $notify[] = ['error', 'Wrong verification code'];
        }
        return back()->withNotify($notify);
    }

    public function transactions(Request $request)
    {
        $pageTitle = 'Transactions';
        $remarks = Transaction::distinct('remark')->orderBy('remark')->get('remark');
        $transactions = Transaction::where('user_id',auth()->id());

        if ($request->search) {
            $transactions = $transactions->where('trx',$request->search);
        }

        if ($request->type) {
            $transactions = $transactions->where('trx_type',$request->type);
        }

        if ($request->remark) {
            $transactions = $transactions->where('remark',$request->remark);
        }

        $transactions = $transactions->orderBy('id','desc')->paginate(getPaginate());
        return view($this->activeTemplate.'user.transactions', compact('pageTitle','transactions','remarks'));
    }


    public function attachmentDownload($fileHash)
    {
        $filePath = decrypt($fileHash);
        $realPath = realpath($filePath);
        $storagePath = realpath(storage_path());

        if (!$realPath || !str_starts_with($realPath, $storagePath) || !is_file($realPath)) {
            abort(404);
        }

        $extension = pathinfo($realPath, PATHINFO_EXTENSION);
        $general = gs();
        $title = slug($general->site_name) . '- attachments.' . $extension;

        return response()->download($realPath, $title);
    }

    public function userData()
    {
        $user = auth()->user();
        if ($user->reg_step == 1) {
            return to_route('user.home');
        }
        $pageTitle = 'User Data';
        return view($this->activeTemplate.'user.user_data', compact('pageTitle','user'));
    }

    public function userDataSubmit(Request $request)
    {
        $user = auth()->user();
        if ($user->reg_step == 1) {
            return to_route('user.home');
        }
        $request->validate([
            'firstname'=>'required',
            'lastname'=>'required',
        ]);
        $user->firstname = $request->firstname;
        $user->lastname = $request->lastname;
        $user->address = [
            'country'=>@$user->address->country,
            'address'=>$request->address,
            'state'=>$request->state,
            'zip'=>$request->zip,
            'city'=>$request->city,
        ];
        $user->reg_step = 1;
        $user->save();

        $notify[] = ['success','Registration process completed successfully'];
        return to_route('user.home')->withNotify($notify);

    }


    public function plan(){
        $pageTitle = 'By Credits';
        $plans = Plan::where('status',1)->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.plan',compact('pageTitle','plans'));
    }

    public function fetchPost(Request $request){
        $pageTitle = 'Post Lists';
        $services = Service::with('category')->where('status',1)->where('user_id','!=',auth()->user()->id);

        if(request('category')){
            $services = $services->where('category_id', request('category'));
        }

        if(request('sort') == 'points_desc'){
            $services = $services->orderBy('allocated_credits', 'desc');
        }elseif(request('sort') == 'points_asc'){
            $services = $services->orderBy('allocated_credits', 'asc');
        }else{
            $services = $services->inRandomOrder();
        }

        $services = $services->latest()->limit(100)->get();

        $categories = Category::with('actor')->where('status', 1)->latest()->get();
        $viewed  = ServiceView::where('user_id',auth()->user()->id)->pluck('service_id')->toArray();
        return view($this->activeTemplate.'user.services.all_posts',compact('pageTitle','services','viewed','categories'));
    }

    public function postDetails($slug,$id){
        $service = Service::findOrFail($id);
        $user = auth()->user();
        $pageTitle = $service->name;
        $categories = Category::with('actor')->where('status',1)->latest()->get();
        return view($this->activeTemplate.'user.services.details',compact('pageTitle','service','categories','user'));
    }

    public function confirm(Request $request)
    {
        $user    = auth()->user();
        $service = Service::findOrFail($request->service_id);

        $socialCheck = SocialCheck::where('service_id', $service->id)
            ->where('user_id', $user->id)
            ->where('status', 'pending')
            ->latest()
            ->first();

        if(!$socialCheck){
            $notify[] = ['error', 'Social check not initiated'];
            return back()->withNotify($notify);
        }

        $serviceView = ServiceView::where('user_id',$user->id)->where('service_id',$request->service_id)->first();
        if($serviceView){
            $notify[] = ['error', 'You have already completed the task for this post.'];
            return back()->withNotify($notify);
        }

        $advertiser = $service->user;

        // التحقق الأساسي السابق (نتركه كما هو لتفادي كسر منطق سابق)
        if($advertiser->credits < $service->allocated_credits){
            $service->status = 0;
            $service->save();
            $notify[] = ['error', 'Advertiser has insufficient credits'];
            return back()->withNotify($notify);
        }

        // تحقق رصيد الخدمة مقابل حد الخصم العام
        if($service->allocated_credits < gs()->deduct_credits){
            $notify[] = ['error', 'Credits for this service have been exhausted.'];
            return back()->withNotify($notify);
        }

        // تنفيذ فحص المتابعة/الفولورز
        $username       = $this->parseUsername($service->link);
        $actorName      = $service->category?->actor?->name;
        $followersAfter = $actorName ? (new ApifyService())->getFollowers($actorName, $username) ?? 0 : 0;

        $difference = $followersAfter - $socialCheck->followers_before;

        $socialCheck->followers_after = $followersAfter;
        $socialCheck->difference      = $difference;
        $socialCheck->status          = $difference > 0 ? 'confirmed' : 'failed';
        $socialCheck->save();

        session()->flash('social_check', $socialCheck->toArray());

        if ($difference <= 0) {
            $notify[] = ['error', 'Action not verified'];
            return back()->withNotify($notify);
        }

        // ======== تطبيق مزايا المستويات عند الإكمال ========

        // 1) مكافأة المستخدم (reward_multiplier + post_completion_bonus_points)
        $baseReward       = (int) $service->allocated_credits;               // المكافأة الأساسية للمستخدم
        $rewardMultiplier = 1.0;
        $bonusFixed       = 0;

        foreach (LevelBenefits::getActive($user) as $b) {
            $type = $b['type'] ?? null;
            if ($type === 'reward_multiplier') {
                $rewardMultiplier = max(1.0, (float) ($b['value'] ?? 1));
            } elseif ($type === 'post_completion_bonus_points') {
                $bonusFixed = max(0, (int) ($b['value'] ?? 0));
            }
        }

        $finalUserReward = (int) round($baseReward * $rewardMultiplier) + $bonusFixed;

        // 2) تكلفة المُعلن (services_discount_percent)
        // القاعدة: نستخدم deduct_credits إن وُجدت، وإلا allocated_credits
        $baseCost = (int) ((gs()->deduct_credits ?? 0) ?: $service->allocated_credits);

        $servicesDiscount = 0.0;
        foreach (LevelBenefits::getActive($advertiser) as $b) {
            if (($b['type'] ?? null) === 'services_discount_percent') {
                $servicesDiscount = max(0.0, (float) ($b['value'] ?? 0));
                break;
            }
        }
        $finalAdvCost = (int) ceil($baseCost * (1 - $servicesDiscount / 100));

        // 3) أنشئ service_view بالسعر/الخصم الأساسي (للتقارير)
        $serviceView = new ServiceView();
        $serviceView->user_id    = $user->id;
        $serviceView->service_id = $service->id;
        $serviceView->view_date  = Date('Y-m-d');
        $serviceView->credits    = $baseCost; // نخزن الأساس للتتبع

        // 4) طبّق الأرصدة
        $user->credits       += $finalUserReward;
        $advertiser->credits -= $finalAdvCost;
        $service->spent_credits += $finalAdvCost;

        // حفظ
        $user->save();
        $advertiser->save();
        $service->save();
        $serviceView->save();

        // ======== مزامنة user_levels للمستخدم المُكمِّل فقط ========
        try {
            // عدد الإكمالات التي نفّذها هذا المستخدم
            $userCompletedCount = DB::table('service_views')
                ->where('user_id', $user->id)
                ->count();

            // المستوى المناسب بناءً على هذا العدد
            $userLevel = \App\Models\Level::where('is_active', 1)
                ->where('min_points_spent', '<=', $userCompletedCount)
                ->orderBy('min_points_spent', 'desc')
                ->orderBy('priority', 'desc')
                ->first();

            // upsert في user_levels
            DB::table('user_levels')->updateOrInsert(
                ['user_id' => $user->id],
                [
                    'level_id'     => $userLevel?->id,
                    'points_spent' => $userCompletedCount,
                    'updated_at'   => now(),
                    'created_at'   => now(), // لا تؤثر لو السجل موجود
                ]
            );

            // فلش كاش المزايا للمستخدم المُكمِّل
            LevelBenefits::flushUser($user);

            Log::info('user_levels_synced_after_completion_user_only', [
                'user_id'            => $user->id,
                'user_completed_cnt' => $userCompletedCount,
                'user_level_id'      => $userLevel?->id,
            ]);

        } catch (\Throwable $e) {
            Log::warning('user_level_sync_failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);
        }

        // لوج للتتبع
        Log::info('post_completed_benefits', [
            'user_id'               => $user->id,
            'advertiser_id'         => $advertiser->id,
            'reward_multiplier'     => $rewardMultiplier,
            'bonus_fixed'           => $bonusFixed,
            'user_reward_base'      => $baseReward,
            'user_reward_final'     => $finalUserReward,
            'services_discount_pct' => $servicesDiscount,
            'adv_cost_base'         => $baseCost,
            'adv_cost_final'        => $finalAdvCost,
        ]);

        // أحداث
        event(new PointsSpent($advertiser, (float) $finalAdvCost, 'service_view')); // ✅ التكلفة الفعلية
        event(new PostCompleted($user));

        $notify[] = ['success', 'Submitted.'];
        return back()->withNotify($notify);
    }

    public function postReport(Request $request){

        $request->validate([
            'report' => 'required'
        ]);

        $user = auth()->user();
        $exist = Report::where('user_id',$user->id)->where('service_id',$request->service_id)->first();
        $existServiceView = ServiceView::where('user_id',$user->id)->where('service_id',$request->service_id)->first();

        if($exist){
            $notify[] = ['error', 'You have already submitted the report for this post.'];
            return back()->withNotify($notify);
        }

        if(!$existServiceView){
            $notify[] = ['error', 'Please complete the task before submitting a report.'];
            return back()->withNotify($notify);
        }

        $report =  new Report();
        $report->user_id = $user->id;
        $report->service_id = $request->service_id;
        $report->report = $request->report;
        $report->save();

        $notify[] = ['success','Report submitted'];
        return back()->withNotify($notify);
    }

    protected function parseUsername(string $url): string
    {
        return trim($url);
    }

}
