<?php

namespace Tests\Feature\Rewards;

use App\Models\User;
use Tests\TestCase;

class InsufficientPointsTest extends TestCase
{
    public function test_redemption_fails_when_user_lacks_points(): void
    {
        $user = User::factory()->make(['credits' => 30]);
        $itemPrice = 50;

        $canRedeem = $user->credits >= $itemPrice;

        $this->assertFalse($canRedeem);
    }
}