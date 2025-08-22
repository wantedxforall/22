<?php

namespace App\Support;

use App\Models\User;
use App\Models\UserBenefitOverride;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Schema;

class LevelBenefits
{
    /**
     * احضر مزايا المستخدم الفعالة (مزايا المستوى + أي Overrides ضمن النافذة) مع كاش قصير.
     * - يدعم تلقائياً اختلاف اسم عمود النوع في جدول overrides (type / benefit_type).
     * - يسجل LOG تفصيلي لتتبع المشاكل.
     *
     * @return array<int, array{type:string, value:float}>
     */
    public static function getActive(User $user): array
    {
        $ttlSeconds = (int) config('levels.cache_ttl', 300); // افتراضي 5 دقائق
        $version    = Cache::get('levels:version', 1);
        $cacheKey   = "levels:user:{$user->id}:v{$version}";

        $cached = Cache::get($cacheKey);
        if ($cached !== null) {
            Log::info('LevelBenefits:getActive:start', [
                'user_id'   => $user->id,
                'cache_hit' => true,
                'cache_key' => $cacheKey,
                'version'   => $version,
            ]);
            return $cached;
        }

        Log::info('LevelBenefits:getActive:start', [
            'user_id'   => $user->id,
            'cache_hit' => false,
            'cache_key' => $cacheKey,
            'version'   => $version,
        ]);

        $benefits = [];

        // 1) مزايا المستوى الفعالة
        try {
            if (method_exists($user, 'userLevel')) {
                $userLevel = $user->userLevel()->with(['level.benefits' => function ($q) {
                    $q->where('is_active', true);
                }])->first();

                if ($userLevel && $userLevel->level) {
                    foreach ($userLevel->level->benefits as $b) {
                        $benefits[$b->type] = (float) $b->value;
                    }
                }
            }
        } catch (\Throwable $e) {
            Log::warning('LevelBenefits:getActive:userLevel_error', [
                'user_id' => $user->id,
                'error'   => $e->getMessage(),
            ]);
        }

        Log::info('LevelBenefits:getActive:level_benefits', [
            'user_id'  => $user->id,
            'benefits' => $benefits,
        ]);

        // 2) Overrides ضمن نافذة الوقت
        $now     = now();
        $typeCol = Schema::hasColumn('user_benefit_overrides', 'type')
            ? 'type'
            : (Schema::hasColumn('user_benefit_overrides', 'benefit_type') ? 'benefit_type' : 'type');

        $overrides = UserBenefitOverride::query()
            ->where('user_id', $user->id)
            ->where('is_active', true)
            ->where(function ($q) use ($now) {
                $q->whereNull('starts_at')->orWhere('starts_at', '<=', $now);
            })
            ->where(function ($q) use ($now) {
                $q->whereNull('ends_at')->orWhere('ends_at', '>=', $now);
            })
            ->orderBy('updated_at', 'desc')
            ->get([$typeCol . ' as type', 'value']);

        $applied = [];
        foreach ($overrides as $ovr) {
            $benefits[$ovr->type] = (float) $ovr->value;
            $applied[$ovr->type]  = (float) $ovr->value;
        }

        Log::info('LevelBenefits:getActive:overrides_applied', [
            'user_id'   => $user->id,
            'type_col'  => $typeCol,
            'applied'   => $applied,
        ]);

        // 3) إخراج موحد
        $out = [];
        foreach ($benefits as $type => $value) {
            $out[] = ['type' => $type, 'value' => (float) $value];
        }

        Log::info('LevelBenefits:getActive:final', [
            'user_id' => $user->id,
            'final'   => $out,
        ]);

        Cache::put($cacheKey, $out, $ttlSeconds);
        return $out;
    }

    /**
     * إبطال الكاش للمستخدم (بزيادة رقم النسخة العامة).
     */
    public static function flushUser(?User $user): void
    {
        try {
            if (!Cache::has('levels:version')) {
                Cache::forever('levels:version', 1);
            } else {
                Cache::increment('levels:version');
            }
            \Log::info('LevelBenefits:flushUser', [
                'user_id'     => $user?->id,
                'new_version' => Cache::get('levels:version'),
            ]);
        } catch (\Throwable $e) {
            \Log::warning('LevelBenefits:flushUser:error', [
                'error' => $e->getMessage(),
            ]);
        }
    }
}
