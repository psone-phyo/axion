<?php

namespace Database\Seeders;

use App\Models\Platform;
use Illuminate\Database\Seeder;

class PlatformSeeder extends Seeder
{
    public function run(): void
    {
        foreach ([
            ['name' => 'Outline', 'description' => 'Outline VPN platform integration.'],
            ['name' => 'V2Box', 'description' => 'V2Box VPN platform integration.'],
        ] as $platform) {
            Platform::query()->updateOrCreate(
                ['name' => $platform['name']],
                $platform,
            );
        }
    }
}
