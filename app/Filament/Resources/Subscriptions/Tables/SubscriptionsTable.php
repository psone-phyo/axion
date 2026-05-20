<?php

namespace App\Filament\Resources\Subscriptions\Tables;

use App\Enums\SubscriptionStatus;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class SubscriptionsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('customer.name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('service.name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('server.name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('status')
                    ->formatStateUsing(fn (SubscriptionStatus $state): string => $state->label())
                    ->badge()
                    ->color(fn (SubscriptionStatus $state): string => $state->color())
                    ->sortable(),
                TextColumn::make('starts_at')
                    ->dateTime()
                    ->sortable(),
                TextColumn::make('ends_at')
                    ->dateTime()
                    ->sortable(),
                TextColumn::make('days_remaining')
                    ->label('Days Remaining')
                    ->state(fn ($record): int => $record->daysRemaining())
                    ->sortable(),
                TextColumn::make('access_keys_count')
                    ->counts('accessKeys')
                    ->label('Keys'),
            ])
            ->filters([
                SelectFilter::make('status')
                    ->options(SubscriptionStatus::options()),
                SelectFilter::make('customer')
                    ->relationship('customer', 'name')
                    ->searchable()
                    ->preload(),
                SelectFilter::make('service')
                    ->relationship('service', 'name')
                    ->searchable()
                    ->preload(),
                Filter::make('expired_only')
                    ->label('Expired')
                    ->query(fn (Builder $query): Builder => $query->expired()),
            ])
            ->recordActions([
                ViewAction::make(),
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}
