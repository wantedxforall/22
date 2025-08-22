<?php

namespace App\Console\Commands;

use App\Models\User;
use App\Services\LevelingService;
use Illuminate\Console\Command;

class RecomputeUserLevels extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'levels:recompute';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Recalculate levels for all users based on their spent points';

    /**
     * Execute the console command.
     */
    public function handle(): int
    {
        $service = app(LevelingService::class);

        User::chunk(100, function ($users) use ($service) {
            foreach ($users as $user) {
                $service->recomputeLevel($user);
            }
        });

        $this->info('User levels recomputed successfully.');

        return Command::SUCCESS;
    }
}
