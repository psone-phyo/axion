<?php

namespace App\Filament\Resources\SubscriptionClears\Pages;

use App\Filament\Resources\SubscriptionClears\SubscriptionClearResource;
use App\Models\SubscriptionClear;
use App\Services\SubscriptionClearService;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Database\Eloquent\Model;

class CreateSubscriptionClear extends CreateRecord
{
    protected static string $resource = SubscriptionClearResource::class;

    protected function handleRecordCreation(array $data): Model
    {
        /** @var SubscriptionClear $subscriptionClear */
        $subscriptionClear = app(SubscriptionClearService::class)->createClear($data, auth()->user());

        return $subscriptionClear;
    }

    protected function getCreatedNotification(): ?Notification
    {
        /** @var SubscriptionClear|null $record */
        $record = $this->record;

        return Notification::make()
            ->success()
            ->title('Subscription clear saved')
            ->body(sprintf(
                '%d subscription(s) were cleared with a total of %s MMK.',
                $record?->subscriptions_count ?? 0,
                number_format((float) ($record?->total ?? 0), 2),
            ));
    }
}
