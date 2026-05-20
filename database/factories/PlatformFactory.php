<?php

namespace Database\Factories;

use App\Enums\PlatformType;
use App\Models\Platform;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Platform>
 */
class PlatformFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $type = fake()->randomElement(PlatformType::cases());

        return [
            'name' => fake()->unique()->company(),
            'type' => $type,
            'description' => fake()->sentence(),
            'is_active' => fake()->boolean(90),
        ];
    }
}
