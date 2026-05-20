<?php

namespace App\Filament\Pages;

use App\Filament\Widgets\LatestSales;
use App\Filament\Widgets\RevenueTrend;
use App\Filament\Widgets\SubscriptionOverview;
use App\Filament\Widgets\SystemOverview;
use App\Filament\Widgets\TodaySalesOverview;
use Filament\Pages\Dashboard as BaseDashboard;

class Dashboard extends BaseDashboard
{
    public function getHeaderWidgets(): array
    {
        return [
            TodaySalesOverview::class,
            SubscriptionOverview::class,
            SystemOverview::class,
            RevenueTrend::class,
            LatestSales::class,
        ];
    }

    public function getHeaderWidgetsColumns(): int|array
    {
        return [
            'md' => 2,
            'xl' => 4,
        ];
    }
}
