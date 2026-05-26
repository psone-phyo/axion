<?php

namespace App\Services;

use App\Enums\ProvisionStatus;
use App\Enums\SubscriptionStatus;
use App\Exceptions\NoAvailableServerException;
use App\Models\Server;
use App\Models\Service;
use Illuminate\Support\Facades\DB;

class ServerSelectionService
{
    public function selectForService(Service $service): Server
    {
        $server = Server::query()
            ->where('platform_id', $service->platform_id)
            ->where('region', $service->region)
            ->where('is_active', true)
            ->withCount([
                'provisions as active_subscriptions_count' => fn ($query) => $query
                    ->where('status', ProvisionStatus::Active->value)
                    ->whereHas('subscription', fn ($subscriptionQuery) => $subscriptionQuery
                        ->where('status', SubscriptionStatus::Active->value)),
            ])
            ->having('active_subscriptions_count', '<', DB::raw('capacity'))
            ->orderBy('active_subscriptions_count')
            ->orderBy('id')
            ->first();

        if (! $server) {
            throw new NoAvailableServerException('No available server matched the selected platform and region.');
        }

        return $server;
    }
}
