<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\UserBenefitOverride;
use App\Support\LevelBenefits;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class BenefitOverrideController extends Controller
{
    protected array $allowedTypes = [
        'buy_points_discount_percent',
        'bonus_points_percent',
        'services_discount_percent',
        'withdraw_fee_discount_percent',
        'withdraw_min_reduction_fixed',
        'reward_multiplier',
        'post_completion_bonus_points',
        'post_creation_cost_reduction_percent',
        'withdraw_min_usdt_reduction_fixed',
        'withdraw_min_phone_reduction_fixed',
    ];

    /** Resolve the column name for the type (supports `type` or `benefit_type`). */
    protected function resolveTypeColumn(): string
    {
        return Schema::hasColumn('user_benefit_overrides', 'type') ? 'type' : 'benefit_type';
    }

    /** Find a user by username or email. */
    protected function findUserByIdentifier(string $identifier): ?User
    {
        return User::where('username', $identifier)
            ->orWhere('email', $identifier)
            ->first();
    }

    /** Normalize the value by type (enforce ranges). */
    protected function normalizeValue(string $type, $value): float
    {
        $v = (float) $value;
        switch ($type) {
            case 'reward_multiplier':
                if ($v < 1) $v = 1;
                break;
            case 'buy_points_discount_percent':
            case 'bonus_points_percent':
            case 'services_discount_percent':
            case 'withdraw_fee_discount_percent':
            case 'post_creation_cost_reduction_percent':
                if ($v < 0) $v = 0;
                if ($v > 100) $v = 100;
                break;
            default:
                if ($v < 0) $v = 0;
        }
        return (float) $v;
    }

    public function index(Request $request)
    {
        $typeCol = $this->resolveTypeColumn();

        $query = UserBenefitOverride::query()
            ->select(['id', 'user_id', $typeCol . ' as type', 'value', 'starts_at', 'ends_at', 'is_active', 'updated_at'])
            ->with(['user:id,username,email']);

        if ($request->filled('q')) {
            $q = trim($request->get('q'));
            $query->whereHas('user', function ($sub) use ($q) {
                $sub->where('username', 'like', "%{$q}%")
                    ->orWhere('email', 'like', "%{$q}%");
            });
        }

        if ($request->filled('type') && in_array($request->get('type'), $this->allowedTypes, true)) {
            $query->where($typeCol, $request->get('type'));
        }

        $overrides = $query->orderBy('updated_at', 'desc')->paginate(20)->withQueryString();

        Log::info('BenefitOverride:index', [
            'type_col' => $typeCol,
            'filters'  => $request->only(['q','type']),
            'count'    => $overrides->total(),
        ]);

        return view('admin.benefits.overrides.index', [
            'pageTitle'    => 'Benefit Overrides',
            'overrides'    => $overrides,
            'allowedTypes' => $this->allowedTypes,
            'typeCol'      => $typeCol,
        ]);
    }

    public function create()
    {
        return view('admin.benefits.overrides.create', [
            'pageTitle'    => 'Create Benefit Override',
            'allowedTypes' => $this->allowedTypes,
        ]);
    }

    public function store(Request $request)
{
    $request->validate([
        'user_identifier' => 'required|string|max:190',
        'type'            => 'required|string|in:' . implode(',', $this->allowedTypes),
        'value'           => 'required|numeric',
        'starts_at'       => 'nullable|date',
        'ends_at'         => 'nullable|date|after_or_equal:starts_at',
        'is_active'       => 'nullable|boolean',
    ]);

    $user = $this->findUserByIdentifier($request->input('user_identifier'));
    if (!$user) {
        return back()->withErrors(['user_identifier' => __('User not found by username or email')])->withInput();
    }

    $typeCol = $this->resolveTypeColumn();
    $type    = $request->input('type');
    $value   = $this->normalizeValue($type, $request->input('value'));

    // === التواريخ: استخدم وقت التنفيذ لو التاريخ بدون وقت ===
    $startsAtInput = trim((string) $request->input('starts_at', ''));
    $endsAtInput   = trim((string) $request->input('ends_at', ''));

    // starts_at: إن كان فارغ = now()، وإن كان تاريخ فقط (YYYY-MM-DD) خلي الوقت = الآن
    if ($startsAtInput === '') {
        $startsAt = Carbon::now();
    } else {
        $startsAt = Carbon::parse($startsAtInput);
        if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $startsAtInput)) {
            $startsAt->setTimeFrom(Carbon::now());
        }
    }

    // ends_at: إن كان فارغ = null، وإن كان تاريخ فقط (YYYY-MM-DD) خلي الوقت = الآن (بدل 00:00:00)
    if ($endsAtInput === '') {
        $endsAt = null;
    } else {
        $endsAt = Carbon::parse($endsAtInput);
        if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $endsAtInput)) {
            $endsAt->setTimeFrom(Carbon::now());
        }
    }

    $data = [
        'user_id'   => $user->id,
        $typeCol    => $type,
        'value'     => $value,
        'starts_at' => $startsAt,
        'ends_at'   => $endsAt,
        'is_active' => (bool) $request->boolean('is_active', true),
        'created_at'=> now(),
        'updated_at'=> now(),
    ];

    \DB::table('user_benefit_overrides')->insert($data);
    LevelBenefits::flushUser($user);

    return redirect()->route('admin.benefit-overrides.index')
        ->with('notify', [['success', __('Override created for ') . ($user->username ?? $user->email)]]);
}

    public function edit($id)
    {
        $typeCol  = $this->resolveTypeColumn();
        $override = UserBenefitOverride::query()
            ->select(['id', 'user_id', $typeCol . ' as type', 'value', 'starts_at', 'ends_at', 'is_active'])
            ->findOrFail($id);

        $user = User::find($override->user_id);

        return view('admin.benefits.overrides.edit', [
            'pageTitle'    => 'Edit Benefit Override',
            'override'     => $override,
            'user'         => $user,
            'allowedTypes' => $this->allowedTypes,
        ]);
    }

    public function update(Request $request, $id)
{
    $request->validate([
        'user_identifier' => 'required|string|max:190',
        'type'            => 'required|string|in:' . implode(',', $this->allowedTypes),
        'value'           => 'required|numeric',
        'starts_at'       => 'nullable|date',
        'ends_at'         => 'nullable|date|after_or_equal:starts_at',
        'is_active'       => 'nullable|boolean',
    ]);

    $typeCol  = $this->resolveTypeColumn();
    $override = UserBenefitOverride::findOrFail($id);

    $user = $this->findUserByIdentifier($request->input('user_identifier'));
    if (!$user) {
        return back()->withErrors(['user_identifier' => __('User not found by username or email')])->withInput();
    }

    $type  = $request->input('type');
    $value = $this->normalizeValue($type, $request->input('value'));

    // === التواريخ بنفس منطق store ===
    $startsAtInput = trim((string) $request->input('starts_at', ''));
    $endsAtInput   = trim((string) $request->input('ends_at', ''));

    if ($startsAtInput === '') {
        // في التعديل: لو تُركت فارغة نخليها null (بدون نافذة بداية)،
        // ولو تبغى نفس سلوك الإنشاء بالضبط استبدل بالسطر التالي:
        // $startsAt = Carbon::now();
        $startsAt = null;
    } else {
        $startsAt = Carbon::parse($startsAtInput);
        if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $startsAtInput)) {
            $startsAt->setTimeFrom(Carbon::now());
        }
    }

    if ($endsAtInput === '') {
        $endsAt = null;
    } else {
        $endsAt = Carbon::parse($endsAtInput);
        if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $endsAtInput)) {
            $endsAt->setTimeFrom(Carbon::now());
        }
    }

    $override->user_id    = $user->id;
    $override->{$typeCol} = $type;
    $override->value      = $value;
    $override->starts_at  = $startsAt;
    $override->ends_at    = $endsAt;
    $override->is_active  = (bool) $request->boolean('is_active', true);
    $override->save();

    LevelBenefits::flushUser($user);

    return redirect()->route('admin.benefit-overrides.index')
        ->with('notify', [['success', __('Override updated')]]);
}

    public function destroy($id)
    {
        $override = UserBenefitOverride::findOrFail($id);
        $user = User::find($override->user_id);

        $override->delete();
        if ($user) {
            LevelBenefits::flushUser($user);
        }

        Log::info('BenefitOverride:destroy', [
            'id'      => $id,
            'user_id' => $user?->id,
        ]);

        return redirect()->route('admin.benefit-overrides.index')->with('notify', [['success', __('Override deleted')]]);
    }
}
