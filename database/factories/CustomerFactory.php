<?php

namespace Database\Factories;

use App\Enums\CustomerPlatform;
use App\Models\Customer;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Customer>
 */
class CustomerFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'username' => fake()->optional()->userName(),
            'email' => fake()->optional()->safeEmail(),
            'phone' => fake()->optional()->phoneNumber(),
            'platform' => fake()->randomElement(CustomerPlatform::cases()),
            'status' => fake()->boolean(85),
        ];
    }
}
