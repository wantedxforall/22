<?php

use App\Models\User;
use App\Models\Level;

if (!function_exists('formatBenefit')) {
    /**
     * Format a benefit definition to human readable string.
     */
    function formatBenefit(array $b): string
    {
        $value = $b['value'] ?? null;
        $type  = strtolower($b['type'] ?? '');

        if ($value === null) {
            return '';
        }

        return match ($type) {
            'percent', 'percentage', '%' => rtrim((string) $value, '%') . '%',
            'currency', 'amount', 'fixed', 'money', '$' => '$' . number_format((float) $value, 2, '.', ''),
            default => (string) $value,
        };
    }
}

if (!function_exists('userNextLevelData')) {
    /**
     * Retrieve the next level configuration for the given user.
     */
    function userNextLevelData(User $u): array
    {
        $currentMin = (int) ($u->userLevel?->level?->min_points_spent ?? -1);

        $next = Level::where('is_active', true)
            ->where('min_points_spent', '>', $currentMin)
            ->orderBy('min_points_spent')
            ->first();

        if (!$next) {
            return [];
        }

        $data = $next->toArray();
        $data['level']    = $next->id;
        $data['required'] = (int) $next->min_points_spent;

        return $data;
    }
}

if (!function_exists('__laravel_helper_progress')) {
    /**
     * Calculate the percentage progress of the user towards the next level.
     */
    function __laravel_helper_progress(User $u): int
    {
        $next = userNextLevelData($u);
        if (!$next) {
            return 100;
        }

        $required = (int) ($next['required'] ?? 0);
        if ($required <= 0) {
            return 0;
        }

        $points = (int) ($u->points ?? $u->balance ?? 0);
        $progress = (int) floor($points * 100 / $required);

        return max(0, min(100, $progress));
    }
}