<?php

namespace App\Filament\Resources\SubscriptionProvisions\Tables;

use App\Enums\ProvisionStatus;
use App\Support\ByteFormatter;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;

class SubscriptionProvisionsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('subscription.id')
                    ->label('Subscription ID')
                    ->sortable(),
                TextColumn::make('subscription.customer.name')
                    ->label('Customer')
                    ->searchable(),
                TextColumn::make('server.name')
                    ->label('Server')
                    ->searchable(),
                TextColumn::make('external_user_id')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('outline_access_key_id')
                    ->label('Outline Key ID')
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
                TextColumn::make('data_limit_bytes')
                    ->label('Data Limit')
                    ->formatStateUsing(fn (?int $state): string => ByteFormatter::humanReadable($state))
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('transferred_bytes')
                    ->label('Transferred')
                    ->formatStateUsing(fn (?int $state): string => ByteFormatter::humanReadable($state))
                    ->toggleable(),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->filters([
                SelectFilter::make('status')
                    ->options(ProvisionStatus::options()),
                SelectFilter::make('server')
                    ->relationship('server', 'name'),
            ])
            ->recordActions([
                ViewAction::make(),
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
    }
}
