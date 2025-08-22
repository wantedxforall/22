<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Log;
use App\Support\LevelBenefits;

class UserBenefitOverride extends Model
{
    protected $table = 'user_benefit_overrides';

    protected $fillable = [
        'user_id',
        'type',          // سنكتب في العمود الفيزيائي الصحيح (type أو benefit_type) عبر الميوتاتور
        'value',
        'is_active',
        'starts_at',
        'ends_at',
    ];

    protected $casts = [
        'value'     => 'float',
        'is_active' => 'bool',
        'starts_at' => 'datetime',
        'ends_at'   => 'datetime',
    ];

    protected static function booted()
    {
        $flush = function (self $ovr) {
            if ($ovr->user_id) {
                Log::info('UserBenefitOverride:flush_after_change', [
                    'id'      => $ovr->id,
                    'user_id' => $ovr->user_id,
                ]);
                LevelBenefits::flushUser($ovr->user);
            }
        };

        static::saved($flush);
        static::deleted($flush);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Accessor يقرأ "type" سواء كان العمود الفعلي اسمه type أو benefit_type
     */
    public function getTypeAttribute($value)
    {
        if ($value !== null) {
            return $value;
        }
        if (array_key_exists('benefit_type', $this->attributes ?? [])) {
            return $this->attributes['benefit_type'];
        }
        return null;
    }

    /**
     * Mutator يكتب في العمود الصحيح فقط لتجنب أخطاء "Unknown column"
     */
    public function setTypeAttribute($value): void
    {
        $col = Schema::hasColumn($this->getTable(), 'type')
            ? 'type'
            : (Schema::hasColumn($this->getTable(), 'benefit_type') ? 'benefit_type' : 'type');

        $this->attributes[$col] = $value;

        // اجعل القيمة متاحة داخل النموذج عبر "type" دائمًا
        if ($col !== 'type') {
            $this->attributes['type'] = $value;
        }
    }

    // سكوبات مساعدة
    public function scopeActive($q)
    {
        return $q->where('is_active', true);
    }

    public function scopeWithinWindow($q, $at = null)
    {
        $now = $at ?: now();

        return $q->where(function ($qq) use ($now) {
                $qq->whereNull('starts_at')->orWhere('starts_at', '<=', $now);
            })
            ->where(function ($qq) use ($now) {
                $qq->whereNull('ends_at')->orWhere('ends_at', '>=', $now);
            });
    }
}
