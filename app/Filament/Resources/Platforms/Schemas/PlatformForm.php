<?php

namespace App\Filament\Resources\Platforms\Schemas;

use App\Enums\PlatformType;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class PlatformForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Platform Details')
                    ->schema([
                        TextInput::make('name')
                            ->required()
                            ->maxLength(255),
                        Select::make('type')
                            ->options(PlatformType::options())
                            ->required()
                            ->searchable(),
                        Toggle::make('is_active')
                            ->label('Active')
                            ->default(true)
                            ->required(),
                        Textarea::make('description')
                            ->rows(4)
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
                Section::make('Server Mapping')
                    ->schema([
                        Select::make('servers')
                            ->relationship('servers', 'name')
                            ->multiple()
                            ->searchable()
                            ->preload(),
                    ]),
            ]);
    }
}
