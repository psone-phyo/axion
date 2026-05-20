<?php

namespace Database\Seeders;

use App\Models\Platform;
use App\Models\Service;
use Illuminate\Database\Seeder;

class ServiceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $services = [
            'Outline VPN' => [
                ['name' => 'Outline Basic 30 Days', 'duration_days' => 30, 'price' => 5.99, 'bandwidth_limit' => 100, 'device_limit' => 1, 'is_active' => true],
                ['name' => 'Outline Standard 90 Days', 'duration_days' => 90, 'price' => 14.99, 'bandwidth_limit' => 300, 'device_limit' => 3, 'is_active' => true],
            ],
            'V2Ray Premium' => [
                ['name' => 'VLESS Personal 30 Days', 'duration_days' => 30, 'price' => 6.99, 'bandwidth_limit' => 150, 'device_limit' => 2, 'is_active' => true],
                ['name' => 'V2Ray Family 90 Days', 'duration_days' => 90, 'price' => 19.99, 'bandwidth_limit' => 500, 'device_limit' => 5, 'is_active' => true],
            ],
            'Spotify Premium' => [
                ['name' => 'Spotify Individual 30 Days', 'duration_days' => 30, 'price' => 4.99, 'bandwidth_limit' => null, 'device_limit' => 1, 'is_active' => true],
                ['name' => 'Spotify Duo 30 Days', 'duration_days' => 30, 'price' => 7.99, 'bandwidth_limit' => null, 'device_limit' => 2, 'is_active' => true],
            ],
            'Streaming Combo' => [
                ['name' => 'Streaming Starter 30 Days', 'duration_days' => 30, 'price' => 9.99, 'bandwidth_limit' => null, 'device_limit' => 2, 'is_active' => true],
                ['name' => 'Streaming Plus 90 Days', 'duration_days' => 90, 'price' => 24.99, 'bandwidth_limit' => null, 'device_limit' => 4, 'is_active' => true],
            ],
        ];

        foreach ($services as $platformName => $platformServices) {
            $platform = Platform::query()->where('name', $platformName)->first();

            if (! $platform) {
                continue;
            }

            foreach ($platformServices as $service) {
                Service::query()->updateOrCreate(
                    [
                        'platform_id' => $platform->id,
                        'name' => $service['name'],
                    ],
                    $service,
                );
            }
        }
    }
}
