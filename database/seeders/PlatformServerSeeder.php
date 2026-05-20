<?php

namespace Database\Seeders;

use App\Models\Platform;
use App\Models\Server;
use Illuminate\Database\Seeder;

class PlatformServerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $outline = Platform::query()->where('name', 'Outline VPN')->first();
        $v2ray = Platform::query()->where('name', 'V2Ray Premium')->first();
        $spotify = Platform::query()->where('name', 'Spotify Premium')->first();

        $activeServers = Server::query()->whereIn('name', ['Singapore Edge 01', 'Tokyo Core 01'])->pluck('id')->all();
        $relayServer = Server::query()->where('name', 'Frankfurt Relay 01')->value('id');

        if ($outline) {
            $outline->servers()->sync(array_filter([
                $activeServers[0] ?? null => ['is_active' => true],
                $activeServers[1] ?? null => ['is_active' => true],
                $relayServer => ['is_active' => false],
            ], fn (?array $value, int|string|null $key): bool => filled($key), ARRAY_FILTER_USE_BOTH));
        }

        if ($v2ray) {
            $v2ray->servers()->sync(array_filter([
                $activeServers[0] ?? null => ['is_active' => true],
                $relayServer => ['is_active' => false],
            ], fn (?array $value, int|string|null $key): bool => filled($key), ARRAY_FILTER_USE_BOTH));
        }

        if ($spotify) {
            $spotify->servers()->sync([]);
        }
    }
}
