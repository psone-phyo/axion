<?php

namespace App\Filament\Resources\Subscriptions\Schemas;

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
                        TextEntry::make('customer.name')
                            ->label('Customer'),
                        TextEntry::make('service.name')
                            ->label('Service'),
                        TextEntry::make('server.name')
                            ->label('Server'),
                        TextEntry::make('creator.name')
                            ->label('Created By'),
                        TextEntry::make('status')
                            ->formatStateUsing(fn ($state): string => $state->label())
                            ->badge()
                            ->color(fn ($state): string => $state->color()),
                        TextEntry::make('starts_at')
                            ->dateTime(),
                        TextEntry::make('ends_at')
                            ->dateTime(),
                        TextEntry::make('days_remaining')
                            ->label('Days Remaining')
                            ->state(fn ($record): int => $record->daysRemaining()),
                    ])
                    ->columns(2),
            ]);
    }
}
