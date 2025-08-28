<?php

namespace Tests\Unit;

use App\Services\LevelingService;
use Tests\TestCase;

class LevelingServiceResolutionTest extends TestCase
{
    /** @test */
    public function service_can_be_resolved_from_container(): void
    {
        $service = app(LevelingService::class);

        $this->assertInstanceOf(LevelingService::class, $service);
    }
}