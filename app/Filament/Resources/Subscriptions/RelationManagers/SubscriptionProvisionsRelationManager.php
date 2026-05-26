<?php

namespace App\Filament\Resources\Subscriptions\RelationManagers;

use App\Enums\ProvisionStatus;
use App\Support\ByteFormatter;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class SubscriptionProvisionsRelationManager extends RelationManager
{
    protected static string $relationship = 'provisions';

    protected static ?string $title = 'Subscription Provisions';

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('server.name')
                    ->label('Server')
                    ->searchable(),
                TextColumn::make('external_user_id')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('key_name')
                    ->searchable(),
                TextColumn::make('status')
                    ->badge()
                    ->formatStateUsing(fn (ProvisionStatus|string|null $state): ?string => $state instanceof ProvisionStatus ? $state->label() : $state)
                    ->color(fn (ProvisionStatus|string|null $state): string => match ($state instanceof ProvisionStatus ? $state : $state) {
                        ProvisionStatus::Active, ProvisionStatus::Active->value => 'success',
                        ProvisionStatus::Revoked, ProvisionStatus::Revoked->value => 'danger',
                        default => 'gray',
                    }),
                TextColumn::make('access_key')
                    ->limit(40)
                    ->copyable(),
                TextColumn::make('transferred_bytes')
                    ->label('Transferred')
                    ->formatStateUsing(fn (?int $state): string => ByteFormatter::humanReadable($state)),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->headerActions([])
            ->recordActions([
                ViewAction::make(),
                EditAction::make(),
            ])
            ->defaultSort('created_at', 'desc');
    }
}
