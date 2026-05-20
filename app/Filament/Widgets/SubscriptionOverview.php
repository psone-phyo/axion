<?php

namespace App\Filament\Widgets;

use App\Models\Subscription;
use Filament\Support\Icons\Heroicon;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class SubscriptionOverview extends StatsOverviewWidget
{
    protected function getStats(): array
    {
        $activeCount = Subscription::query()->active()->count();
        $expiredCount = Subscription::query()->expired()->count();
        $newThisWeek = Subscription::query()
            ->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()])
            ->count();

        return [
            Stat::make('Active Subscriptions', $activeCount)
                ->description('Currently usable subscriptions')
                ->descriptionIcon(Heroicon::CheckCircle)
                ->color('success'),
            Stat::make('Expired Subscriptions', $expiredCount)
                ->description('Renewal follow-up needed')
                ->descriptionIcon(Heroicon::ExclamationTriangle)
                ->color('danger'),
            Stat::make('New This Week', $newThisWeek)
                ->description('Fresh activity this week')
                ->descriptionIcon(Heroicon::ArrowTrendingUp)
                ->color('info'),
        ];
    }
}
