<?php

namespace App\Filament\Widgets;

use App\Models\SaleOrder;
use Carbon\Carbon;
use Filament\Widgets\ChartWidget;

class RevenueTrend extends ChartWidget
{
    protected ?string $heading = 'Revenue Trend';

    protected function getData(): array
    {
        $dailyRevenue = collect(range(6, 0))
            ->mapWithKeys(function (int $daysAgo): array {
                $date = now()->subDays($daysAgo)->toDateString();

                return [
                    $date => (float) SaleOrder::query()
                        ->paid()
                        ->whereDate('paid_at', $date)
                        ->sum('amount'),
                ];
            });

        return [
            'datasets' => [
                [
                    'label' => 'Revenue',
                    'data' => $dailyRevenue->values()->all(),
                    'borderColor' => '#d97706',
                    'backgroundColor' => 'rgba(217, 119, 6, 0.15)',
                ],
            ],
            'labels' => $dailyRevenue->keys()->map(fn (string $date): string => Carbon::parse($date)->format('M d'))->all(),
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }
}
