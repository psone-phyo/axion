<?php

namespace App\Filament\Resources\Services\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class ServiceForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Service Details')
                    ->schema([
                        Select::make('platform_id')
                            ->relationship('platform', 'name')
                            ->searchable()
                            ->preload()
                            ->required(),
                        TextInput::make('name')
                            ->required()
                            ->maxLength(255),
                        TextInput::make('duration_days')
                            ->numeric()
                            ->required()
                            ->minValue(1),
                        TextInput::make('price')
                            ->numeric()
                            ->prefix('$')
                            ->required()
                            ->minValue(0),
                        TextInput::make('bandwidth_limit')
                            ->numeric()
                            ->label('Bandwidth Limit (GB)')
                            ->minValue(1),
                        TextInput::make('device_limit')
                            ->numeric()
                            ->minValue(1),
                        Toggle::make('is_active')
                            ->label('Active')
                            ->default(true)
                            ->required(),
                    ])
                    ->columns(2),
            ]);
    }
}
