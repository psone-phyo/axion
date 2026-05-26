<?php

namespace App\Filament\Resources\SubscriptionProvisions\Pages;

use App\Filament\Resources\SubscriptionProvisions\SubscriptionProvisionResource;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;

class EditSubscriptionProvision extends EditRecord
{
    protected static string $resource = SubscriptionProvisionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }
}
