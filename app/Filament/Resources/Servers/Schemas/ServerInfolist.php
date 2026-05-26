<?php

namespace App\Filament\Resources\Servers\Schemas;

use App\Enums\Region;
use Filament\Infolists\Components\IconEntry;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class ServerInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Server')
                    ->schema([
                        TextEntry::make('platform.name')
                            ->label('Platform'),
                        TextEntry::make('name'),
                        TextEntry::make('ip')
                            ->label('IP Address'),
                        TextEntry::make('api_url')
                            ->label('API URL')
                            ->url(fn (?string $state): ?string => $state)
                            ->openUrlInNewTab(),
                        TextEntry::make('region')
                            ->formatStateUsing(fn (Region|string|null $state): ?string => $state instanceof Region ? $state->label() : $state),
                        TextEntry::make('price')
                            ->money('USD'),
                        TextEntry::make('capacity'),
                        TextEntry::make('active_subscriptions_count')
                            ->label('Active Subscriptions')
                            ->state(fn ($record): int => $record->provisions()->where('status', 'active')->count()),
                        IconEntry::make('is_active')
                            ->boolean(),
                    ])
                    ->columns(2),
            ]);
    }
}
