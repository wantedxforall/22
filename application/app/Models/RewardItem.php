<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\HtmlString;

class RewardItem extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'reward_items';

    // استخدم fillable فقط (وأزل guarded)
    protected $fillable = [
        'name',
        'price_points',
        'description',
        'image',
        'is_active',
        'quantity',
        'delivery_method',
		'category_id',
    ];

    protected $casts = [
        'price_points' => 'integer',
        'is_active'    => 'boolean',
    ];

    // علاقة الطلبات (اترك الاسم كما تستخدمه في بقية المشروع)
    public function rewardOrders()
    {
        // لو اسم العمود المفتاح الأجنبي غير reward_item_id عدله هنا:
        // return $this->hasMany(RewardOrder::class, 'reward_item_id');
        return $this->hasMany(RewardOrder::class);
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', 1);
    }

    public function statusBadge(): HtmlString
    {
        return new HtmlString(
            $this->is_active
                ? '<span class="badge badge--success">'.trans('Active').'</span>'
                : '<span class="badge badge--danger">'.trans('Inactive').'</span>'
        );
    }

    public function decrementQuantity(): void
    {
        if (!is_null($this->quantity)) {
            $this->quantity = max(0, $this->quantity - 1);
            $this->save();
        }
    }

    public function hasStock(): bool
    {
        return is_null($this->quantity) || $this->quantity > 0;
    }
	
	public function category()
{
    return $this->belongsTo(RewardCategory::class, 'category_id');
}

}

