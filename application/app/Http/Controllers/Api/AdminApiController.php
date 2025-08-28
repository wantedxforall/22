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

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class AdminApiController extends Controller
{
    /** إعدادات قابلة للتهيئة من .env (افتراضات آمنة) */
    protected bool $requireBearer        = true;   // إجبار Bearer من الهيدر (مع إبقاء توافق ?key)
    protected bool $requireSignature     = false;  // توقيع HMAC اختياري
    protected int  $maxSkewSeconds       = 300;    // حد انحراف الوقت لتوقيع HMAC
    protected int  $nonceTtlSeconds      = 900;    // TTL لمنع إعادة التنفيذ (Idempotency-Key / Nonce)
    protected bool $denyStateChangeOnGet = true;   // منع تعديلات الحالة عبر GET

    public function __construct()
    {
        $this->requireBearer        = (bool) env('ADMINAPI_REQUIRE_BEARER', true);
        $this->requireSignature     = (bool) env('ADMINAPI_REQUIRE_SIGNATURE', false);
        $this->maxSkewSeconds       = (int)  env('ADMINAPI_MAX_SKEW', 300);
        $this->nonceTtlSeconds      = (int)  env('ADMINAPI_NONCE_TTL', 900);
        $this->denyStateChangeOnGet = (bool) env('ADMINAPI_DENY_GET_MUTATION', true);
    }

    /**
     * نقطة الدخول القديمة: /api/adminapi/v1?action=...
     * - يسمح فقط بـ ping على GET ما لم يكن addPayment ومفعّل الفلاج.
     */
    public function handleRequest(Request $request)
    {
        $this->logMeta($request);

        $admin = $this->authenticate($request);
        if (!$admin) {
            return $this->err(401, 'unauthorized');
        }

        if ($this->requireSignature && !$this->verifyHmac($request)) {
            return $this->err(401, 'invalid_signature');
        }

        $action = $request->query('action', $request->input('action'));
        if (!$action) {
            return $this->err(400, 'missing_action');
        }

        if (strtoupper($request->method()) === 'GET') {
            // نسمح بـ ping دائمًا، و addPayment فقط لو الفلاج مفعّل
            $allowedGet = ['ping'];
            if (env('ADMINAPI_ALLOW_GET_ADDPAYMENT', false)) {
                $allowedGet[] = 'addPayment';
            }
            if ($this->denyStateChangeOnGet && !in_array($action, $allowedGet, true)) {
                return $this->err(405, 'get_not_allowed_for_state_change');
            }
        }

        switch ($action) {
            case 'ping':
                return response()->json([
                    'status' => 'success',
                    'time'   => now()->toIso8601String(),
                    'admin'  => $admin->username ?? null,
                ]);

            case 'addPayment':
                // لو GET ومفعّل الفلاج، نفّذ مسار GET الخاص
                if (strtoupper($request->method()) === 'GET' && env('ADMINAPI_ALLOW_GET_ADDPAYMENT', false)) {
                    return $this->addPaymentFromGet($request);
                }
                // بخلاف ذلك يجب POST
                if (strtoupper($request->method()) !== 'POST') {
                    return $this->err(405, 'use_POST_for_addPayment');
                }
                return $this->addPayment($request);

            default:
                return $this->err(400, 'invalid_action');
        }
    }



    /**
     * النسخة الآمنة: POST /adminapi/v1/add-payment
     * يدعم نفس الحقول القديمة مع تشديد التحقق.
     */
    public function addPayment(Request $request)
{
    $this->logMeta($request);

    $admin = $this->authenticate($request);
    if (!$admin) {
        return $this->err(401, 'unauthorized');
    }

    if ($this->requireSignature && !$this->verifyHmac($request)) {
        return $this->err(401, 'invalid_signature');
    }

    $data = array_merge($request->query(), $request->all());

    $validator = validator($data, [
        'amount'               => 'required|numeric|gt:0',
        'details'              => 'nullable|string|max:255',
        'affiliate_commission' => 'nullable',
        'username'             => 'required_without:id|string',
        'id'                   => 'nullable|integer',
        'txid'                 => 'nullable|string|max:190',
    ]);
    if ($validator->fails()) {
        return $this->err(422, 'validation_error', $validator->errors()->first());
    }
    $v = $validator->validated();
    $v['details'] = isset($v['details']) ? trim($v['details']) : null;

    if (!empty($v['txid']) && $this->txExists($v['txid'])) {
        return $this->err(409, 'duplicate_txid');
    }

    // Idempotency للـ POST عبر الهيدر (كما عندك)
    $idk = $request->header('X-Idempotency-Key', '');
    if ($idk === '') {
        return $this->err(422, 'missing_idempotency_key');
    }
    $cacheKey = 'adminapi:idk:' . sha1($idk);
    if (\Cache::has($cacheKey)) {
        return $this->err(409, 'duplicate_request');
    }
    \Cache::put($cacheKey, 1, $this->nonceTtlSeconds);

    $user = User::when(!empty($v['username']), fn($q) => $q->where('username', $v['username']))
                ->when(!empty($v['id']),       fn($q) => $q->orWhere('id', (int) $v['id']))
                ->first();
    if (!$user) {
        return $this->err(404, 'bad_username');
    }

    $res = $this->doAddPayment($v, $user);

    return response()->json(array_merge(['status' => 'success'], $res));
}


    /**
     * نسخة GET الاختيارية لـ addPayment — تُفعل فقط عند ADMINAPI_ALLOW_GET_ADDPAYMENT=true
     */
    protected function addPaymentFromGet(Request $request)
{
    $this->logMeta($request);

    $admin = $this->authenticate($request);
    if (!$admin) {
        return $this->err(401, 'unauthorized');
    }

    // لا نفرض HMAC على GET إذا الطرف الآخر لا يرسل رؤوس
    if ($this->requireSignature && !$this->verifyHmac($request)) {
        return $this->err(401, 'invalid_signature');
    }

    /* 1) Rate limit متكيّف (نافذة + Burst) */
    try {
        $perMin = (int) env('ADMINAPI_GET_RATELIMIT_PER_MIN', 180);
        $winSec = (int) env('ADMINAPI_GET_RL_WINDOW', 10);
        $burst  = (int) env('ADMINAPI_GET_RATELIMIT_BURST', 15);
        $scope  = (string) env('ADMINAPI_GET_RL_SCOPE', 'ip'); // ip | ip_user

        if ($perMin > 0 && $winSec > 0) {
            $limitPerWin = (int) ceil($perMin * ($winSec / 60));
            $rlId = $request->ip();
            if ($scope === 'ip_user') {
                $rlId .= '|' . ($request->query('username') ?? 'guest');
            }
            $nowBucket = (int) floor(time() / $winSec);
            $rlKey = 'adminapi:rl:getap:' . sha1($rlId . '|' . $nowBucket);

            $cnt = \Cache::increment($rlKey, 1);
            if ($cnt === 1) {
                \Cache::put($rlKey, 1, $winSec);
            }
            if ($cnt > ($limitPerWin + $burst)) {
                return $this->err(429, 'rate_limited');
            }
        }
    } catch (\Throwable $e) {
        // لو فشل الكاش، لا نوقف الطلب
    }

    $data = $request->query();

    /* 2) تحقق من البيانات */
    $validator = validator($data, [
        'amount'               => 'required|numeric|gt:0',
        'details'              => 'nullable|string|max:255',
        'affiliate_commission' => 'nullable',
        'username'             => 'required_without:id|string',
        'id'                   => 'nullable|integer',
        'txid'                 => 'nullable|string|max:190',
    ]);
    if ($validator->fails()) {
        return $this->err(422, 'validation_error', $validator->errors()->first());
    }
    $v = $validator->validated();
    $v['details'] = isset($v['details']) ? trim($v['details']) : null;

    /* 3) Idempotency بالكويري — أعد نفس نجاح أول تنفيذ */
    $qs     = $request->getQueryString() ?? '';
    $qsHash = 'adminapi:qhash:' . sha1($qs);

    if (\Cache::has($qsHash . ':result')) {
        $prev = \Cache::get($qsHash . ':result');
        return response()->json([
            'status'      => 'success',
            'user_id'     => $prev['user_id']     ?? null,
            'new_balance' => $prev['new_balance'] ?? null,
            'txid'        => $prev['txid']        ?? null,
            'replayed'    => true,
        ]);
    }

    /* 4) منع تكرار txid إن وُجد */
    if (!empty($v['txid']) && $this->txExists($v['txid'])) {
        return $this->err(409, 'duplicate_txid');
    }

    /* 5) جلب المستخدم */
    $user = \App\Models\User::when(!empty($v['username']), fn($q) => $q->where('username', $v['username']))
                            ->when(!empty($v['id']),       fn($q) => $q->orWhere('id', (int) $v['id']))
                            ->first();
    if (!$user) {
        return $this->err(404, 'bad_username');
    }

    /* 6) نفّذ العملية وأعد النتيجة + خزّنها لـ idempotency */
    $res = $this->doAddPayment($v, $user); // تُعيد مصفوفة بالنتيجة (انظر تعديل doAddPayment أدناه)

    try {
        \Cache::put($qsHash . ':result', $res, (int) $this->nonceTtlSeconds);
    } catch (\Throwable $e) {}

    return response()->json(array_merge(['status' => 'success'], $res));
}



    /**
     * النواة المشتركة لإتمام العملية (تجنب تكرار الكود بين POST/GET)
     */
    protected function doAddPayment(array $v, User $user): array
{
    $amount = (float) $v['amount'];
    $txid   = !empty($v['txid']) ? $v['txid'] : (function_exists('getTrx') ? getTrx() : strtoupper(bin2hex(random_bytes(6))));

    $t = DB::transaction(function () use ($user, $amount, $v, $txid) {
        // 1) تحديث الرصيد
        $user->balance = (float) $user->balance + $amount;
        $user->save();

        // 2) إنشاء ترانزكشن
        $tran = new Transaction();
        $tran->user_id      = $user->id;
        $tran->amount       = $amount;
        $tran->charge       = 0;
        $tran->post_balance = $user->balance;
        $tran->trx_type     = '+';
        $tran->trx          = $txid;
        $tran->details      = $v['details'] ?? 'API Topup';
        $tran->remark       = 'balance_add';
        $tran->save();

        // 3) خدمة فحص الكريدت
        ServiceCreditChecker::run($user);

        return $tran;
    });

    // تحديث أقرب Pending
    try {
        $methodCodes = [115, 116];
        $pending = Deposit::where('user_id', $user->id)
            ->whereIn('method_code', $methodCodes)
            ->where('status', 2)
            ->where('created_at', '>=', Carbon::now()->subMinutes(15))
            ->latest('id')
            ->first();

        if ($pending) {
            $pending->amount = $amount;
            $pending->status = 1;
            $pending->save();

            Log::info('✅ Deposit updated from pending to success', [
                'deposit_id' => $pending->id,
                'user_id'    => $user->id,
                'amount'     => $amount,
            ]);
        } else {
            Log::info('deposit_update_skipped', [
                'reason'  => 'no_recent_pending',
                'user_id' => $user->id,
            ]);
        }
    } catch (\Throwable $e) {
        Log::warning('deposit_update_failed', ['error' => $e->getMessage()]);
    }

    // أعد بيانات صافية ليستعملها النداء (GET/POST) بحرية
    return [
        'user_id'     => $user->id,
        'new_balance' => $user->balance,
        'txid'        => $t->trx ?? $txid,
    ];
}


    /**
     * إبقاء setPointsSpentTotal كما هو مع مصادقة آمنة
     */
    public function setPointsSpentTotal(Request $request, User $user)
    {
        $this->logMeta($request);

        $admin = $this->authenticate($request);
        if (!$admin) {
            return $this->err(401, 'unauthorized');
        }

        if ($this->requireSignature && !$this->verifyHmac($request)) {
            return $this->err(401, 'invalid_signature');
        }

        $data = $request->all();
        $validator = validator($data, [
            'points' => 'required|integer|min:0',
        ]);
        if ($validator->fails()) {
            return $this->err(422, 'validation_error', $validator->errors()->first());
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

    /* ============================ أدوات مساعدة أمنية ============================ */

    /**
     * مصادقة مرنة:
     * - تفضيل Bearer من الهيدر
     * - توافق خلفي مع ?key=... (لمنع الكسر)
     */
    protected function authenticate(Request $request): ?Admin
{
    $token = null;

    // 1) Bearer من الهيدر (المسار الطبيعي والآمن)
    $auth = $request->header('Authorization', '');
    if (preg_match('/Bearer\s+(.+)/i', $auth, $m)) {
        $token = trim($m[1]);
    }

    // 2) وضع الثقة بالـ IP لسيناريو GET + action=addPayment فقط
    if (($token === null || $token === '') && env('ADMINAPI_TRUST_IP_GET_ADDPAYMENT', false)) {
        $isGet        = strtoupper($request->method()) === 'GET';
        $isAddPayment = ($request->query('action') === 'addPayment');
        if ($isGet && $isAddPayment) {
            $allowedIps = array_filter(array_map('trim', explode(',', (string) env('ADMINAPI_ALLOWED_IPS', ''))));
            if (!empty($allowedIps) && in_array($request->ip(), $allowedIps, true)) {
                $adminId = (int) env('ADMINAPI_TRUST_ADMIN_ID', 0);
                if ($adminId > 0) {
                    $admin = Admin::find($adminId);
                    if ($admin) {
                        return $admin; // تجاوز المصادقة لهذه الحالة فقط
                    }
                }
            }
        }
    }

    if ($token === null || $token === '') {
        return null;
    }

    return Admin::where('api_token', $token)->first();
}


    protected function verifyHmac(Request $request): bool
    {
        $key = env('ADMINAPI_SIGNING_KEY'); // ضع مفتاحًا قويًا في .env
        if (!$key) return false;

        $sig      = (string) $request->header('X-Signature', '');
        $tsHeader = (string) $request->header('X-Timestamp', '');
        $nonce    = (string) ($request->header('X-Idempotency-Key', '') ?: $request->header('X-Nonce', ''));

        // تحقق من الطابع الزمني
        if (!ctype_digit($tsHeader)) return false;
        $ts  = (int) $tsHeader;
        $now = time();
        if (abs($now - $ts) > $this->maxSkewSeconds) {
            return false;
        }

        // منع إعادة التنفيذ عبر Nonce/Idempotency-Key
        if ($nonce !== '') {
            $cacheKey = 'adminapi:nonce:'.sha1($nonce);
            if (Cache::has($cacheKey)) {
                return false;
            }
            Cache::put($cacheKey, 1, $this->nonceTtlSeconds);
        }

        // صيغة التوقيع: method|path|timestamp|raw_body
        $method  = strtoupper($request->method());
        $path    = '/'.trim($request->path(), '/');
        $body    = $request->getContent(); // raw body
        $baseStr = $method.'|'.$path.'|'.$ts.'|'.$body;

        $calc = hash_hmac('sha256', $baseStr, $key);
        return hash_equals($calc, $sig);
    }

    protected function txExists(string $txid): bool
    {
        if (!class_exists(Transaction::class)) return false;
        return Transaction::where('trx', $txid)->exists();
    }

    /** تسجيل مختصر لا يسرّب أسرار */
    protected function logMeta(Request $request): void
{
    $meta = [
        'ip'     => $request->ip(),
        'path'   => $request->path(),
        'method' => $request->method(),
        'meta'   => [
            'has_auth'      => (bool) $request->header('Authorization'),
            'has_signature' => (bool) $request->header('X-Signature'),
            'has_ts'        => (bool) $request->header('X-Timestamp'),
            'has_nonce'     => (bool) ($request->header('X-Idempotency-Key') ?: $request->header('X-Nonce')),
        ],
    ];

    if (strtoupper($request->method()) === 'GET') {
        $meta['query'] = $request->query(); // كي نرى ما الذي يصل فعلاً
    }

    \Log::info('adminapi request', $meta);
}


    protected function err(int $code, string $error, $details = null)
    {
        $payload = ['status' => 'fail', 'error' => $error];
        if ($details !== null) $payload['details'] = $details;
        return response()->json($payload, $code);
    }
}
