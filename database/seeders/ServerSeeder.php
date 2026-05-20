<?php

namespace Database\Seeders;

use App\Enums\ServerProvider;
use App\Enums\ServerStatus;
use App\Models\Server;
use Illuminate\Database\Seeder;

class ServerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $servers = [
            [
                'name' => 'Singapore Edge 01',
                'ip_address' => '203.0.113.10',
                'region' => 'Singapore',
                'provider' => ServerProvider::DigitalOcean,
                'api_url' => 'https://api.digitalocean.com/v2',
                'api_key' => 'do_sg_edge_token',
                'status' => ServerStatus::Active,
            ],
            [
                'name' => 'Tokyo Core 01',
                'ip_address' => '198.51.100.20',
                'region' => 'Tokyo',
                'provider' => ServerProvider::Manual,
                'api_url' => null,
                'api_key' => null,
                'status' => ServerStatus::Active,
            ],
            [
                'name' => 'Frankfurt Relay 01',
                'ip_address' => '192.0.2.30',
                'region' => 'Frankfurt',
                'provider' => ServerProvider::DigitalOcean,
                'api_url' => 'https://api.digitalocean.com/v2',
                'api_key' => 'do_fr_relay_token',
                'status' => ServerStatus::Maintenance,
            ],
            [
                'name' => 'New York Backup 01',
                'ip_address' => '203.0.113.40',
                'region' => 'New York',
                'provider' => ServerProvider::Manual,
                'api_url' => null,
                'api_key' => null,
                'status' => ServerStatus::Offline,
            ],
        ];

        foreach ($servers as $server) {
            Server::query()->updateOrCreate(
                ['name' => $server['name']],
                $server,
            );
        }
    }
}
