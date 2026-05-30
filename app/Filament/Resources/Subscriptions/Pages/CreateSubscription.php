<?php

namespace App\Filament\Resources\Subscriptions\Pages;

use App\Filament\Resources\Subscriptions\SubscriptionResource;
use App\Models\Customer;
use App\Models\Subscription;
use App\Services\VpnProvisionService;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\HtmlString;

class CreateSubscription extends CreateRecord
{
    protected static string $resource = SubscriptionResource::class;

    protected ?Subscription $createdSubscription = null;

    protected function handleRecordCreation(array $data): Model
    {
        /** @var Subscription $subscription */
        $subscription = DB::transaction(function () use ($data): Subscription {
            $data['created_by'] = auth()->id();

            if ($data['create_customer'] ?? false) {
                $customer = Customer::query()->create([
                    'name' => $data['customer_name'],
                    'email' => $data['customer_email'] ?: null,
                    'phone' => $data['customer_phone'] ?: null,
                    'platform' => $data['customer_platform'],
                    'profile_url' => $data['customer_profile_url'],
                ]);

                $data['customer_id'] = $customer->id;
            }

            unset(
                $data['create_customer'],
                $data['customer_name'],
                $data['customer_email'],
                $data['customer_phone'],
                $data['customer_platform'],
                $data['customer_profile_url'],
            );

            return app(VpnProvisionService::class)->createSubscriptionWithProvision($data);
        });

        $this->createdSubscription = $subscription;

        return $subscription;
    }

    protected function getCreatedNotification(): ?Notification
    {
        $provision = $this->createdSubscription?->provisions->first();

        if (! $provision) {
            return Notification::make()
                ->success()
                ->title('Subscription created');
        }

        return Notification::make()
            ->success()
            ->persistent()
            ->title('Subscription created and provisioned successfully')
            ->body(new HtmlString(
                'Access Key:<br><code style="display:block;word-break:break-all;">' .
                e($provision->access_key) .
                '</code>'
            ));
    }
}
