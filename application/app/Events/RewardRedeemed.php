<?php

namespace App\Events;

use App\Models\RewardItem;
use App\Models\User;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class RewardRedeemed
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public User $user;
    public string $reward;
    public float $points;
	
	public function __construct(
        public RewardItem $item,
        public User $user,
        public int $cost,
        public float $multiplier
    ) {
		$this->user = $user;
        $this->reward = $reward;
        $this->points = $points;
    }
}