<?php

namespace App\Filament\Resources\Subscriptions\Schemas;

use App\Enums\SubscriptionStatus;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class SubscriptionInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Subscription')
                    ->schema([
                        TextEntry::make('id')
                            ->label('Subscription ID'),
                        TextEntry::make('customer.name')
                            ->label('Customer'),
                        TextEntry::make('service.name')
                            ->label('Service'),
                        TextEntry::make('service.platform.name')
                            ->label('Platform'),
                        TextEntry::make('original_price')
                            ->money('MMK'),
                        TextEntry::make('discount')
                            ->money('MMK'),
                        TextEntry::make('final_price')
                            ->label('Final Price')
                            ->money('MMK'),
                        TextEntry::make('status')
                            ->badge()
                            ->formatStateUsing(fn (SubscriptionStatus|string|null $state): ?string => $state instanceof SubscriptionStatus ? $state->label() : $state),
                        TextEntry::make('start_date')
                            ->date(),
                        TextEntry::make('end_date')
                            ->date(),
                        TextEntry::make('provision_summary')
                            ->label('Provision')
                            ->state(fn ($record): string => $record->provisions->first()?->key_name ?? 'Pending'),
                        TextEntry::make('remark')
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
