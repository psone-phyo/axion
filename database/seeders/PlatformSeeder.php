<?php

namespace Database\Seeders;

use App\Enums\PlatformType;
use App\Models\Platform;
use Illuminate\Database\Seeder;

class PlatformSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $platforms = [
            [
                'name' => 'Outline VPN',
                'type' => PlatformType::Vpn,
                'description' => 'VPN services managed through Outline-compatible infrastructure.',
                'is_active' => true,
            ],
            [
                'name' => 'V2Ray Premium',
                'type' => PlatformType::Vpn,
                'description' => 'V2Ray and VLESS-ready subscription products.',
                'is_active' => true,
            ],
            [
                'name' => 'Spotify Premium',
                'type' => PlatformType::Music,
                'description' => 'Music subscription reselling plans.',
                'is_active' => true,
            ],
            [
                'name' => 'Streaming Combo',
                'type' => PlatformType::Other,
                'description' => 'General digital subscription bundles for future services.',
                'is_active' => true,
            ],
        ];

        foreach ($platforms as $platform) {
            Platform::query()->updateOrCreate(
                ['name' => $platform['name']],
                $platform,
            );
        }
    }
}
