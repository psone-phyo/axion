<?php

namespace App\Filament\Resources\Users\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class UserInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Admin')
                    ->schema([
                        TextEntry::make('name'),
                        TextEntry::make('email'),
                        TextEntry::make('roles.name')
                            ->label('Roles')
                            ->badge()
                            ->listWithLineBreaks(),
                        TextEntry::make('created_at')
                            ->dateTime(),
                    ])
                    ->columns(2),
            ]);
    }
}
