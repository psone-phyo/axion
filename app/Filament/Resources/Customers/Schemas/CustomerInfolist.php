<?php

namespace App\Filament\Resources\Customers\Schemas;

use Filament\Infolists\Components\IconEntry;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class CustomerInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Customer Details')
                    ->schema([
                        TextEntry::make('name'),
                        TextEntry::make('username')
                            ->placeholder('-'),
                        TextEntry::make('email')
                            ->placeholder('-'),
                        TextEntry::make('phone')
                            ->placeholder('-'),
                        TextEntry::make('platform')
                            ->formatStateUsing(fn ($state): string => $state->label()),
                        IconEntry::make('status')
                            ->label('Active')
                            ->boolean(),
                        TextEntry::make('subscriptions_count')
                            ->label('Subscriptions')
                            ->state(fn ($record): int => $record->subscriptions()->count()),
                        TextEntry::make('sale_orders_count')
                            ->label('Sale Orders')
                            ->state(fn ($record): int => $record->saleOrders()->count()),
                    ])
                    ->columns(2),
            ]);
    }
}
