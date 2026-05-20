<?php

namespace App\Filament\Resources\AccessKeys\Schemas;

use Filament\Infolists\Components\IconEntry;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class AccessKeyInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Access Key')
                    ->schema([
                        TextEntry::make('subscription.id')
                            ->label('Subscription')
                            ->prefix('#'),
                        TextEntry::make('subscription.customer.name')
                            ->label('Customer'),
                        TextEntry::make('type')
                            ->formatStateUsing(fn ($state): string => $state->label())
                            ->badge(),
                        TextEntry::make('external_id')
                            ->placeholder('-'),
                        TextEntry::make('username')
                            ->placeholder('-'),
                        IconEntry::make('is_active')
                            ->label('Active')
                            ->boolean(),
                        TextEntry::make('access_key')
                            ->copyable()
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
