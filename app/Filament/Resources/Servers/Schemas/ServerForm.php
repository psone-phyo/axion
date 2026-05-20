<?php

namespace App\Filament\Resources\Servers\Schemas;

use App\Enums\ServerProvider;
use App\Enums\ServerStatus;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
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
                        TextInput::make('name')
                            ->required()
                            ->maxLength(255),
                        TextInput::make('ip_address')
                            ->label('IP Address')
                            ->ip()
                            ->required(),
                        TextInput::make('region')
                            ->required()
                            ->maxLength(255),
                        Select::make('provider')
                            ->options(ServerProvider::options())
                            ->required()
                            ->searchable(),
                        Select::make('status')
                            ->options(ServerStatus::options())
                            ->required()
                            ->searchable(),
                        TextInput::make('api_url')
                            ->url()
                            ->maxLength(255),
                        Textarea::make('api_key')
                            ->rows(3)
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
