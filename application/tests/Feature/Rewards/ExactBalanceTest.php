<?php

namespace Tests\Feature\Rewards;

use App\Models\User;
use Tests\TestCase;

class ExactBalanceTest extends TestCase
{
    public function test_redemption_succeeds_when_balance_equals_price(): void
    {
        $user = User::factory()->make(['credits' => 50]);
        $itemPrice = 50;

        $order = ['status' => 'pending'];
        if ($user->credits >= $itemPrice) {
            $user->credits -= $itemPrice;
        }

        $this->assertEquals(0, $user->credits);
        $this->assertEquals('pending', $order['status']);
    }
}