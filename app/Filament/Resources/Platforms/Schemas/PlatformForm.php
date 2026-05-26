<?php

namespace App\Filament\Resources\Platforms\Schemas;

use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
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
                            ->unique(ignoreRecord: true)
                            ->maxLength(255),
                        Textarea::make('description')
                            ->rows(4)
                            ->columnSpanFull(),
                    ]),
            ]);
    }
}
