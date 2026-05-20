<?php

namespace Database\Seeders;

use App\Enums\SaleOrderStatus;
use App\Models\SaleOrder;
use App\Models\Subscription;
use Illuminate\Database\Seeder;

class SaleOrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Subscription::query()
            ->with(['customer', 'service'])
            ->get()
            ->each(function (Subscription $subscription): void {
                $status = fake()->randomElement([
                    SaleOrderStatus::Paid,
                    SaleOrderStatus::Paid,
                    SaleOrderStatus::Pending,
                    SaleOrderStatus::Unpaid,
                ]);

                SaleOrder::query()->create([
                    'customer_id' => $subscription->customer_id,
                    'service_id' => $subscription->service_id,
                    'subscription_id' => $subscription->id,
                    'amount' => $subscription->service->price,
                    'status' => $status,
                    'paid_at' => $status === SaleOrderStatus::Paid ? $subscription->starts_at->copy()->addHour() : null,
                ]);
            });
    }
}
