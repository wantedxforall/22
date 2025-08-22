<?php

namespace App\Providers;

use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use App\Events\PointsSpent;
use App\Events\RewardRedeemed;
use App\Listeners\UpdatePointStatistics;
use App\Events\PostCompleted;
use App\Listeners\UpdateRewardStatistics;
use App\Listeners\ApplyPostCompletionBonus;
use App\Listeners\SendRewardRedeemedNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Event;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * @var array<class-string, array<int, class-string>>
     */
    protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
		PointsSpent::class => [
            UpdatePointStatistics::class,
        ],
        RewardRedeemed::class => [
            UpdateRewardStatistics::class,
            SendRewardRedeemedNotification::class,
        ],
         PostCompleted::class => [
            ApplyPostCompletionBonus::class,
        ],
    ];

    /**
     * Register any events for your application.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    /**
     * Determine if events and listeners should be automatically discovered.
     *
     * @return bool
     */
    public function shouldDiscoverEvents()
    {
        return false;
    }
}
