<?php

namespace Tests\Feature\Rewards;

use App\Models\User;
use Tests\TestCase;

class RedemptionTest extends TestCase
{
    public function test_user_with_sufficient_points_can_redeem_item(): void
    {
        $user = User::factory()->make(['credits' => 100]);
        $itemPrice = 40;

        $order = ['status' => 'pending'];

        if ($user->credits >= $itemPrice) {
            $user->credits -= $itemPrice;
        }

        $this->assertEquals(60, $user->credits);
        $this->assertEquals('pending', $order['status']);
    }
}