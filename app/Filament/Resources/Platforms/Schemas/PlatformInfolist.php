<?php

namespace App\Filament\Resources\Platforms\Schemas;

use Filament\Infolists\Components\IconEntry;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class PlatformInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Platform')
                    ->schema([
                        TextEntry::make('name'),
                        TextEntry::make('type')
                            ->formatStateUsing(fn ($state): string => $state->label()),
                        IconEntry::make('is_active')
                            ->label('Active')
                            ->boolean(),
                        TextEntry::make('services_count')
                            ->label('Services')
                            ->state(fn ($record): int => $record->services()->count()),
                        TextEntry::make('servers_count')
                            ->label('Servers')
                            ->state(fn ($record): int => $record->servers()->count()),
                        TextEntry::make('description')
                            ->placeholder('-')
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
