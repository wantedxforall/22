<?php

namespace Tests\Feature;

use App\Events\PostCompleted;
use App\Models\User;
use App\Support\LevelBenefits;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Mockery;
use Tests\TestCase;

class PostCompletionBonusTest extends TestCase
{
    use RefreshDatabase;

    protected function migrateUsing(): array
    {
        return [
            '--path' => base_path('database/migrations/2014_10_12_000000_create_users_table.php'),
            '--realpath' => true,
        ];
    }

    public function test_post_completion_bonus_points_are_awarded(): void
    {
        $user = User::factory()->createQuietly(['credits' => 0]);

        $mock = Mockery::mock('alias:' . LevelBenefits::class);
        $mock->shouldReceive('getActive')->once()->with($user)->andReturn([
            ['type' => 'post_completion_bonus_points', 'value' => 5],
        ]);

        event(new PostCompleted($user));

        $this->assertEquals(5, $user->fresh()->credits);
    }
}