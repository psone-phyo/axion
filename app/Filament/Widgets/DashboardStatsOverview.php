<?php

namespace App\Filament\Widgets;

use App\Enums\SubscriptionStatus;
use App\Models\Customer;
use App\Models\Subscription;
use App\Models\SubscriptionPayment;
use Carbon\Carbon;
use Filament\Support\Enums\IconPosition;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Collection;

class DashboardStatsOverview extends StatsOverviewWidget
{
    protected ?string $heading = 'Quick Overview';

    protected function getStats(): array
    {
        $today = now()->startOfDay();

        $customerCount = Customer::query()->count();
        $customerCountSevenDaysAgo = Customer::query()
            ->where('created_at', '<', $today->copy()->subDays(7))
            ->count();

        $activeSubscriptionCount = Subscription::query()
            ->where('status', SubscriptionStatus::Active)
            ->count();

        $activeSubscriptionCountSevenDaysAgo = $this->getActiveSubscriptionCountForDate($today->copy()->subDays(7));

        $todayRevenue = (float) SubscriptionPayment::query()
            ->whereDate('created_at', $today)
            ->sum('final_price');

        $yesterdayRevenue = (float) SubscriptionPayment::query()
            ->whereDate('created_at', $today->copy()->subDay())
            ->sum('final_price');

        return [
            $this->makeCountStat(
                label: 'Customers',
                value: $customerCount,
                previousValue: $customerCountSevenDaysAgo,
                chart: $this->getCustomerGrowthChart(),
            ),
            $this->makeCountStat(
                label: 'Active Subscriptions',
                value: $activeSubscriptionCount,
                previousValue: $activeSubscriptionCountSevenDaysAgo,
                chart: $this->getActiveSubscriptionChart(),
            ),
            $this->makeRevenueStat(
                label: 'Revenue Today',
                value: $todayRevenue,
                previousValue: $yesterdayRevenue,
                chart: $this->getDailyRevenueChart(),
            ),
        ];
    }

    protected function makeCountStat(string $label, int $value, int $previousValue, array $chart): Stat
    {
        $difference = $value - $previousValue;
        $isUp = $difference > 0;
        $isDown = $difference < 0;

        return Stat::make($label, number_format($value))
            ->description($this->formatComparisonDescription($difference, $previousValue, 'vs 7 days ago'))
            ->descriptionIcon(
                $isUp ? 'heroicon-m-arrow-trending-up' : ($isDown ? 'heroicon-m-arrow-trending-down' : 'heroicon-m-minus'),
                IconPosition::Before,
            )
            ->color($isUp ? 'success' : ($isDown ? 'danger' : 'gray'))
            ->chart($chart);
    }

    protected function makeRevenueStat(string $label, float $value, float $previousValue, array $chart): Stat
    {
        $difference = $value - $previousValue;
        $isUp = $difference > 0;
        $isDown = $difference < 0;

        return Stat::make($label, $this->formatMoney($value))
            ->description($this->formatComparisonDescription($difference, $previousValue, 'vs yesterday', true))
            ->descriptionIcon(
                $isUp ? 'heroicon-m-arrow-trending-up' : ($isDown ? 'heroicon-m-arrow-trending-down' : 'heroicon-m-minus'),
                IconPosition::Before,
            )
            ->color($isUp ? 'success' : ($isDown ? 'danger' : 'gray'))
            ->chart($chart);
    }

    protected function formatComparisonDescription(int|float $difference, int|float $previousValue, string $suffix, bool $isCurrency = false): string
    {
        if ($difference === 0.0 || $difference === 0) {
            return "No change {$suffix}";
        }

        $absoluteDifference = abs($difference);
        $formattedDifference = $isCurrency
            ? $this->formatMoney((float) $absoluteDifference)
            : number_format((float) $absoluteDifference, 0);

        $direction = $difference > 0 ? 'up' : 'down';

        if ($previousValue > 0) {
            $percentage = round(($absoluteDifference / $previousValue) * 100, 1);

            return "{$direction} {$formattedDifference} ({$percentage}%) {$suffix}";
        }

        return "{$direction} {$formattedDifference} {$suffix}";
    }

    protected function getCustomerGrowthChart(): array
    {
        return $this->getLastSevenDays()
            ->map(fn (Carbon $day): float => (float) Customer::query()->where('created_at', '<=', $day->copy()->endOfDay())->count())
            ->all();
    }

    protected function getActiveSubscriptionChart(): array
    {
        return $this->getLastSevenDays()
            ->map(fn (Carbon $day): float => (float) $this->getActiveSubscriptionCountForDate($day))
            ->all();
    }

    protected function getDailyRevenueChart(): array
    {
        return $this->getLastSevenDays()
            ->map(fn (Carbon $day): float => (float) SubscriptionPayment::query()->whereDate('created_at', $day)->sum('final_price'))
            ->all();
    }

    protected function getActiveSubscriptionCountForDate(Carbon $date): int
    {
        return Subscription::query()
            ->where('start_date', '<=', $date->toDateString())
            ->where('end_date', '>=', $date->toDateString())
            ->where('status', '!=', SubscriptionStatus::Cancelled->value)
            ->count();
    }

    protected function getLastSevenDays(): Collection
    {
        return collect(range(6, 0))
            ->map(fn (int $daysAgo): Carbon => now()->startOfDay()->subDays($daysAgo));
    }

    protected function formatMoney(float $amount): string
    {
        return number_format($amount, 2);
    }
}
