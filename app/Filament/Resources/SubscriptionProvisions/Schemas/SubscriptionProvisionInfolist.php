<?php

namespace App\Filament\Resources\SubscriptionProvisions\Schemas;

use App\Enums\ProvisionStatus;
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
                        TextEntry::make('external_user_id'),
                        TextEntry::make('key_name'),
                        TextEntry::make('status')
                            ->badge()
                            ->formatStateUsing(fn (ProvisionStatus|string|null $state): ?string => $state instanceof ProvisionStatus ? $state->label() : $state),
                        TextEntry::make('access_key')
                            ->copyable()
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
