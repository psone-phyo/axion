<?php

namespace App\Filament\Resources\SaleOrders\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class SaleOrderInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Sale Order')
                    ->schema([
                        TextEntry::make('subscription.id')
                            ->label('Subscription')
                            ->prefix('#'),
                        TextEntry::make('customer.name')
                            ->label('Customer'),
                        TextEntry::make('service.name')
                            ->label('Service'),
                        TextEntry::make('amount')
                            ->money('USD'),
                        TextEntry::make('status')
                            ->formatStateUsing(fn ($state): string => $state->label())
                            ->badge()
                            ->color(fn ($state): string => $state->color()),
                        TextEntry::make('paid_at')
                            ->dateTime()
                            ->placeholder('-'),
                    ])
                    ->columns(2),
            ]);
    }
}
