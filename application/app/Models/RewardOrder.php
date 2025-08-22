<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class RewardOrder extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $with = ['user', 'item'];

    protected $fillable = [
        'user_id',
        'reward_item_id',
        'price_points',
		'token',
		'gift',
        'status',
        'admin_note',
        'acted_by',
        'acted_at',
    ];
	
	public const STATUS_PENDING   = 'pending';
    public const STATUS_APPROVED  = 'approved';
    public const STATUS_REJECTED  = 'rejected';
    public const STATUS_CANCELLED = 'cancelled';


    protected $casts = [
        'acted_at' => 'datetime',
		
    ];
	
	public function statusBadge(): string
    {
        return match ($this->status) {
			self::STATUS_APPROVED  => '<span class="badge badge--success">'.__('Approved').'</span>',
            self::STATUS_REJECTED  => '<span class="badge badge--danger">'.__('Rejected').'</span>',
            self::STATUS_CANCELLED => '<span class="badge badge--warning">'.__('Cancelled').'</span>',
            self::STATUS_PENDING   => '<span class="badge badge--primary">'.__('Pending').'</span>',
            default                => '<span class="badge badge--secondary">'.e($this->status).'</span>',
        };
    }
    // العلاقات
    public function item(): BelongsTo
    {
        return $this->belongsTo(RewardItem::class, 'reward_item_id')->withTrashed();
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function rewardItem(): BelongsTo
    {
        return $this->belongsTo(RewardItem::class)->withTrashed();
    }

    public function actedBy(): BelongsTo
    {
        return $this->belongsTo(Admin::class, 'acted_by');
    }
}
