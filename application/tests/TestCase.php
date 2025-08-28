<?php

namespace Tests;

use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Database\Seeders\LevelSeeder;

abstract class TestCase extends BaseTestCase
{
    use CreatesApplication;
	
    protected function setUp(): void
    {
        parent::setUp();

        $this->artisan('db:seed', ['--class' => LevelSeeder::class]);
    }
}
