<?php

namespace Tests\Unit;

use App\Services\LevelDiscountService;
use App\Models\User;
use Mockery;
use Tests\TestCase;

class LevelDiscountServiceTest extends TestCase
{
    public function test_multiplier_uses_reward_multiplier_benefit(): void
    {
        $user = User::factory()->make();

        Mockery::mock('alias:App\\Support\\LevelBenefits')
            ->shouldReceive('getActive')
            ->once()
            ->with($user)
            ->andReturn([
                ['type' => 'reward_multiplier', 'value' => 0.5],
            ]);

        $service = new LevelDiscountService();
        $this->assertEquals(0.5, $service->multiplier($user));
    }
}