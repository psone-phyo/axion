<?php

namespace App\Services;

use App\Enums\ProvisionStatus;
use App\Enums\SubscriptionStatus;
use App\Models\Subscription;
use App\Models\SubscriptionProvision;
use App\Models\User;
use Carbon\CarbonInterface;
use Filament\Notifications\Notification;
use Illuminate\Support\Collection;

class SubscriptionLifecycleService
{
    public function __construct(
        protected VpnProvisionService $vpnProvisionService,
    ) {
    }

    /**
     * @return array{expired_subscriptions:int, revoked_provisions:int, failed_provisions:int}
     */
    public function expireSubscriptionsForDate(CarbonInterface $date): array
    {
        $subscriptions = Subscription::query()
            ->with(['provisions.server'])
            ->where('status', SubscriptionStatus::Active)
            ->whereDate('end_date', $date->toDateString())
            ->get();

        $revokedProvisionCount = 0;
        $failedProvisionCount = 0;

        /** @var Subscription $subscription */
        foreach ($subscriptions as $subscription) {
            /** @var SubscriptionProvision $provision */
            foreach ($subscription->provisions as $provision) {
                if ($provision->status === ProvisionStatus::Revoked) {
                    continue;
                }

                if (filled($provision->outline_access_key_id) && filled($provision->server?->api_url)) {
                    try {
                        $this->vpnProvisionService->deleteProvisionKey($provision);
                        $revokedProvisionCount++;
                    } catch (\Throwable $exception) {
                        $provision->update([
                            'last_error' => $exception->getMessage(),
                            'last_synced_at' => now(),
                        ]);

                        $failedProvisionCount++;

                        continue;
                    }
                } else {
                    $provision->update([
                        'status' => ProvisionStatus::Revoked,
                        'last_error' => null,
                        'last_synced_at' => now(),
                    ]);

                    $revokedProvisionCount++;
                }
            }

            $subscription->update([
                'status' => SubscriptionStatus::Expired,
            ]);
        }

        return [
            'expired_subscriptions' => $subscriptions->count(),
            'revoked_provisions' => $revokedProvisionCount,
            'failed_provisions' => $failedProvisionCount,
        ];
    }

    public function sendExpiringTomorrowNotifications(CarbonInterface $today): int
    {
        $expiringDate = $today->copy()->addDay()->toDateString();

        $expiringCount = Subscription::query()
            ->where('status', SubscriptionStatus::Active)
            ->whereDate('end_date', $expiringDate)
            ->count();

        if ($expiringCount === 0) {
            return 0;
        }

        $admins = User::query()->get();

        if ($admins->isEmpty()) {
            return 0;
        }

        $title = 'Subscriptions Expiring Tomorrow';
        $body = sprintf(
            '%d active subscription(s) will expire on %s. Please contact customers for renewal follow-up.',
            $expiringCount,
            $today->copy()->addDay()->format('d M Y'),
        );

        $alreadySent = $admins->first()
            ->notifications()
            ->where('type', \Filament\Notifications\DatabaseNotification::class)
            ->where('data->title', $title)
            ->where('data->body', $body)
            ->exists();

        if ($alreadySent) {
            return $expiringCount;
        }

        Notification::make()
            ->title($title)
            ->body($body)
            ->warning()
            ->persistent()
            ->sendToDatabase($admins, isEventDispatched: true);

        return $expiringCount;
    }
}
