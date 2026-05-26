<?php

namespace App\Filament\Resources\Services\Schemas;

use App\Enums\Region;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Components\Grid;
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
                                TextInput::make('duration_days')
                                    ->integer()
                                    ->minValue(1)
                                    ->required(),
                                TextInput::make('price')
                                    ->numeric()
                                    ->prefix('$')
                                    ->required(),
                                Select::make('region')
                                    ->options(Region::options())
                                    ->required(),
                                Toggle::make('is_active')
                                    ->default(true)
                                    ->inline(false),
                            ]),
                    ]),
            ]);
    }
}
