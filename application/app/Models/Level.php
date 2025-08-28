<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Cache\TaggableStore; // لو درايفر الكاش يدعم Tags (redis/memcached)
use Illuminate\Database\Eloquent\Builder;

class Level extends Model
{
    protected $fillable = [
        'name',
        'min_points_spent',
        'priority',
        'badge',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    protected static function booted(): void
    {
        static::saved(function (Level $level) {
            self::flushCaches();
        });

        static::deleted(function (Level $level) {
            self::flushCaches();
        });
    }

    /**
     * علاقة المزايا
     */
    public function benefits()
    {
        return $this->hasMany(LevelBenefit::class, 'level_id');
    }

    /**
     * Get a specific benefit value from the loaded relationship.
     */
    protected function getBenefitValue(string $type): float
    {
        $this->loadMissing('benefits');

        $benefit = $this->benefits
            ->where('is_active', true)
            ->firstWhere('type', $type);

        return $benefit ? (float) $benefit->value : 0.0;
    }

    public function getBonusPointsAttribute(): float
    {
        return $this->getBenefitValue('bonus_points_percent');
    }

    public function getBuyPointsDiscountAttribute(): float
    {
        return $this->getBenefitValue('buy_points_discount_percent');
    }

    public function getServiceDiscountAttribute(): float
    {
        return $this->getBenefitValue('services_discount_percent');
    }

    public function getWithdrawFeeAttribute(): float
    {
        return $this->getBenefitValue('withdraw_fee_discount_percent');
    }

    public function getWithdrawMinAttribute(): float
    {
        return $this->getBenefitValue('withdraw_min_reduction_fixed');
    }

    /**
     * سكوب المستويات الفعّالة: Level::active()->...
     */
    public function scopeActive(Builder $query): Builder
    {
        return $query->where('is_active', 1);
    }

    /**
     * Flush all caches related to levels & benefits safely for any cache driver.
     */
    public static function flushCaches(): void
    {
        $store = cache()->getStore();

        // إن كان الدرايفر يدعم التاقز
        if ($store instanceof TaggableStore) {
            cache()->tags(['levels', 'level_benefits'])->flush();
            return;
        }

        // وإلا: مفاتيح مباشرة + versioning
        cache()->forget('levels:active_with_benefits');
        cache()->forget('levels:all');

        if (!cache()->has('levels:version')) {
            cache()->forever('levels:version', 1);
        } else {
            cache()->increment('levels:version');
        }
    }
}
