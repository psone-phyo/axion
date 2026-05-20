<?php

namespace App\Filament\Resources\AccessKeys\Pages;

use App\Filament\Resources\AccessKeys\AccessKeyResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewAccessKey extends ViewRecord
{
    protected static string $resource = AccessKeyResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
