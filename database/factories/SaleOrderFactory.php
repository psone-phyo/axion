<?php

namespace Database\Factories;

use App\Enums\SaleOrderStatus;
use App\Models\Customer;
use App\Models\SaleOrder;
use App\Models\Service;
use App\Models\Subscription;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<SaleOrder>
 */
class SaleOrderFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $status = fake()->randomElement(SaleOrderStatus::cases());

        return [
            'customer_id' => Customer::factory(),
            'service_id' => Service::factory(),
            'subscription_id' => Subscription::factory(),
            'amount' => fake()->randomFloat(2, 3, 150),
            'status' => $status,
            'paid_at' => $status === SaleOrderStatus::Paid ? fake()->dateTimeBetween('-60 days', 'now') : null,
        ];
    }
}
