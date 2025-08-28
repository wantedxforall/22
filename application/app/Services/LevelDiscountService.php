<?php

namespace App\Services;

use App\Models\User;
use App\Traits\AppliesLevelBenefits;

class LevelDiscountService
{
    use AppliesLevelBenefits;

    /**
     * Determine the multiplier to apply to reward costs for a user based on their level benefits.
     */
    public function multiplier(User $user): float
    {
        return $this->rewardMultiplier($user);
    }
}