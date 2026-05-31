<?php

namespace App\Filament\Resources\Subscriptions\Schemas;

use App\Enums\SubscriptionStatus;
use App\Filament\Resources\SubscriptionClears\SubscriptionClearResource;
use App\Filament\Resources\Customers\CustomerResource;
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
                            ->label('Customer')
                            ->url(fn ($record): string => CustomerResource::getUrl('view', ['record' => $record->customer])),
                        TextEntry::make('service.name')
                            ->label('Service'),
                        TextEntry::make('service.platform.name')
                            ->label('Platform'),
                        TextEntry::make('creator.name')
                            ->label('Created By')
                            ->placeholder('-'),
                        TextEntry::make('clear_status')
                            ->label('Clear')
                            ->state(fn ($record): string => $record->hasUnclearedPayments() ? 'Uncleared' : 'Cleared')
                            ->badge()
                            ->color(fn ($record): string => $record->hasUnclearedPayments() ? 'gray' : 'success')
                            ->url(fn ($record): ?string => $record->latestClearedPayment()?->clear
                                ? SubscriptionClearResource::getUrl('view', ['record' => $record->latestClearedPayment()->clear])
                                : null),
                        TextEntry::make('latestPayment.original_price')
                            ->money('MMK'),
                        TextEntry::make('latestPayment.discount')
                            ->money('MMK'),
                        TextEntry::make('latestPayment.final_price')
                            ->label('Latest Amount')
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
