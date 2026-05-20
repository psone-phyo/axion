<?php

namespace App\Filament\Widgets;

use App\Enums\ServerStatus;
use App\Models\Customer;
use App\Models\Server;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class SystemOverview extends StatsOverviewWidget
{
    protected function getStats(): array
    {
        $serverCount = Server::query()->count();
        $activeServers = Server::query()->where('status', ServerStatus::Active)->count();
        $customerCount = Customer::query()->count();

        return [
            Stat::make('Servers', $serverCount)
                ->description("{$activeServers} active nodes")
                ->color('info'),
            Stat::make('Customers', $customerCount)
                ->description('Tracked buyers in the system')
                ->color('success'),
        ];
    }
}
