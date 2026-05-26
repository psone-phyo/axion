<?php

namespace App\Filament\Resources\Platforms\Schemas;

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
                        TextEntry::make('description')
                            ->columnSpanFull(),
                        TextEntry::make('servers_count')
                            ->label('Servers')
                            ->state(fn ($record): int => $record->servers()->count()),
                        TextEntry::make('services_count')
                            ->label('Services')
                            ->state(fn ($record): int => $record->services()->count()),
                    ])
                    ->columns(2),
            ]);
    }
}
