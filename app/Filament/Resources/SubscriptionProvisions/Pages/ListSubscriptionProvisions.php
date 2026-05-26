<?php

namespace App\Filament\Resources\SubscriptionProvisions\Pages;

use App\Filament\Resources\SubscriptionProvisions\SubscriptionProvisionResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListSubscriptionProvisions extends ListRecords
{
    protected static string $resource = SubscriptionProvisionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
