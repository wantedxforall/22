<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RewardCategory extends Model
{
    protected $table = 'reward_categories';

    protected $fillable = ['name', 'slug', 'status', 'sort_order', 'image'];

    protected $casts = [
        'status'     => 'integer',
        'sort_order' => 'integer',
    ];

    public function scopeActive($q)
    {
        return $q->where('status', 1);
    }

    public function items()
    {
        return $this->hasMany(RewardItem::class, 'category_id');
    }
}
