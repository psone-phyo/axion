<?php

namespace Database\Seeders;

use App\Enums\SubscriptionStatus;
use App\Enums\UserRole;
use App\Models\Customer;
use App\Models\Server;
use App\Models\Service;
use App\Models\Subscription;
use App\Models\User;
use Illuminate\Database\Seeder;

class SubscriptionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $customers = Customer::query()->get();
        $services = Service::query()->with(['platform.servers'])->get();
        $creatorId = User::query()->where('role', UserRole::Admin)->value('id') ?? User::query()->value('id');

        foreach ($customers->shuffle()->take(16) as $customer) {
            $service = $services->random();
            $platformServers = $service->platform->servers;

            if ($platformServers->isEmpty()) {
                $serverId = Server::query()->value('id');
            } else {
                $serverId = $platformServers->random()->id;
            }

            $startsAt = now()->subDays(fake()->numberBetween(1, 45));
            $endsAt = (clone $startsAt)->addDays($service->duration_days);
            $status = $endsAt->isPast()
                ? SubscriptionStatus::Expired
                : fake()->randomElement([SubscriptionStatus::Active, SubscriptionStatus::Active, SubscriptionStatus::Suspended]);

            Subscription::query()->create([
                'customer_id' => $customer->id,
                'service_id' => $service->id,
                'server_id' => $serverId,
                'status' => $status,
                'starts_at' => $startsAt,
                'ends_at' => $endsAt,
                'created_by_user_id' => $creatorId,
            ]);
        }
    }
}
