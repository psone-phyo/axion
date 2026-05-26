<?php

namespace App\Filament\Resources\Services\Schemas;

use App\Enums\Region;
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
                        TextEntry::make('region')
                            ->formatStateUsing(fn (Region|string|null $state): ?string => $state instanceof Region ? $state->label() : $state),
                        IconEntry::make('is_active')
                            ->boolean(),
                    ])
                    ->columns(2),
            ]);
    }
}
