<?php

namespace App\Filament\Resources\Customers\Schemas;

use App\Enums\CustomerPlatform;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class CustomerInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Customer')
                    ->schema([
                        TextEntry::make('name'),
                        TextEntry::make('platform')
                            ->label('Lead Platform')
                            ->badge()
                            ->formatStateUsing(fn (CustomerPlatform|string|null $state): ?string => $state instanceof CustomerPlatform ? $state->label() : $state),
                        TextEntry::make('email'),
                        TextEntry::make('phone'),
                        TextEntry::make('profile_url')
                            ->label('Profile URL')
                            ->url(fn (?string $state): ?string => $state)
                            ->openUrlInNewTab()
                            ->columnSpanFull(),
                        TextEntry::make('subscriptions_count')
                            ->label('Subscriptions')
                            ->state(fn ($record): int => $record->subscriptions()->count()),
                    ])
                    ->columns(2),
            ]);
    }
}
