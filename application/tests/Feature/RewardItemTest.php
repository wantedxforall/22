<?php

namespace Tests\Feature;

use App\Models\RewardItem;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RewardItemTest extends TestCase
{
    use RefreshDatabase;

    public function test_redeeming_decrements_quantity_when_limited(): void
    {
        $user = User::factory()->create();
        $item = RewardItem::create([
            'name' => 'Test',
            'cost' => 10,
            'quantity' => 2,
        ]);

        $this->actingAs($user)
            ->post(route('reward-items.redeem', $item));

        $this->assertEquals(1, $item->fresh()->quantity);
    }
}