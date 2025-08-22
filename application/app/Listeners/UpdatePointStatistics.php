<?php

namespace App\Listeners;

use App\Events\PointsSpent;
use Illuminate\Support\Facades\Cache;

class UpdatePointStatistics
{
    public function handle(PointsSpent $event): void
    {
        $total = (float) Cache::get('stats.total_points_spent', 0);
        $total += $event->points;
        Cache::forever('stats.total_points_spent', $total);
    }
}