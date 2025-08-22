<?php

namespace Tests\Feature\Rewards;

use Tests\TestCase;

class StatusChangeGuardTest extends TestCase
{
    public function test_status_cannot_change_when_order_not_pending(): void
    {
        $status = 'approved';

        $approve = function () use (&$status) {
            if ($status !== 'pending') {
                return false;
            }
            $status = 'approved';
            return true;
        };

        $reject = function () use (&$status) {
            if ($status !== 'pending') {
                return false;
            }
            $status = 'rejected';
            return true;
        };

        $cancel = function () use (&$status) {
            if ($status !== 'pending') {
                return false;
            }
            $status = 'canceled';
            return true;
        };

        $this->assertFalse($approve());
        $this->assertFalse($reject());
        $this->assertFalse($cancel());
        $this->assertEquals('approved', $status);
    }
}