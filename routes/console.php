<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Schedule;
use App\Services\SubscriptionLifecycleService;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Artisan::command('subscriptions:expire-due', function (SubscriptionLifecycleService $subscriptionLifecycleService) {
    $targetDate = now()->subDay()->startOfDay();
    $commandName = 'subscriptions:expire-due';

    Log::info('Scheduled command started.', [
        'command' => $commandName,
        'target_date' => $targetDate->toDateString(),
        'run_at' => now()->toDateTimeString(),
    ]);

    try {
        $result = $subscriptionLifecycleService->expireSubscriptionsForDate($targetDate);
    } catch (Throwable $exception) {
        Log::error('Scheduled command failed.', [
            'command' => $commandName,
            'target_date' => $targetDate->toDateString(),
            'message' => $exception->getMessage(),
            'exception' => $exception::class,
        ]);

        throw $exception;
    }

    Log::info('Scheduled command completed.', [
        'command' => $commandName,
        'target_date' => $targetDate->toDateString(),
        'expired_subscriptions' => $result['expired_subscriptions'],
        'revoked_provisions' => $result['revoked_provisions'],
        'failed_provisions' => $result['failed_provisions'],
    ]);

    $this->info(sprintf(
        'Expired %d subscription(s), revoked %d provision(s), %d provision revoke failure(s).',
        $result['expired_subscriptions'],
        $result['revoked_provisions'],
        $result['failed_provisions'],
    ));
})->purpose('Expire yesterday-ended subscriptions and revoke their remote Outline keys.');

Artisan::command('subscriptions:notify-expiring', function (SubscriptionLifecycleService $subscriptionLifecycleService) {
    $commandName = 'subscriptions:notify-expiring';
    $targetDate = now()->startOfDay()->addDay();

    Log::info('Scheduled command started.', [
        'command' => $commandName,
        'target_date' => $targetDate->toDateString(),
        'run_at' => now()->toDateTimeString(),
    ]);

    try {
        $expiringCount = $subscriptionLifecycleService->sendExpiringTomorrowNotifications(now()->startOfDay());
    } catch (Throwable $exception) {
        Log::error('Scheduled command failed.', [
            'command' => $commandName,
            'target_date' => $targetDate->toDateString(),
            'message' => $exception->getMessage(),
            'exception' => $exception::class,
        ]);

        throw $exception;
    }

    Log::info('Scheduled command completed.', [
        'command' => $commandName,
        'target_date' => $targetDate->toDateString(),
        'expiring_subscriptions' => $expiringCount,
    ]);

    $this->info(sprintf(
        'Sent expiring reminder notification for %d subscription(s).',
        $expiringCount,
    ));
})->purpose('Notify admins about subscriptions expiring tomorrow.');

Schedule::command('subscriptions:expire-due')
    ->name('subscriptions:expire-due')
    ->dailyAt('00:05')
    ->timezone(config('app.timezone'))
    ->withoutOverlapping();

Schedule::command('subscriptions:notify-expiring')
    ->name('subscriptions:notify-expiring')
    ->dailyAt('18:00')
    ->timezone(config('app.timezone'))
    ->withoutOverlapping();
