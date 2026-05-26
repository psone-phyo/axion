<?php

namespace App\Filament\Resources\SubscriptionProvisions\Schemas;

use App\Enums\ProvisionStatus;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Components\Grid;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class SubscriptionProvisionForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Provision Details')
                    ->schema([
                        Grid::make(2)
                            ->schema([
                                Select::make('subscription_id')
                                    ->relationship('subscription', 'id')
                                    ->required()
                                    ->searchable()
                                    ->preload(),
                                Select::make('server_id')
                                    ->relationship('server', 'name')
                                    ->required()
                                    ->searchable()
                                    ->preload(),
                                TextInput::make('external_user_id')
                                    ->required()
                                    ->maxLength(255),
                                TextInput::make('key_name')
                                    ->required()
                                    ->maxLength(255),
                                Select::make('status')
                                    ->options(ProvisionStatus::options())
                                    ->required(),
                                Textarea::make('access_key')
                                    ->required()
                                    ->rows(5)
                                    ->columnSpanFull(),
                            ]),
                    ]),
            ]);
    }
}
