<?php

namespace App\Services;

use App\Enums\ProvisionStatus;
use App\Models\Server;
use App\Models\Service;
use App\Models\Subscription;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class VpnProvisionService
{
    public function __construct(
        protected ServerSelectionService $serverSelectionService,
    ) {
    }

    public function createSubscriptionWithProvision(array $subscriptionData): Subscription
    {
        return DB::transaction(function () use ($subscriptionData): Subscription {
            $service = Service::query()->findOrFail($subscriptionData['service_id']);

            $subscription = Subscription::query()->create($subscriptionData);
            $server = $this->serverSelectionService->selectForService($service);
            $vpnUser = $this->createVpnUser($server, $subscription);

            $subscription->provisions()->create([
                'server_id' => $server->id,
                'external_user_id' => $vpnUser['external_user_id'],
                'access_key' => $vpnUser['access_key'],
                'key_name' => $vpnUser['key_name'],
                'status' => ProvisionStatus::Active,
            ]);

            return $subscription->load(['customer', 'service.platform', 'provisions.server']);
        });
    }

    public function createVpnUser(Server $server, Subscription $subscription): array
    {
        $token = Str::upper(Str::random(32));
        $externalUserId = sprintf('vpn-%s-%s', $server->id, Str::lower(Str::random(12)));

        return [
            'external_user_id' => $externalUserId,
            'access_key' => sprintf(
                'ss://%s@%s#%s',
                $token,
                $server->ip,
                rawurlencode("SUB-{$subscription->id}-{$server->name}")
            ),
            'key_name' => "SUB-{$subscription->id}-{$server->name}",
        ];
    }
}
