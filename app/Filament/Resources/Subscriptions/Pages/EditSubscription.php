<?php

namespace App\Filament\Resources\Subscriptions\Pages;

use App\Enums\ProvisionStatus;
use App\Enums\SubscriptionStatus;
use App\Filament\Resources\Subscriptions\SubscriptionResource;
use App\Models\Subscription;
use App\Models\SubscriptionProvision;
use App\Services\VpnProvisionService;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class EditSubscription extends EditRecord
{
    protected static string $resource = SubscriptionResource::class;

    protected function handleRecordUpdate(Model $record, array $data): Model
    {
        /** @var Subscription $record */
        return DB::transaction(function () use ($record, $data): Model {
            $originalStatus = $record->status instanceof SubscriptionStatus
                ? $record->status
                : SubscriptionStatus::from((string) $record->status);

            if (
                in_array($originalStatus, [SubscriptionStatus::Expired, SubscriptionStatus::Cancelled], true) &&
                array_key_exists('status', $data) &&
                $data['status'] !== $originalStatus->value
            ) {
                throw new RuntimeException('Status cannot be changed after a subscription is expired or cancelled.');
            }

            $record->update($data);
            $record->refresh();

            $updatedStatus = $record->status instanceof SubscriptionStatus
                ? $record->status
                : SubscriptionStatus::from((string) $record->status);

            if (
                $originalStatus !== $updatedStatus &&
                in_array($updatedStatus, [SubscriptionStatus::Expired, SubscriptionStatus::Cancelled], true)
            ) {
                $this->revokeSubscriptionProvisions($record);
            }

            return $record->load(['customer', 'service.platform', 'provisions.server']);
        });
    }

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }

    protected function revokeSubscriptionProvisions(Subscription $subscription): void
    {
        $subscription->loadMissing(['provisions.server']);

        /** @var SubscriptionProvision $provision */
        foreach ($subscription->provisions as $provision) {
            if ($provision->status === ProvisionStatus::Revoked) {
                continue;
            }

            if (filled($provision->outline_access_key_id) && filled($provision->server?->api_url)) {
                app(VpnProvisionService::class)->deleteProvisionKey($provision);

                continue;
            }

            $provision->update([
                'status' => ProvisionStatus::Revoked,
                'last_error' => null,
                'last_synced_at' => now(),
            ]);
        }
    }
}
