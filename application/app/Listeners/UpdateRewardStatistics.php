<?php

namespace App\Listeners;

use App\Events\RewardRedeemed;
use Illuminate\Support\Facades\Cache;

class UpdateRewardStatistics
{
    public function handle(RewardRedeemed $event): void
    {
        $items = Cache::get('stats.redeemed_items', []);
        $items[$event->reward] = ($items[$event->reward] ?? 0) + 1;
        Cache::forever('stats.redeemed_items', $items);
    }
}