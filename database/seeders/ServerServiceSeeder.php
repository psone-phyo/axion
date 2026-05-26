<?php

namespace Database\Seeders;

use App\Enums\Region;
use App\Models\Platform;
use App\Models\Server;
use App\Models\Service;
use Illuminate\Database\Seeder;

class ServerServiceSeeder extends Seeder
{
    public function run(): void
    {
        $outline = Platform::query()->where('name', 'Outline')->firstOrFail();
        $v2box = Platform::query()->where('name', 'V2Box')->firstOrFail();

        $servers = [
            [
                'platform_id' => $outline->id,
                'name' => 'Outline SG-1',
                'ip' => '103.10.12.1',
                'api_url' => 'https://outline-sg-1.example.com',
                'region' => Region::Singapore,
                'price' => 12.50,
                'capacity' => 200,
                'is_active' => true,
            ],
            [
                'platform_id' => $outline->id,
                'name' => 'Outline JP-1',
                'ip' => '103.10.12.2',
                'api_url' => 'https://outline-jp-1.example.com',
                'region' => Region::Japan,
                'price' => 13.50,
                'capacity' => 180,
                'is_active' => true,
            ],
            [
                'platform_id' => $v2box->id,
                'name' => 'V2Box US-1',
                'ip' => '103.10.12.3',
                'api_url' => 'https://v2box-us-1.example.com',
                'region' => Region::Usa,
                'price' => 15.00,
                'capacity' => 220,
                'is_active' => true,
            ],
            [
                'platform_id' => $v2box->id,
                'name' => 'V2Box TH-1',
                'ip' => '103.10.12.4',
                'api_url' => 'https://v2box-th-1.example.com',
                'region' => Region::Thailand,
                'price' => 11.00,
                'capacity' => 150,
                'is_active' => true,
            ],
        ];

        foreach ($servers as $server) {
            Server::query()->updateOrCreate(
                ['name' => $server['name']],
                $server,
            );
        }

        $services = [
            [
                'platform_id' => $outline->id,
                'name' => 'Outline 30 Days SG',
                'duration_days' => 30,
                'price' => 6.99,
                'region' => Region::Singapore,
                'is_active' => true,
            ],
            [
                'platform_id' => $outline->id,
                'name' => 'Outline 90 Days JP',
                'duration_days' => 90,
                'price' => 18.99,
                'region' => Region::Japan,
                'is_active' => true,
            ],
            [
                'platform_id' => $v2box->id,
                'name' => 'V2Box 30 Days USA',
                'duration_days' => 30,
                'price' => 7.99,
                'region' => Region::Usa,
                'is_active' => true,
            ],
            [
                'platform_id' => $v2box->id,
                'name' => 'V2Box 60 Days Thailand',
                'duration_days' => 60,
                'price' => 12.99,
                'region' => Region::Thailand,
                'is_active' => true,
            ],
        ];

        foreach ($services as $service) {
            Service::query()->updateOrCreate(
                ['name' => $service['name']],
                $service,
            );
        }
    }
}
