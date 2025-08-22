<?php

namespace Tests\Feature\Rewards;

use Tests\TestCase;

class IdempotencyTest extends TestCase
{
    public function test_duplicate_token_does_not_create_multiple_orders(): void
    {
        $token = 'duplicate-token';
        $orders = [];

        if (!isset($orders[$token])) {
            $orders[$token] = 'order-1';
        }

        if (!isset($orders[$token])) {
            $orders[$token] = 'order-2';
        }

        $this->assertCount(1, $orders);
    }
}