<?php

namespace Database\Seeders;

use App\Enums\AccessKeyType;
use App\Enums\PlatformType;
use App\Models\AccessKey;
use App\Models\Subscription;
use Illuminate\Database\Seeder;

class AccessKeySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Subscription::query()
            ->with(['customer', 'service.platform'])
            ->get()
            ->filter(fn (Subscription $subscription): bool => $subscription->service->platform->type === PlatformType::Vpn)
            ->each(function (Subscription $subscription): void {
                AccessKey::query()->create([
                    'subscription_id' => $subscription->id,
                    'type' => fake()->randomElement([AccessKeyType::Outline, AccessKeyType::Vless, AccessKeyType::V2Box]),
                    'external_id' => fake()->uuid(),
                    'access_key' => sprintf(
                        'ss://%s@%s/%s',
                        fake()->sha1(),
                        fake()->domainName(),
                        fake()->bothify('key-####')
                    ),
                    'username' => $subscription->customer->username ?: fake()->userName(),
                    'is_active' => ! $subscription->isExpired(),
                ]);
            });
    }
}
