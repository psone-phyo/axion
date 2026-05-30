<?php

namespace App\Filament\Resources\SubscriptionClears\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class SubscriptionClearInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Clear Save')
                    ->schema([
                        TextEntry::make('id')
                            ->label('Clear ID'),
                        TextEntry::make('user.name')
                            ->label('Admin'),
                        TextEntry::make('clear_date')
                            ->dateTime(),
                        TextEntry::make('payments_count')
                            ->label('Payments')
                            ->state(fn ($record): int => $record->payments()->count()),
                        TextEntry::make('total')
                            ->money('MMK'),
                        TextEntry::make('created_at')
                            ->label('Saved At')
                            ->dateTime(),
                    ])
                    ->columns(2),
            ]);
    }
}
