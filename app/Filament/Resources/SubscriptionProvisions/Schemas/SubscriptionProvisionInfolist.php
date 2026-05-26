<?php

namespace App\Filament\Resources\SubscriptionProvisions\Schemas;

use App\Enums\ProvisionStatus;
use App\Support\ByteFormatter;
use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class SubscriptionProvisionInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Provision')
                    ->schema([
                        TextEntry::make('subscription.id')
                            ->label('Subscription ID'),
                        TextEntry::make('subscription.customer.name')
                            ->label('Customer'),
                        TextEntry::make('server.name')
                            ->label('Server'),
                        TextEntry::make('outline_access_key_id')
                            ->label('Outline Access Key ID'),
                        TextEntry::make('external_user_id'),
                        TextEntry::make('key_name'),
                        TextEntry::make('outline_method')
                            ->label('Method'),
                        TextEntry::make('outline_port')
                            ->label('Port'),
                        TextEntry::make('data_limit_bytes')
                            ->label('Data Limit')
                            ->formatStateUsing(fn (?int $state): string => ByteFormatter::humanReadable($state)),
                        TextEntry::make('transferred_bytes')
                            ->label('Transferred')
                            ->formatStateUsing(fn (?int $state): string => ByteFormatter::humanReadable($state)),
                        TextEntry::make('last_synced_at')
                            ->dateTime(),
                        TextEntry::make('status')
                            ->badge()
                            ->formatStateUsing(fn (ProvisionStatus|string|null $state): ?string => $state instanceof ProvisionStatus ? $state->label() : $state),
                        TextEntry::make('last_error')
                            ->columnSpanFull(),
                        TextEntry::make('access_key')
                            ->copyable()
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
