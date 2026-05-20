<?php

namespace Database\Factories;

use App\Enums\SubscriptionStatus;
use App\Models\Customer;
use App\Models\Server;
use App\Models\Service;
use App\Models\Subscription;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Subscription>
 */
class SubscriptionFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $startsAt = fake()->dateTimeBetween('-90 days', '+7 days');
        $duration = fake()->randomElement([30, 60, 90, 180, 365]);

        return [
            'customer_id' => Customer::factory(),
            'service_id' => Service::factory(),
            'server_id' => Server::factory(),
            'status' => fake()->randomElement(SubscriptionStatus::cases()),
            'starts_at' => $startsAt,
            'ends_at' => (clone $startsAt)->modify("+{$duration} days"),
            'created_by_user_id' => User::factory(),
        ];
    }
}
