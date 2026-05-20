<?php

namespace Database\Factories;

use App\Models\Platform;
use App\Models\Service;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Service>
 */
class ServiceFactory extends Factory
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
            'name' => fake()->words(2, true),
            'duration_days' => fake()->randomElement([30, 60, 90, 180, 365]),
            'price' => fake()->randomFloat(2, 3, 150),
            'bandwidth_limit' => fake()->optional()->numberBetween(50, 500),
            'device_limit' => fake()->optional()->numberBetween(1, 6),
            'is_active' => fake()->boolean(90),
        ];
    }
}
