<?php

namespace App\Filament\Resources\Servers\Schemas;

use App\Enums\Region;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Components\Grid;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class ServerForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Server Details')
                    ->schema([
                        Grid::make(2)
                            ->schema([
                                Select::make('platform_id')
                                    ->relationship('platform', 'name')
                                    ->required()
                                    ->searchable()
                                    ->preload(),
                                TextInput::make('name')
                                    ->required()
                                    ->maxLength(255),
                                TextInput::make('ip')
                                    ->label('IP Address')
                                    ->required()
                                    ->maxLength(255),
                                TextInput::make('api_url')
                                    ->label('API URL')
                                    ->url()
                                    ->maxLength(255),
                                Select::make('region')
                                    ->options(Region::options())
                                    ->required(),
                                TextInput::make('price')
                                    ->numeric()
                                    ->prefix('$')
                                    ->required(),
                                TextInput::make('capacity')
                                    ->integer()
                                    ->minValue(1)
                                    ->required(),
                                Toggle::make('is_active')
                                    ->default(true)
                                    ->inline(false),
                            ]),
                    ]),
            ]);
    }
}
