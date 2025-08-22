<?php

namespace App\Http\Controllers\Gateway;

use App\Models\Plan;
use App\Models\User;
use App\Models\Deposit;
use App\Lib\FormProcessor;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Models\GatewayCurrency;
use App\Models\AdminNotification;
use App\Http\Controllers\Controller;
use App\Support\LevelBenefits;
use Illuminate\Support\Facades\Log;

class PaymentController extends Controller
{
    /**
     * يسترجع نسبة bonus_points_percent من مزايا مستوى المستخدم الحالي.
     * (يزيد الاعتمادات فقط، لا يغيّر السعر)
     */
    private function getBonusPercent(User $user): float
    {
        try {
            $benefits = LevelBenefits::getActive($user);
            foreach ($benefits as $b) {
                if (($b['type'] ?? null) === 'bonus_points_percent') {
                    return (float) ($b['value'] ?? 0);
                }
            }
        } catch (\Throwable $e) {
            Log::warning('bonus_points_percent:getActive_failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);
        }

        // Fallback: من علاقة مستوى المستخدم (إن وُجدت)
        try {
            if (method_exists($user, 'userLevel')) {
                $ul = $user->userLevel()->with(['level.benefits' => function ($q) {
                    $q->where('is_active', true);
                }])->first();

                if ($ul && $ul->level && $ul->level->benefits) {
                    foreach ($ul->level->benefits as $b) {
                        if (($b->type ?? null) === 'bonus_points_percent') {
                            return (float) ($b->value ?? 0);
                        }
                    }
                }
            }
        } catch (\Throwable $e) {
            Log::warning('bonus_points_percent:fallback_failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);
        }

        return 0.0;
    }

    /**
     * يسترجع نسبة buy_points_discount_percent من مزايا مستوى المستخدم الحالي.
     * (يقلّل السعر المدفوع، لا يغيّر الاعتمادات الأساسية)
     */
    private function getBuyDiscountPercent(User $user): float
    {
        try {
            $benefits = LevelBenefits::getActive($user);
            foreach ($benefits as $b) {
                if (($b['type'] ?? null) === 'buy_points_discount_percent') {
                    return (float) ($b['value'] ?? 0);
                }
            }
        } catch (\Throwable $e) {
            Log::warning('buy_points_discount_percent:getActive_failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);
        }

        // Fallback: من علاقة مستوى المستخدم (إن وُجدت)
        try {
            if (method_exists($user, 'userLevel')) {
                $ul = $user->userLevel()->with(['level.benefits' => function ($q) {
                    $q->where('is_active', true);
                }])->first();

                if ($ul && $ul->level && $ul->level->benefits) {
                    foreach ($ul->level->benefits as $b) {
                        if (($b->type ?? null) === 'buy_points_discount_percent') {
                            return (float) ($b->value ?? 0);
                        }
                    }
                }
            }
        } catch (\Throwable $e) {
            Log::warning('buy_points_discount_percent:fallback_failed', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);
        }

        return 0.0;
    }

    // plan
    public function payment($id)
    {
        $gatewayCurrency = GatewayCurrency::whereHas('method', function ($gate) {
            $gate->where('status', 1);
        })->with('method')->orderBy('method_code')->get();

        $pageTitle = 'Payment Methods';
        $plan = Plan::find($id);

        return view($this->activeTemplate . 'user.payment.payment', compact('gatewayCurrency', 'pageTitle', 'plan'));
    }

    public function deposit()
    {
        $gatewayCurrency = GatewayCurrency::whereHas('method', function ($gate) {
            $gate->where('status', 1);
        })->with('method')->orderBy('method_code')->get();

        $pageTitle = 'Deposit Methods';
        return view($this->activeTemplate . 'user.payment.deposit', compact('gatewayCurrency', 'pageTitle'));
    }

    public function depositInsert(Request $request)
    {
        // دفع من الرصيد مباشرة للاشتراك بالخطة
        if ($request->gateway == 'balance') {
            $user = auth()->user();
            $plan = Plan::findOrFail($request->plan_id);

            // احسب الخصم على سعر الخطة حسب مستوى المستخدم
            $discountPercent = $this->getBuyDiscountPercent($user);
            $effectivePrice  = max(0, round(((float)$plan->price) * (1 - $discountPercent / 100), 2));

            // التحقق من الرصيد حسب السعر بعد الخصم
            if ($user->balance < $effectivePrice) {
                $notify[] = ['error', 'Insufficient Balance'];
                return back()->withNotify($notify);
            }

            // منح الاعتمادات الأساسية
            $user->credits += (int) $plan->credits;

            // احتساب بونص النقاط حسب مزايا المستوى (لا يغيّر السعر)
            $bonusPercent = $this->getBonusPercent($user);
            $bonus = (int) round(((int) $plan->credits) * $bonusPercent / 100);

            Log::info('buy_points_discount_percent:balance', [
                'user_id'          => $user->id,
                'discount_percent' => $discountPercent,
                'base_price'       => (float) $plan->price,
                'effective_price'  => $effectivePrice,
            ]);
            Log::info('bonus_points_percent:depositInsert', [
                'user_id'       => $user->id,
                'bonus_percent' => $bonusPercent,
                'plan_credits'  => (int) $plan->credits,
                'bonus_added'   => $bonus,
            ]);

            if ($bonus > 0) {
                $user->credits += $bonus;
            }

            // خصم السعر بعد الخصم من الرصيد ثم حفظ
            $user->balance -= $effectivePrice;
            $user->save();

            // تسجيل حركة مالية على الرصيد (بالمبلغ بعد الخصم)
            $trx = getTrx();

            $transaction               = new Transaction();
            $transaction->user_id      = $user->id;
            $transaction->amount       = $effectivePrice;
            $transaction->post_balance = $user->balance;
            $transaction->charge       = 0;
            $transaction->trx_type     = '-';
            $transaction->details      = 'Subscribe plan' . ($discountPercent > 0 ? " (discount {$discountPercent}%)" : '');
            $transaction->trx          = $trx;
            $transaction->remark       = 'Subscribe_Plan';
            $transaction->save();

            // إشعار الأدمن
            $adminNotification             = new AdminNotification();
            $adminNotification->user_id    = $user->id;
            $adminNotification->title      = 'Plan Subscribe from ' . $user->username;
            $adminNotification->click_url  = urlPath('admin.users.detail', $user->id);
            $adminNotification->save();

            // عمولة الشبكة (إن وُجدت) — على السعر الأصلي أو بعد الخصم حسب سياستك
            levelCommision($user->id, $plan->price, $plan->id, 'commission for plan subscribe');

            // إشعار المستخدم (بالمبلغ المدفوع فعليًا)
            notify($user, 'PLAN SUBSCRIBE', [
                'plan_name'    => $plan->name,
                'amount'       => showAmount($effectivePrice),
                'trx'          => $trx,
                'post_balance' => showAmount($user->balance),
            ]);

            $notify[] = ['success', 'Plan Subscribe has been successfully'];
            return to_route('user.home')->withNotify($notify);
        }

        // إيداع عبر بوابة دفع (مع خصم السعر لو كان شراء خطة)
        $request->validate([
            'amount' => 'required|numeric|gt:0',
            'method_code' => 'required',
            'currency' => 'required',
        ]);

        $user   = auth()->user();
        $planId = $request->plan_id;

        // حدد المبلغ الأساسي: سعر الخطة لو شراء خطة، وإلا قيمة الطلب
        $baseAmount = (float) $request->amount;
        $plan = null;
        if ($planId) {
            $plan = Plan::findOrFail($planId);
            $baseAmount = (float) $plan->price;
        }

        // طبّق الخصم فقط عند شراء خطة
        $discountPercent = $plan ? $this->getBuyDiscountPercent($user) : 0.0;
        $amountToCharge  = $plan ? max(0, round($baseAmount * (1 - $discountPercent/100), 2)) : $baseAmount;

        $gate = GatewayCurrency::whereHas('method', function ($gate) {
            $gate->where('status', 1);
        })->where('method_code', $request->method_code)
          ->where('currency', $request->currency)
          ->first();

        if (!$gate) {
            $notify[] = ['error', 'Invalid gateway'];
            return back()->withNotify($notify);
        }

        // التحقق من حدود البوابة على المبلغ بعد الخصم
        if ($gate->min_amount > $amountToCharge || $gate->max_amount < $amountToCharge) {
            $notify[] = ['error', 'Please follow deposit limit'];
            return back()->withNotify($notify);
        }

        // رسوم وناتج نهائي على المبلغ بعد الخصم
        $charge    = $gate->fixed_charge + ($amountToCharge * $gate->percent_charge / 100);
        $payable   = $amountToCharge + $charge;
        $final_amo = $payable * $gate->rate;

        Log::info('buy_points_discount_percent:gateway', [
            'user_id'          => $user->id,
            'plan_id'          => $planId,
            'discount_percent' => $discountPercent,
            'base_amount'      => $baseAmount,
            'amount_to_charge' => $amountToCharge,
            'charge'           => $charge,
            'final_amo'        => $final_amo,
            'gateway'          => $gate->method_code . ' ' . strtoupper($gate->currency),
        ]);

        $data                  = new Deposit();
        $data->user_id         = $user->id;
        $data->plan_id         = $planId;
        $data->method_code     = $gate->method_code;
        $data->method_currency = strtoupper($gate->currency);
        $data->amount          = $amountToCharge; // ✅ المبلغ بعد الخصم
        $data->charge          = $charge;
        $data->rate            = $gate->rate;
        $data->final_amo       = $final_amo;
        $data->btc_amo         = 0;
        $data->btc_wallet      = "";
        $data->trx             = getTrx();
        $data->try             = 0;
        $data->status          = 0;
        $data->save();

        session()->put('Track', $data->trx);
        return to_route('user.deposit.confirm');
    }

    public function appDepositConfirm($hash)
    {
        try {
            $id = decrypt($hash);
        } catch (\Exception $ex) {
            return "Sorry, invalid URL.";
        }

        $data = Deposit::where('id', $id)->where('status', 0)->orderBy('id', 'DESC')->firstOrFail();
        $user = User::findOrFail($data->user_id);
        auth()->login($user);
        session()->put('Track', $data->trx);

        return to_route('user.deposit.confirm');
    }

    public function depositConfirm()
    {
        $track   = session()->get('Track');
        $deposit = Deposit::where('trx', $track)->where('status', 0)
            ->orderBy('id', 'DESC')->with('gateway')->firstOrFail();

        if ($deposit->method_code >= 1000) {
            return to_route('user.deposit.manual.confirm');
        }

        $dirName = $deposit->gateway->alias;
        $new     = __NAMESPACE__ . '\\' . $dirName . '\\ProcessController';

        $data = $new::process($deposit);
        $data = json_decode($data);

        if (isset($data->error)) {
            $notify[] = ['error', $data->message];
            return to_route(gatewayRedirectUrl())->withNotify($notify);
        }
        if (isset($data->redirect)) {
            return redirect($data->redirect_url);
        }

        // for Stripe V3
        if (@$data->session) {
            $deposit->btc_wallet = $data->session->id;
            $deposit->save();
        }

        $pageTitle = 'Payment Confirm';
        return view($this->activeTemplate . $data->view, compact('data', 'pageTitle', 'deposit'));
    }

    public static function userDataUpdate($deposit, $isManual = null)
    {
        if ($deposit->status == 0 || $deposit->status == 2) {
            $deposit->status = 1;
            $deposit->save();

            $user = User::find($deposit->user_id);

            // إذا لم تكن عملية اشتراك خطة، فهو إيداع عادي للرصيد
            if (!isset($deposit->plan_id)) {
                $user->balance += $deposit->amount;
                $user->save();
            }

            // اشتراك خطة عبر بوابة الدفع
            if (isset($deposit->plan_id)) {
                $plan = Plan::findOrFail($deposit->plan_id);

                // منح الاعتمادات الأساسية
                $user->credits += (int) $plan->credits;

                // احتساب بونص النقاط من مزايا المستوى (لا يغيّر السعر)
                $bonusPercent = (new static)->getBonusPercent($user);
                $bonus = (int) round(((int) $plan->credits) * $bonusPercent / 100);

                Log::info('bonus_points_percent:userDataUpdate', [
                    'user_id'       => $user->id,
                    'bonus_percent' => $bonusPercent,
                    'plan_credits'  => (int) $plan->credits,
                    'bonus_added'   => $bonus,
                    'deposit_trx'   => $deposit->trx,
                ]);

                if ($bonus > 0) {
                    $user->credits += $bonus;
                }

                $user->save();

                // إشعار الأدمن
                $adminNotification            = new AdminNotification();
                $adminNotification->user_id   = $user->id;
                $adminNotification->title     = 'Plan Subscribe from ' . $user->username;
                $adminNotification->click_url = urlPath('admin.users.detail', $user->id);
                $adminNotification->save();

                // عمولة الشبكة (حسب سياستك: أصلي أو بعد خصم)
                levelCommision($user->id, $plan->price, $plan->id, 'commission for plan subscribe');

                // إشعار المستخدم — اعرض المبلغ الذي دُفع فعليًا (المحفوظ في deposit->amount بعد الخصم)
                notify($user, 'PLAN SUBSCRIBE', [
                    'plan_name'    => $plan->name,
                    'amount'       => showAmount($deposit->amount),
                    'trx'          => $deposit->trx,
                    'post_balance' => showAmount($user->balance),
                ]);
            }

            // معاملة الإيداع (للرصيد) تُسجَّل على أي حال
            $transaction               = new Transaction();
            $transaction->user_id      = $deposit->user_id;
            $transaction->amount       = $deposit->amount;
            $transaction->post_balance = $user->balance;
            $transaction->charge       = $deposit->charge;
            $transaction->trx_type     = '+';
            $transaction->details      = 'Deposit Via ' . $deposit->gatewayCurrency()->name;
            $transaction->trx          = $deposit->trx;
            $transaction->remark       = 'deposit';
            $transaction->save();

            if (!$isManual) {
                $adminNotification            = new AdminNotification();
                $adminNotification->user_id   = $user->id;
                $adminNotification->title     = 'Deposit successful via ' . $deposit->gatewayCurrency()->name;
                $adminNotification->click_url = urlPath('admin.deposit.successful');
                $adminNotification->save();
            }

            notify($user, $isManual ? 'DEPOSIT_APPROVE' : 'DEPOSIT_COMPLETE', [
                'method_name'    => $deposit->gatewayCurrency()->name,
                'method_currency'=> $deposit->method_currency,
                'method_amount'  => showAmount($deposit->final_amo),
                'amount'         => showAmount($deposit->amount),
                'charge'         => showAmount($deposit->charge),
                'rate'           => showAmount($deposit->rate),
                'trx'            => $deposit->trx,
                'post_balance'   => showAmount($user->balance),
            ]);
        }
    }

    public function manualDepositConfirm()
    {
        $track = session()->get('Track');
        $data  = Deposit::with('gateway')->where('status', 0)->where('trx', $track)->first();
        if (!$data) {
            return to_route(gatewayRedirectUrl());
        }
        if ($data->method_code > 999) {
            $pageTitle = 'Deposit Confirm';
            $method    = $data->gatewayCurrency();
            $gateway   = $method->method;
            return view($this->activeTemplate . 'user.payment.manual', compact('data', 'pageTitle', 'method', 'gateway'));
        }
        abort(404);
    }

    public function manualDepositUpdate(Request $request)
    {
        $track = session()->get('Track');
        $data  = Deposit::with('gateway')->where('status', 0)->where('trx', $track)->first();
        if (!$data) {
            return to_route(gatewayRedirectUrl());
        }

        $gatewayCurrency = $data->gatewayCurrency();
        $gateway         = $gatewayCurrency->method;
        $formData        = $gateway->form->form_data;

        $formProcessor  = new FormProcessor();
        $validationRule = $formProcessor->valueValidation($formData);
        $request->validate($validationRule);
        $userData = $formProcessor->processFormData($request, $formData);

        $data->detail = $userData;
        $data->status = 2; // pending
        $data->save();

        $adminNotification            = new AdminNotification();
        $adminNotification->user_id   = $data->user->id;
        $adminNotification->title     = 'Deposit request from ' . $data->user->username;
        $adminNotification->click_url = urlPath('admin.deposit.details', $data->id);
        $adminNotification->save();

        notify($data->user, 'DEPOSIT_REQUEST', [
            'method_name'    => $data->gatewayCurrency()->name,
            'method_currency'=> $data->method_currency,
            'method_amount'  => showAmount($data->final_amo),
            'amount'         => showAmount($data->amount),
            'charge'         => showAmount($data->charge),
            'rate'           => showAmount($data->rate),
            'trx'            => $data->trx,
        ]);

        $notify[] = ['success', 'You have deposit request has been taken'];
        return to_route('user.deposit.history')->withNotify($notify);
    }
}
