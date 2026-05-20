<?php

namespace App\Filament\Resources\AccessKeys\Schemas;

use App\Enums\AccessKeyType;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class AccessKeyForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Access Key')
                    ->schema([
                        Select::make('subscription_id')
                            ->relationship('subscription', 'id')
                            ->searchable()
                            ->preload()
                            ->required(),
                        Select::make('type')
                            ->options(AccessKeyType::options())
                            ->required()
                            ->searchable(),
                        TextInput::make('external_id')
                            ->maxLength(255),
                        TextInput::make('username')
                            ->maxLength(255),
                        Toggle::make('is_active')
                            ->label('Active')
                            ->default(true)
                            ->required(),
                        Textarea::make('access_key')
                            ->required()
                            ->rows(5)
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
