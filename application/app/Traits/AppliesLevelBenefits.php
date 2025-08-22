<?php

namespace App\Traits;

use App\Services\LevelingService;
use App\Support\LevelBenefits;

trait AppliesLevelBenefits
{
    /**
     * Map of benefit types to the trait methods handling them.
     */
    protected static array $benefitActions = [
        'reward_multiplier'           => 'rewardMultiplier',
        'buy_points_discount_percent' => 'applyBuyPointsDiscount',
        'bonus_points_percent'        => 'calcBonusPoints',
        'services_discount_percent'   => 'applyServiceDiscount',
        'withdraw_min_reduction_fixed' => 'applyWithdrawAdjustments',
        'withdraw_fee_discount_percent' => 'applyWithdrawAdjustments',
    ];

    /**
     * Cache of user benefits for the duration of the request.
     */
    protected array $levelBenefitsCache = [];

    /**
     * Retrieve benefits for a user as an associative array [type => value].
     */
    protected function getBenefits($user): array
    {
        $userId = $user->id ?? spl_object_id($user);
        if (!isset($this->levelBenefitsCache[$userId])) {
            $this->levelBenefitsCache[$userId] = [];
            foreach (LevelBenefits::getActive($user) as $benefit) {
                $this->levelBenefitsCache[$userId][$benefit['type']] = (float) $benefit['value'];
            }
        }

        return $this->levelBenefitsCache[$userId];
    }

    /**
     * Determine the reward multiplier for a user.
     */
    protected function rewardMultiplier($user): float
    {
        $benefits = $this->getBenefits($user);
        return $benefits['reward_multiplier'] ?? 1.0;
    }
    
    /**
     * Apply a level-based discount when purchasing points.
     *
     * @param float $amount
     * @param mixed $user  User instance with a `level` relation/attribute
     * @return float
     */
    protected function applyBuyPointsDiscount(float $amount, $user): float
    {
        $discount = $this->getBenefitValue($user, 'buy_points_discount_percent');
        return $amount - ($amount * $discount / 100);
    }

    /**
     * Calculate bonus points granted on purchase based on the user's level.
     *
     * @param int   $points  Base purchased points
     * @param mixed $user    User instance with a `level` relation/attribute
     * @return int
     */
    protected function calcBonusPoints(int $points, $user): int
    {
        $bonusPercentage = $this->getBenefitValue($user, 'bonus_points_percent');
        return (int) round($points * $bonusPercentage / 100);
    }

    /**
     * Apply service discount and track the discounted consumption.
     *
     * @param float $cost  Service cost before discount
     * @param mixed $user  User instance
     * @return float       Discounted cost
     */
    protected function applyServiceDiscount(float $cost, $user): float
    {
        $discount = $this->getBenefitValue($user, 'services_discount_percent');
        $discounted = $cost - ($cost * $discount / 100);

         $this->resolveLevelingService()->addPointsConsumption($user, $discounted);

        return $discounted;
    }

    /**
     * Remove previously tracked points consumption (e.g., on refund or cancel).
     *
     * @param mixed $user   User instance
     * @param float $points Points to revert
     * @return void
     */
    protected function removePointsConsumption($user, float $points): void
    {
        $this->resolveLevelingService()->removePointsConsumption($user, $points);
    }

    /**
     * Resolve the leveling service from the application container.
     *
     * Keeping this lookup here allows the trait to be used in classes where
     * constructor injection isn't available while still letting the service be
     * swapped or mocked during testing.
     */
    protected function resolveLevelingService(): LevelingService
    {
        return app(LevelingService::class);
    }

    /**
     * Adjust withdrawal amount based on level-specific fees and minimums.
     *
     * @param float $amount Requested withdrawal amount
     * @param mixed $user   User instance
     * @return float        Final amount after adjustments
     */
    protected function applyWithdrawAdjustments(float $amount, $user): float
    {
        $benefits = $this->getBenefits($user);
         $min = $this->getBenefitValue($user, 'withdraw_min_reduction_fixed');
        $fee = $this->getBenefitValue($user, 'withdraw_fee_discount_percent');

        $amount = max($amount, $min);
        $feeAmount = $amount * $fee / 100;

        return $amount - $feeAmount;
    }

    
    /**
     * Fetch a benefit value for the given user by type.
     */
    protected function getBenefitValue($user, string $type): float
    {
        $benefits = $this->getBenefits($user);

        return $benefits[$type] ?? 0.0;
    }
}