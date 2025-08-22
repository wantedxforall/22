<?php

namespace Tests\Feature;

use App\Models\Level;
use App\Models\LevelBenefit;
use App\Models\User;
use App\Models\UserLevel;
use App\Services\LevelingService;
use App\Support\LevelBenefits;
use Database\Seeders\LevelSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Cache;
use Tests\TestCase;

class LevelsTest extends TestCase
{
    use RefreshDatabase;

    protected function migrateUsing(): array
    {
        return [
             '--path' => [
                base_path('database/migrations/2014_10_12_000000_create_users_table.php'),
                base_path('database/migrations/2024_05_27_000000_create_levels_tables.php'),
            ],
            '--realpath' => true,
        ];
    }

    public function test_level_changes_apply_benefits_and_flush_cache(): void
    {
        (new LevelSeeder())->run();

        $silver = Level::where('name', 'Silver')->firstOrFail();
        $gold = Level::where('name', 'Gold')->firstOrFail();

        LevelBenefit::create([
            'level_id' => $silver->id,
            'type' => 'bonus_points_percent',
            'value' => 5,
            'is_active' => true,
        ]);

        LevelBenefit::create([
            'level_id' => $gold->id,
            'type' => 'bonus_points_percent',
            'value' => 10,
            'is_active' => true,
        ]);

    UserLevel::create(['user_id' => $user->id, 'points_spent' => 0]);

    $service = new LevelingService();

        $service->addPointsConsumption($user, 1000);
        $this->assertEquals($silver->id, $user->fresh()->userLevel->level_id);

        $silverBenefits = LevelBenefits::getActive($user);
        $this->assertEquals(5.0, $silverBenefits[0]['value']);
        $versionAfterSilver = Cache::get('levels:version');

        $service->addPointsConsumption($user, 4000);
        $this->assertEquals($gold->id, $user->fresh()->userLevel->level_id);

        $this->assertNotEquals($versionAfterSilver, Cache::get('levels:version'));
        $goldBenefits = LevelBenefits::getActive($user);
        $this->assertEquals(10.0, $goldBenefits[0]['value']);

        $versionAfterGold = Cache::get('levels:version');
        $service->removePointsConsumption($user, 3000);
        $this->assertEquals($silver->id, $user->fresh()->userLevel->level_id);

        $this->assertNotEquals($versionAfterGold, Cache::get('levels:version'));
        $silverBenefitsAgain = LevelBenefits::getActive($user);
        $this->assertEquals(5.0, $silverBenefitsAgain[0]['value']);
    }
}
