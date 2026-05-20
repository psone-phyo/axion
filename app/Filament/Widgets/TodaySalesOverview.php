<?php

namespace App\Filament\Widgets;

use App\Models\SaleOrder;
use Filament\Support\Icons\Heroicon;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class TodaySalesOverview extends StatsOverviewWidget
{
    protected function getStats(): array
    {
        $todaySales = SaleOrder::query()
            ->paid()
            ->whereDate('paid_at', today())
            ->sum('amount');

        $yesterdaySales = SaleOrder::query()
            ->paid()
            ->whereDate('paid_at', today()->subDay())
            ->sum('amount');

        $difference = $todaySales - $yesterdaySales;

        return [
            Stat::make('Today Sales', '$'.number_format($todaySales, 2))
                ->description($difference >= 0 ? 'Ahead of yesterday' : 'Below yesterday')
                ->descriptionIcon($difference >= 0 ? Heroicon::ArrowTrendingUp : Heroicon::ArrowTrendingDown)
                ->color($difference >= 0 ? 'success' : 'danger')
                ->chart(
                    collect(range(6, 0))
                        ->map(fn (int $daysAgo): float => (float) SaleOrder::query()
                            ->paid()
                            ->whereDate('paid_at', now()->subDays($daysAgo)->toDateString())
                            ->sum('amount'))
                        ->all()
                ),
            Stat::make('Paid Orders Today', SaleOrder::query()->paid()->whereDate('paid_at', today())->count())
                ->icon(Heroicon::Banknotes)
                ->color('success'),
        ];
    }
}
