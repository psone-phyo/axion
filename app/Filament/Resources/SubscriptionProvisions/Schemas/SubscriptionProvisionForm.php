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
                                TextInput::make('outline_access_key_id')
                                    ->label('Outline Access Key ID')
                                    ->maxLength(255),
                                TextInput::make('external_user_id')
                                    ->required()
                                    ->maxLength(255),
                                TextInput::make('key_name')
                                    ->required()
                                    ->maxLength(255),
                                TextInput::make('outline_method')
                                    ->label('Method')
                                    ->maxLength(255),
                                TextInput::make('outline_port')
                                    ->label('Port')
                                    ->numeric(),
                                TextInput::make('data_limit_bytes')
                                    ->label('Data Limit Bytes')
                                    ->numeric(),
                                TextInput::make('transferred_bytes')
                                    ->label('Transferred Bytes')
                                    ->numeric(),
                                Select::make('status')
                                    ->options(ProvisionStatus::options())
                                    ->required(),
                                Textarea::make('last_error')
                                    ->rows(3)
                                    ->columnSpanFull(),
                                Textarea::make('access_key')
                                    ->required()
                                    ->rows(5)
                                    ->columnSpanFull(),
                            ]),
                    ]),
            ]);
    }
}
