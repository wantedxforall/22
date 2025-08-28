<?php

namespace App\Listeners;

use App\Events\RewardRedeemed;
use Illuminate\Support\Facades\Log;

class SendRewardRedeemedNotification
{
    public function handle(RewardRedeemed $event): void
    {
        Log::info('Reward redeemed', [
            'user_id' => $event->user->id,
            'reward' => $event->reward,
            'points' => $event->points,
        ]);
    }
}