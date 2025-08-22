
<?php

namespace App\Services;

use Illuminate\Support\Facades\Cache;

class ReportingService
{
    public function getTotalPointsSpent(): float
    {
        return (float) Cache::get('stats.total_points_spent', 0);
    }

    public function getMostRedeemedItems(): array
    {
        $items = Cache::get('stats.redeemed_items', []);
        arsort($items);
        return $items;
    }
}