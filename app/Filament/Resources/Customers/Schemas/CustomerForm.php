<?php

namespace App\Filament\Resources\Customers\Schemas;

use App\Enums\CustomerPlatform;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use Filament\Schemas\Components\Grid;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class CustomerForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Customer Details')
                    ->schema([
                        Grid::make(2)
                            ->schema([
                                TextInput::make('name')
                                    ->required()
                                    ->maxLength(255),
                                Select::make('platform')
                                    ->label('Lead Platform')
                                    ->options(CustomerPlatform::options())
                                    ->required()
                                    ->searchable()
                                    ->preload(),
                                TextInput::make('email')
                                    ->email()
                                    ->maxLength(255),
                                TextInput::make('phone')
                                    ->tel()
                                    ->maxLength(255),
                                TextInput::make('profile_url')
                                    ->label('Profile URL')
                                    ->url()
                                    ->required()
                                    ->columnSpanFull(),
                            ]),
                    ]),
            ]);
    }
}
