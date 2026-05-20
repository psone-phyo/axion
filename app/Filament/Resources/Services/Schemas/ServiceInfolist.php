<?php

namespace App\Filament\Resources\Services\Schemas;

use Filament\Infolists\Components\IconEntry;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class ServiceInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Service')
                    ->schema([
                        TextEntry::make('platform.name')
                            ->label('Platform'),
                        TextEntry::make('name'),
                        TextEntry::make('duration_days')
                            ->suffix(' days'),
                        TextEntry::make('price')
                            ->money('USD'),
                        TextEntry::make('bandwidth_limit')
                            ->label('Bandwidth Limit')
                            ->formatStateUsing(fn ($state): string => filled($state) ? "{$state} GB" : '-'),
                        TextEntry::make('device_limit')
                            ->placeholder('-'),
                        IconEntry::make('is_active')
                            ->label('Active')
                            ->boolean(),
                    ])
                    ->columns(2),
            ]);
    }
}
