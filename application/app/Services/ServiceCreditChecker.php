<?php

namespace App\Services;

use App\Models\Service;
use App\Models\User;
use App\Models\ServiceView;
use Psr\Log\LoggerInterface;

class ServiceCreditChecker
{
    
	public function __construct(private LoggerInterface $logger)
    {
    }

	/**
     * Deactivate any active services whose allocated credits
     * exceed the current available credits of the user.
     */
    public static function run(User $user): void
    {	
		   app(self::class)->runInstance($user);
    }

    public function runInstance(User $user): void
    {
        $this->logger->info('Checking service credits', ['user_id' => $user->id]);

        $services = Service::where('user_id', $user->id)
            ->where('status', 1)
            ->orderBy('id')
            ->get();

        $total = 0;
        foreach ($services as $service) {
            $total += $service->allocated_credits;
            if ($total > $user->credits) {
				$this->logger->warning('Deactivating service: credits exceed balance', [
                    'user_id'        => $user->id,
                    'order_id'       => $service->id,
                    'points_changed' => 0,
                    'reason'         => 'allocated_credits_exceed_user_credits',
                ]);
                $service->status = 0;
                $service->save();
            }
        }
    }

    public function check(): void
    {
        Service::where('status', 1)->chunkById(100, function ($services) {
            foreach ($services as $service) {
                $spent = ServiceView::where('service_id', $service->id)->sum('credits');
                $service->spent_credits = $spent;
                $this->logger->info('Updated spent credits', [
                    'user_id'        => $service->user_id,
                    'order_id'       => $service->id,
                    'points_changed' => 0,
                    'reason'         => 'spent_credits_calculated',
                ]);
                if ($service->spent_credits >= $service->allocated_credits) {
                    $this->logger->warning('Deactivating service: all credits spent', [
                        'user_id'        => $service->user_id,
                        'order_id'       => $service->id,
                        'points_changed' => 0,
                        'reason'         => 'spent_credits_exhausted',
                    ]);
                    $service->status = 0;
                }
                $service->save();
            }
        });
    }
}