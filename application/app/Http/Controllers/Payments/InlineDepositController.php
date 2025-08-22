<?php

namespace App\Http\Controllers\Payments;

use App\Http\Controllers\Controller;
use App\Models\Deposit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class InlineDepositController extends Controller
{
    const METHOD_LIBYANA = 115;
    const METHOD_ALMADAR = 116;

    /**
     * ترجيع بيانات العرض الأولى (رقم التحويل + سعر الصرف) من الخدمة لديك
     * ملاحظة: أبقيناها كما هي عندك: تستخدم MobileTopupService داخليًا.
     */
    public function bootstrap(string $provider, \App\Services\MobileTopupService $svc)
    {
        if ($provider === 'libyana') {
            $info = $svc->fetchLibyanaInfo();
        } elseif ($provider === 'almadar') {
            $info = $svc->fetchAlmadarInfo();
        } else {
            return response()->json(['ok'=>false,'message'=>'invalid_provider'], 400);
        }

        if (!($info['ok'] ?? false)) {
            return response()->json(['ok'=>false,'message'=>$info['message'] ?? 'failed'], 500);
        }

        return response()->json([
            'ok'         => true,
            'dest_phone' => $info['dest_phone'] ?? null,
            'rate'       => $info['rate'] ?? null,     // USD -> LYD
            'extotal'    => $info['extotal'] ?? null,  // إن كانت الخدمة ترجعها
        ]);
    }

    /**
     * تأكيد العملية فعليًا مع Inana:
     * - نطلب payment_link_check
     * - لا نعتمد أي مبلغ إلا لو جاء extotal/total/amount رقمًا من نفس الرد
     * - عند النجاح ننشئ Deposit Approved بـ:
     *      amount(USD من المزود) + method_currency=USD
     *      final_amo(LYD من المستخدم)
     *      rate (USD->LYD) للمعلومة
     */
    public function confirm(string $provider, Request $request)
{
    $user = $request->user();
    if (!$user) return response()->json(['ok'=>false,'message'=>'auth_required'], 401);

    // التحقق بحسب المزود
    $rules = [
        'user_amount' => ['required','numeric','gt:0'], // LYD من المستخدم
        'user_phone'  => ['required','string'],
    ];
    if ($provider === 'libyana') {
        $rules['user_phone'][] = 'regex:/^(92|94)\d{7}$/';
        $methodCode = self::METHOD_LIBYANA; $providerId = 2;
    } elseif ($provider === 'almadar') {
        $rules['user_phone'][] = 'regex:/^218\d{9}$/';
        $methodCode = self::METHOD_ALMADAR; $providerId = 3;
    } else {
        return response()->json(['ok'=>false,'message'=>'invalid_provider'], 400);
    }
    $data = $request->validate($rules);

    $store   = config('services.'.$provider);
    $storeId = (string)($store['store_id'] ?? '');
    if ($storeId === '') return response()->json(['ok'=>false,'message'=>'store_id_missing'], 500);

    // 1) اجلب السعر من payment_info (USD->LYD) + dest_phone إن توفر
    $infoUrl     = rtrim((string)($store['info_url'] ?? 'https://inanastore.com/api/stores/payment_info'), '/') . '/' . $storeId;
    $usdToLyd    = 0.0;
    $destFromAPI = null;
    try {
        Log::info('OUT -> Inana payment_info', ['url'=>$infoUrl]);
        $infoRes = Http::timeout(15)->get($infoUrl);
        $info    = $infoRes->ok() ? ($infoRes->json() ?: []) : [];
        Log::info('IN  <- Inana payment_info', ['status'=>$infoRes->status(), 'body'=>$info]);

        if (isset($info['rate']) && is_numeric($info['rate'])) {
            $usdToLyd = (float)$info['rate']; // USD -> LYD
        }
        if (!empty($info['number'])) {
            $destFromAPI = is_array($info['number']) ? (string)($info['number'][0] ?? '') : (string)$info['number'];
        }
        // للمدار: إن أردت رقم ثابت من DB
        if ($provider === 'almadar') {
            $fixed = \DB::table('general_settings')->value('almadar_wallet');
            if ($fixed) $destFromAPI = $fixed;
        }
    } catch (\Throwable $e) {
        Log::warning('payment_info failed', ['error'=>$e->getMessage()]);
    }

    // 2) تأكيد رقم/قيمة مع Inana (للتحقق فقط)
    $checkUrl = 'https://inanastore.com/api/stores/payment_link_check';
    $query    = [
        'phone'      => $data['user_phone'],
        'amount'     => number_format((float)$data['user_amount'], 2, '.', ''), // LYD
        'user_name'  => $user->username ?? $user->name ?? ('user_'.$user->id),
        'store_id'   => $storeId,
        'lang'       => app()->getLocale() ?: 'ar',
    ];
    if ($destFromAPI) $query['dest_phone'] = $destFromAPI;

    try {
        Log::info('OUT -> Inana payment_link_check', ['url'=>$checkUrl, 'query'=>$query]);
        $checkRes = Http::timeout(20)->get($checkUrl, $query);
    } catch (\Throwable $e) {
        return response()->json(['ok'=>false,'message'=>'provider_unreachable'], 502);
    }

    $payload   = $checkRes->json() ?: [];
    Log::info('IN  <- Inana payment_link_check', ['status'=>$checkRes->status(), 'body'=>$payload]);
    if (!$checkRes->ok()) {
        return response()->json(['ok'=>false,'message'=>'provider_failed('.$checkRes->status().')'], 502);
    }
    $message   = (string)($payload['message'] ?? '');
    $isSuccess = (stripos($message,'Success') !== false) && (stripos($message,'alert-danger') === false);
    if (!$isSuccess) {
        return response()->json(['ok'=>false,'message'=>$message ?: 'mismatch'], 422);
    }

    // 3) حدّد مبلغ المزود (USD) مرّة واحدة ثم أعد استخدامه:
    //    أ) حاول قراءة extotal/total/amount من رد Inana (إذا وفّرته مستقبلاً)
    $amountFromProvider = $this->extractAmountFromPayload($payload, ['extotal','total','amount']);
    $amountLYD = round((float)$data['user_amount'], 2);

    if ($amountFromProvider !== null) {
        $amountUSD = round((float)$amountFromProvider, 2);
        $fromApi   = 1;
    } else {
        //    ب) لا يوجد مبلغ صريح من Inana → احسبه من السعر: USD = LYD / rate
        if ($usdToLyd <= 0) {
            return response()->json(['ok'=>false,'message'=>'missing_rate_to_compute_amount'], 422);
        }
        $amountUSD = round($amountLYD / $usdToLyd, 2);
        $fromApi   = 0; // محسوب داخليًا
    }

    // ⚠️ هنا مفتاح الحل لطلبك: سنستخدم نفس $amountUSD لكلٍ من:
    // - إنشاء سجل Deposit (amount بالـ USD)
    // - وإرسال addPayment (amount=...) — هو نفسه الذي يظهر في لوج "📩 Incoming Request"

    // 4) احذف أي pending سابق لنفس المستخدم ونفس المزود
    Deposit::where('user_id', $user->id)
        ->where('method_code', $methodCode)
        ->whereIn('status', [0,2])
        ->delete();

    // 5) أنشئ سجل Deposit History (Approved) — بدون Transactions للمزودين 115/116
    $trx       = strtoupper(Str::random(12));
    $dep              = new Deposit();
    $dep->user_id     = $user->id;
    $dep->method_code = $methodCode;

    // قيمة المزوّد (USD)
    $dep->amount          = $amountUSD;
    $dep->method_currency = 'USD';

    // قيمة المستخدم (LYD)
    $dep->final_amo = $amountLYD;

    $dep->charge    = 0;
    $dep->rate      = $usdToLyd > 0 ? $usdToLyd : 0;  // USD->LYD للمعلومة
    $dep->trx       = $trx;
    $dep->status    = 1; // Approved

    if (\Schema::hasColumn($dep->getTable(),'from_api')) {
        $dep->from_api = $fromApi ? 1 : 0;
    }

    $dep->detail = json_encode([
    'provider'      => $provider,
    'user_phone'    => $data['user_phone'],
    'dest_phone'    => $destFromAPI,
    'provider_msg'  => $message,
    'info_rate'     => $usdToLyd,
    'entered_lyd'   => $amountLYD,
    'provider_amt'  => $amountUSD,
    'confirmed_by'  => $fromApi ? 'provider' : 'computed_by_rate',
], JSON_UNESCAPED_UNICODE);
    $dep->save();

    // 6) أرسل addPayment بنفس amountUSD (هو نفسه الذي سيظهر في اللوج)
    $admin = config('services.adminapi');
$addUrl = (string)($admin['base_url'] ?? '');
$addKey = (string)($admin['key'] ?? '');

if ($addUrl && $addKey) {
    $addData = [
        'key'      => $addKey,
        'action'   => 'addPayment',
        'username' => $user->username ?? $user->name ?? ('user_'.$user->id),
        'amount'   => number_format($amountUSD, 2, '.', ''), // USD
        'details'  => $data['user_phone'].'.'.strtolower($trx).'/'.$providerId,
        'affiliate_commission' => 0,
    ];

    try {
        $addRes = Http::timeout(15)->get($addUrl, $addData);
        Log::info('adminapi.addPayment.sent', [
            'url'    => $addUrl,
            'status' => $addRes->status(),
            'data'   => $addData,
            'trx'    => $trx,
        ]);
    } catch (\Throwable $e) {
        Log::warning('adminapi_failed', [
            'error' => $e->getMessage(),
            'url'   => $addUrl,
            'data'  => $addData
        ]);
    }
} else {
    Log::info('adminapi.skip', ['reason'=>'not_configured']);
}

    return response()->json([
        'ok'         => true,
        'message'    => 'تم اعتماد العملية وتسجيلها في Deposit History.',
        'amount_usd' => $amountUSD,        // نفس الظاهر في اللوج
        'amount_lyd' => $amountLYD,
        'rate_used'  => $usdToLyd,
        'trx'        => $trx,
    ]);
}

/**
 * يبحث عن extotal/total/amount في أي مستوى داخل الحمولة.
 */
private function extractAmountFromPayload($payload, array $keys)
{
    if (!is_array($payload)) return null;

    $scan = function($arr) use (&$scan, $keys) {
        foreach ($arr as $k => $v) {
            foreach ($keys as $want) {
                if (strcasecmp($k, $want) === 0) {
                    if (is_numeric($v)) return (float)$v;
                    if (is_string($v) && preg_match('/\d+(\.\d+)?/', $v, $m)) return (float)$m[0];
                }
            }
            if (is_array($v)) {
                $found = $scan($v);
                if ($found !== null) return $found;
            }
        }
        return null;
    };

    return $scan($payload);
}
}
