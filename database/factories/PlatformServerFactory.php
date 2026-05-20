<?php

namespace Database\Factories;

use App\Models\Platform;
use App\Models\PlatformServer;
use App\Models\Server;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<PlatformServer>
 */
class PlatformServerFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'platform_id' => Platform::factory(),
            'server_id' => Server::factory(),
            'is_active' => fake()->boolean(90),
        ];
    }
}
