<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;
use App\Services\SubscriptionLifecycleService;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Artisan::command('subscriptions:expire-due', function (SubscriptionLifecycleService $subscriptionLifecycleService) {
    $targetDate = now()->subDay()->startOfDay();
    $result = $subscriptionLifecycleService->expireSubscriptionsForDate($targetDate);

    $this->info(sprintf(
        'Expired %d subscription(s), revoked %d provision(s), %d provision revoke failure(s).',
        $result['expired_subscriptions'],
        $result['revoked_provisions'],
        $result['failed_provisions'],
    ));
})->purpose('Expire yesterday-ended subscriptions and revoke their remote Outline keys.');

Artisan::command('subscriptions:notify-expiring', function (SubscriptionLifecycleService $subscriptionLifecycleService) {
    $expiringCount = $subscriptionLifecycleService->sendExpiringTomorrowNotifications(now()->startOfDay());

    $this->info(sprintf(
        'Sent expiring reminder notification for %d subscription(s).',
        $expiringCount,
    ));
})->purpose('Notify admins about subscriptions expiring tomorrow.');

Schedule::command('subscriptions:expire-due')
    ->dailyAt('00:05')
    ->timezone(config('app.timezone'))
    ->withoutOverlapping();

Schedule::command('subscriptions:notify-expiring')
    ->dailyAt('18:00')
    ->timezone(config('app.timezone'))
    ->withoutOverlapping();
