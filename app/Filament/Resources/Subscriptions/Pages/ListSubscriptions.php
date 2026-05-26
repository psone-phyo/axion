<?php

namespace App\Filament\Resources\Subscriptions\Pages;

use App\Enums\SubscriptionStatus;
use App\Filament\Resources\Subscriptions\SubscriptionResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;
use Filament\Schemas\Components\Tabs\Tab;
use Illuminate\Database\Eloquent\Builder;

class ListSubscriptions extends ListRecords
{
    protected static string $resource = SubscriptionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }

    public function getTabs(): array
    {
        return [
            'active' => Tab::make('Active')
                ->modifyQueryUsing(fn (Builder $query): Builder => $query->where('status', SubscriptionStatus::Active->value)),
            'expired' => Tab::make('Expired')
                ->modifyQueryUsing(fn (Builder $query): Builder => $query->where('status', SubscriptionStatus::Expired->value)),
            'cancelled' => Tab::make('Cancelled')
                ->modifyQueryUsing(fn (Builder $query): Builder => $query->where('status', SubscriptionStatus::Cancelled->value)),
        ];
    }
}
