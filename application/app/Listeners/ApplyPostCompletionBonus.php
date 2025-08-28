<?php

namespace App\Listeners;

use App\Events\PostCompleted;
use App\Support\LevelBenefits;
use App\Services\LevelingService;
use Illuminate\Support\Facades\Log;

class ApplyPostCompletionBonus
{
    public function handle(PostCompleted $event): void
    {
        // ✅ زِد عدّاد الإنجازات للمستويات: 1 لكل منشور مكتمل
        app(LevelingService::class)->addPointsConsumption($event->user, 1);

        Log::info('levels:increment_on_post_completion', [
            'user_id' => $event->user->id,
            'delta'   => 1,
        ]);

        // (اختياري) بونص نقاط الانتهاء من المنشور إن كان مفعّل
        foreach (LevelBenefits::getActive($event->user) as $benefit) {
            if ($benefit['type'] === 'post_completion_bonus_points') {
                $event->user->credits += (int) $benefit['value'];
                $event->user->save();
                break;
            }
        }
    }
}
