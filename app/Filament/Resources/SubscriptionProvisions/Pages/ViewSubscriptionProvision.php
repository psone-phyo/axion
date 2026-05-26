<?php

namespace App\Filament\Resources\SubscriptionProvisions\Pages;

use App\Filament\Resources\SubscriptionProvisions\SubscriptionProvisionResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewSubscriptionProvision extends ViewRecord
{
    protected static string $resource = SubscriptionProvisionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
