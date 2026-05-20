<?php

namespace App\Filament\Resources\Servers\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class ServerInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Server')
                    ->schema([
                        TextEntry::make('name'),
                        TextEntry::make('ip_address')
                            ->label('IP Address'),
                        TextEntry::make('region'),
                        TextEntry::make('provider')
                            ->formatStateUsing(fn ($state): string => $state->label()),
                        TextEntry::make('status')
                            ->formatStateUsing(fn ($state): string => $state->label())
                            ->badge()
                            ->color(fn ($state): string => $state->color()),
                        TextEntry::make('api_url')
                            ->placeholder('-'),
                        TextEntry::make('api_key')
                            ->state(fn ($record): string => filled($record->api_key) ? 'Encrypted' : '-'),
                    ])
                    ->columns(2),
            ]);
    }
}
