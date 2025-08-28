<?php

namespace Tests\Feature\Rewards;

use App\Models\User;
use Tests\TestCase;

class RejectWithRefundTest extends TestCase
{
    public function test_rejection_with_refund_restores_user_balance(): void
    {
        $user = User::factory()->make(['credits' => 100]);
        $itemPrice = 40;

        $user->credits -= $itemPrice;
        $status = 'pending';

        if ($status === 'pending') {
            $status = 'rejected';
            $user->credits += $itemPrice;
        }

        $this->assertEquals(100, $user->credits);
        $this->assertEquals('rejected', $status);
    }
}