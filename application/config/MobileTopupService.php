<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class MobileTopupService
{
    public function fetchLibyanaInfo(): array
    {
        $storeId = (int) config('services.libyana.store_id');
        $base    = rtrim((string) config('services.libyana.info_url'), '/');
        $url     = "{$base}/{$storeId}";

        Log::info('OUT -> Libyana payment_info', ['url' => $url]);

        $resp = Http::timeout(20)->acceptJson()->get($url);
        $json = $resp->json() ?: [];

        Log::info('IN <- Libyana payment_info', [
            'status' => $resp->status(),
            'body'   => $json,
        ]);

        if (!$resp->ok()) return ['ok'=>false,'message'=>'network_error'];

        $dest = $json['number'][0] ?? null;
        if (!$dest) return ['ok'=>false,'message'=>'missing_dest_phone'];

        return [
            'ok'         => true,
            'dest_phone' => $dest,
            'rate'       => isset($json['rate']) ? (float) $json['rate'] : null,
            'extotal'    => isset($json['extotal']) ? (float) $json['extotal'] : null,
        ];
    }

    public function fetchAlmadarInfo(): array
{
    // 1) رقم تحويل المدار من قاعدة البيانات
    try {
        $dest = \DB::table('general_settings')->value('almadar_wallet');
    } catch (\Throwable $e) {
        \Log::warning('almadar_wallet_read_failed', ['error' => $e->getMessage()]);
        $dest = null;
    }

    // 2) سعر الصرف من InanaStore (payment_info/{store_id})
    $storeId = (int) config('services.almadar.store_id');
    $base    = rtrim((string) (config('services.almadar.info_url') ?: 'https://inanastore.com/api/stores/payment_info'), '/');
    $url     = "{$base}/{$storeId}";

    \Log::info('OUT -> Almadar payment_info', ['url' => $url]);

    try {
        $resp = \Http::timeout(20)->acceptJson()->get($url);
        $json = $resp->json() ?: [];

        \Log::info('IN <- Almadar payment_info', [
            'status' => $resp->status(),
            'body'   => $json,
        ]);

        if (!$resp->ok()) {
            return ['ok'=>false,'message'=>'network_error'];
        }

        $rate = (isset($json['rate']) && is_numeric($json['rate'])) ? (float)$json['rate'] : null;

        // في حال لم يكن الرقم موجودًا في DB لأي سبب، خُذ أول رقم من الـ API كاحتياط
        if (!$dest) {
            $nums = $json['number'] ?? null;
            $dest = is_array($nums) ? ($nums[0] ?? null) : $nums;
        }

        if (!$dest) {
            return ['ok'=>false,'message'=>'missing_almadar_dest'];
        }

        return [
            'ok'         => true,
            'dest_phone' => $dest,                                   // من DB
            'rate'       => $rate,                                   // من Inana
            'extotal'    => isset($json['extotal']) && is_numeric($json['extotal']) ? (float)$json['extotal'] : null,
        ];
    } catch (\Throwable $e) {
        \Log::warning('almadar_payment_info_failed', ['error' => $e->getMessage()]);
        return ['ok'=>false,'message'=>'network_exception'];
    }
}


    public function libyanaConfirm(array $params): array
    {
        $apiUrl  = (string) config('services.libyana.api_url');
        $storeId = (int)    config('services.libyana.store_id');

        $query = [
            'phone'     => $params['phone'],
            'amount'    => $params['amount'],
            'user_name' => $params['user_name'],
            'store_id'  => $storeId,
            'lang'      => $params['lang'] ?? 'ar',
        ];

        Log::info('OUT -> Libyana payment_link_check', ['url'=>$apiUrl, 'query'=>$query]);

        $resp = Http::timeout(20)->acceptJson()->get($apiUrl, $query);
        $json = $resp->json() ?: [];

        Log::info('IN <- Libyana payment_link_check', [
            'status' => $resp->status(),
            'body'   => $json,
        ]);

        $message = (string) ($json['message'] ?? '');
        $status  = strtolower((string) ($json['status'] ?? ''));

        $okish = (str_contains(strtolower($message), 'success') || $status === 'success');

        return ['ok'=>$okish, 'message'=>$message, 'raw'=>$json];
    }

    public function confirmWithProvider(string $provider, array $params): array
{
    try {
        // إعدادات المزود
        $cfg     = config('services.' . $provider, []);
        $storeId = (string) ($cfg['store_id'] ?? '');

        // اجلب رقم التحويل (dest_phone)
        if ($provider === 'almadar') {
            // من قاعدة البيانات
            $destPhone = DB::table('general_settings')->value('almadar_wallet');
        } else {
            // ليبيانا: من payment_info
            $infoUrl = rtrim((string) ($cfg['info_url'] ?? ''), '/') . '/' . $storeId;
            Log::info('OUT -> Inana payment_info', ['url' => $infoUrl]);
            $infoRes = Http::timeout(15)->get($infoUrl);
            $info    = $infoRes->json() ?: [];
            Log::info('IN  <- Inana payment_info', ['status' => $infoRes->status(), 'body' => $info]);

            $numbers   = $info['number'] ?? [];
            $destPhone = is_array($numbers) ? ($numbers[0] ?? null) : $numbers;
        }

        $query = [
            'phone'      => $params['phone'],
            'amount'     => number_format((float)$params['amount'], 2, '.', ''),
            'user_name'  => $params['user_name'] ?? 'guest',
            'store_id'   => $storeId,
            'lang'       => $params['lang'] ?? 'ar',
            'dest_phone' => $destPhone,
        ];

        $url = 'https://inanastore.com/api/stores/payment_link_check';
        Log::info('OUT -> Inana payment_link_check', ['url' => $url, 'query' => $query]);

        $res     = Http::timeout(20)->get($url, $query);
        $payload = $res->json() ?: [];

        Log::info('IN  <- Inana payment_link_check', ['status' => $res->status(), 'body' => $payload]);

        $message   = (string)($payload['message'] ?? '');
        $okByText  = (stripos($message, 'success') !== false) && (stripos($message, 'alert-danger') === false);
        $okByFlag  = (isset($payload['status']) && strtolower($payload['status']) === 'success');
        $okByEmpty = $res->ok() && empty($payload); // جسم فاضي مع 200 نعدّه نجاح مبدئي
        $ok        = $okByText || $okByFlag || $okByEmpty;


        // جرّب استخراج مبلغ مؤكد إن وُجد
        $amountFromProvider = null;
        foreach (['extotal', 'total', 'amount'] as $k) {
            if (isset($payload[$k]) && is_numeric($payload[$k])) {
                $amountFromProvider = (float)$payload[$k];
                break;
            }
        }

        return [
            'ok'      => $ok,
            'message' => $message ?: ($ok ? 'ok' : 'fail'),
            'amount'  => $amountFromProvider, // قد تكون null إن الـ API لم يرجع مبلغًا
        ];
    } catch (\Throwable $e) {
        Log::warning('confirmWithProvider_error', ['error' => $e->getMessage()]);
        return ['ok' => false, 'message' => $e->getMessage()];
    }
}


}
