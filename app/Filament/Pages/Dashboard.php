<?php

namespace App\Filament\Pages;

use App\Filament\Widgets\DashboardRevenueChart;
use App\Filament\Widgets\DashboardStatsOverview;
use Filament\Widgets\AccountWidget;
use Filament\Pages\Dashboard as BaseDashboard;

class Dashboard extends BaseDashboard
{
    protected static string $routePath = '/';

    // public static function getNavigationUrl(): string
    // {
    //     return url('/admin/');
    // }

    public function getWidgets(): array
    {
        return [
            DashboardStatsOverview::class,
            DashboardRevenueChart::class,
            AccountWidget::class,
        ];
    }
}
