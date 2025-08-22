<?php

namespace App\Events;

use App\Models\User;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class PointsSpent
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public User $user;
    public float $points;
    public ?string $description;

    public function __construct(User $user, float $points, ?string $description = null)
    {
        $this->user = $user;
        $this->points = $points;
        $this->description = $description;
    }
}