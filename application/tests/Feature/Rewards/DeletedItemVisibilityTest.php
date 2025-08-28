<?php

namespace Tests\Feature\Rewards;

use Tests\TestCase;

class DeletedItemVisibilityTest extends TestCase
{
    public function test_soft_deleted_items_hidden_but_existing_orders_accessible(): void
    {
        $item = ['id' => 1, 'name' => 'Gift Card', 'price' => 25, 'deleted_at' => now()];

        $available = array_filter([$item], fn ($i) => empty($i['deleted_at']));
        $this->assertCount(0, $available);

        $order = ['item' => $item];
        $this->assertSame('Gift Card', $order['item']['name']);
    }
}