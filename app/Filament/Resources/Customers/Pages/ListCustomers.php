<?php

namespace App\Filament\Resources\Customers\Pages;

use App\Enums\CustomerPlatform;
use App\Filament\Resources\Customers\CustomerResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;
use Filament\Schemas\Components\Tabs\Tab;
use Illuminate\Database\Eloquent\Builder;

class ListCustomers extends ListRecords
{
    protected static string $resource = CustomerResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }

    public function getTabs(): array
    {
        $tabs = [
            'all' => Tab::make('All'),
        ];

        foreach (CustomerPlatform::cases() as $platform) {
            $tabs[$platform->value] = Tab::make($platform->label())
                ->modifyQueryUsing(fn (Builder $query): Builder => $query->where('platform', $platform->value));
        }

        return $tabs;
    }
}
