<?php

namespace Database\Factories;

use App\Enums\AccessKeyType;
use App\Models\AccessKey;
use App\Models\Subscription;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<AccessKey>
 */
class AccessKeyFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'subscription_id' => Subscription::factory(),
            'type' => fake()->randomElement(AccessKeyType::cases()),
            'external_id' => fake()->optional()->uuid(),
            'access_key' => fake()->sha256().fake()->sha256(),
            'username' => fake()->optional()->userName(),
            'is_active' => fake()->boolean(85),
        ];
    }
}
