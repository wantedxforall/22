<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Support\LevelBenefits;

class UserLevel extends Model
{
    use HasFactory;
	
    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'level_id',
        'points_spent',
        'achieved_at',
    ];

    protected $casts = [
        'points_spent' => 'integer',
        'achieved_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function level()
    {
        return $this->belongsTo(Level::class);
    }
    
    public static function progress(User $user): array
    {
        $userLevel = $user->userLevel()->first();
        $currentPoints = (int) ($userLevel->points_spent ?? 0);

        $nextLevel = Level::where('is_active', 1)
            ->where('min_points_spent', '>', $currentPoints)
            ->orderBy('min_points_spent')
            ->first();

        return [
            'points' => $currentPoints,
            'nextLevel' => $nextLevel,
            'pointsToNext' => $nextLevel ? max(0, $nextLevel->min_points_spent - $currentPoints) : 0,
        ];
    }
    
    protected static function booted(): void
    {
        static::saved(function (UserLevel $userLevel) {
            if ($userLevel->wasChanged('level_id')) {
                LevelBenefits::flushUser($userLevel->user);
            }
        });

        static::deleted(function (UserLevel $userLevel) {
            LevelBenefits::flushUser($userLevel->user);
        });
    }
}