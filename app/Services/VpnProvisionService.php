<?php

namespace App\Services;

use App\Enums\ProvisionStatus;
use App\Exceptions\OutlineApiException;
use App\Models\Server;
use App\Models\Service;
use App\Models\Subscription;
use App\Models\SubscriptionProvision;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class VpnProvisionService
{
    public function __construct(
        protected OutlineApiService $outlineApiService,
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
                'outline_access_key_id' => $vpnUser['outline_access_key_id'] ?? $vpnUser['external_user_id'],
                'external_user_id' => $vpnUser['external_user_id'],
                'access_key' => $vpnUser['access_key'],
                'key_name' => $vpnUser['key_name'],
                'outline_method' => $vpnUser['outline_method'] ?? null,
                'outline_port' => $vpnUser['outline_port'] ?? null,
                'data_limit_bytes' => $vpnUser['data_limit_bytes'] ?? null,
                'transferred_bytes' => $vpnUser['transferred_bytes'] ?? 0,
                'last_synced_at' => now(),
                'last_error' => null,
                'status' => ProvisionStatus::Active,
            ]);

            return $subscription->load(['customer', 'service.platform', 'provisions.server']);
        });
    }

    public function createVpnUser(Server $server, Subscription $subscription): array
    {
        if (filled($server->api_url)) {
            return $this->createOutlineAccessKey($server, $subscription);
        }else{
            throw new OutlineApiException('Only servers with API integration are supported for automatic provisioning. Please check the server configuration.');
        }
    }

    public function renameProvisionKey(SubscriptionProvision $provision, string $name): SubscriptionProvision
    {
        if (blank($provision->outline_access_key_id)) {
            throw new OutlineApiException('This provision does not have an Outline access key id.');
        }

        $this->outlineApiService->renameAccessKey($provision->server, $provision->outline_access_key_id, $name);

        $provision->update([
            'key_name' => $name,
            'last_error' => null,
            'last_synced_at' => now(),
        ]);

        return $provision->fresh(['server', 'subscription.customer']);
    }

    public function deleteProvisionKey(SubscriptionProvision $provision): SubscriptionProvision
    {
        if (blank($provision->outline_access_key_id)) {
            throw new OutlineApiException('This provision does not have an Outline access key id.');
        }

        $this->outlineApiService->deleteAccessKey($provision->server, $provision->outline_access_key_id);

        $provision->update([
            'status' => ProvisionStatus::Revoked,
            'last_error' => null,
            'last_synced_at' => now(),
        ]);

        return $provision->fresh(['server', 'subscription.customer']);
    }

    public function setProvisionDataLimit(SubscriptionProvision $provision, int $bytes): SubscriptionProvision
    {
        if (blank($provision->outline_access_key_id)) {
            throw new OutlineApiException('This provision does not have an Outline access key id.');
        }

        $this->outlineApiService->setDataLimit($provision->server, $provision->outline_access_key_id, $bytes);

        $provision->update([
            'data_limit_bytes' => $bytes,
            'last_error' => null,
            'last_synced_at' => now(),
        ]);

        return $provision->fresh(['server', 'subscription.customer']);
    }

    public function removeProvisionDataLimit(SubscriptionProvision $provision): SubscriptionProvision
    {
        if (blank($provision->outline_access_key_id)) {
            throw new OutlineApiException('This provision does not have an Outline access key id.');
        }

        $this->outlineApiService->removeDataLimit($provision->server, $provision->outline_access_key_id);

        $provision->update([
            'data_limit_bytes' => null,
            'last_error' => null,
            'last_synced_at' => now(),
        ]);

        return $provision->fresh(['server', 'subscription.customer']);
    }

    public function syncProvisionTransfer(SubscriptionProvision $provision): SubscriptionProvision
    {
        if (blank($provision->outline_access_key_id)) {
            throw new OutlineApiException('This provision does not have an Outline access key id.');
        }

        $metrics = $this->outlineApiService->getTransferredBytesByAccessKey($provision->server);

        $provision->update([
            'transferred_bytes' => (int) ($metrics[$provision->outline_access_key_id] ?? 0),
            'last_error' => null,
            'last_synced_at' => now(),
        ]);

        return $provision->fresh(['server', 'subscription.customer']);
    }

    protected function createOutlineAccessKey(Server $server, Subscription $subscription): array
    {
        $name = "SUB-{$subscription->id}-{$server->name}";
        $accessKey = $this->outlineApiService->createAccessKey($server, [
            'name' => $name,
        ]);

        return [
            'outline_access_key_id' => (string) $accessKey['id'],
            'external_user_id' => (string) $accessKey['id'],
            'access_key' => $accessKey['accessUrl'],
            'key_name' => $accessKey['name'] ?? $name,
            'outline_method' => $accessKey['method'] ?? null,
            'outline_port' => $accessKey['port'] ?? null,
            'data_limit_bytes' => $accessKey['dataLimit']['bytes'] ?? null,
            'transferred_bytes' => 0,
        ];
    }
}
