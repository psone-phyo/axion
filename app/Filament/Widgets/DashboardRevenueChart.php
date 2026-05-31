<?php

namespace App\Filament\Widgets;

use App\Models\SubscriptionPayment;
use Carbon\Carbon;
use Filament\Support\RawJs;
use Filament\Widgets\ChartWidget;

class DashboardRevenueChart extends ChartWidget
{
    protected string $color = 'primary';

    protected ?string $heading = 'Revenue by Day';

    protected ?string $maxHeight = '320px';

    protected int | string | array $columnSpan = 'full';

    public function mount(): void
    {
        $this->filter = now()->format('Y-m');

        parent::mount();
    }

    protected function getType(): string
    {
        return 'bar';
    }

    public function getDescription(): ?string
    {
        $month = $this->getSelectedMonth();
        $total = (float) SubscriptionPayment::query()
            ->whereBetween('created_at', [$month->copy()->startOfMonth(), $month->copy()->endOfMonth()])
            ->sum('final_price');

        return sprintf(
            '%s total revenue: %s',
            $month->format('F Y'),
            number_format($total, 2),
        );
    }

    protected function getData(): array
    {
        $month = $this->getSelectedMonth();
        $labels = [];
        $data = [];

        for ($day = 1; $day <= $month->daysInMonth; $day++) {
            $date = $month->copy()->day($day);

            $labels[] = $date->format('j');
            $data[] = (float) SubscriptionPayment::query()
                ->whereDate('created_at', $date)
                ->sum('final_price');
        }

        return [
            'datasets' => [
                [
                    'label' => 'Revenue',
                    'data' => $data,
                    'borderRadius' => 6,
                    'backgroundColor' => 'rgb(14, 165, 233)',
                    'borderColor' => 'rgb(2, 132, 199)',
                ],
            ],
            'labels' => $labels,
        ];
    }

    protected function getFilters(): ?array
    {
        return collect(range(0, 11))
            ->mapWithKeys(function (int $monthsAgo): array {
                $month = now()->startOfMonth()->subMonths($monthsAgo);

                return [$month->format('Y-m') => $month->format('F Y')];
            })
            ->all();
    }

    protected function getOptions(): array | RawJs | null
    {
        return [
            'plugins' => [
                'legend' => [
                    'display' => false,
                ],
            ],
            'scales' => [
                'y' => [
                    'beginAtZero' => true,
                ],
            ],
        ];
    }

    protected function getSelectedMonth(): Carbon
    {
        $selectedMonth = $this->filter ?: now()->format('Y-m');

        return Carbon::createFromFormat('Y-m', $selectedMonth)->startOfMonth();
    }
}
