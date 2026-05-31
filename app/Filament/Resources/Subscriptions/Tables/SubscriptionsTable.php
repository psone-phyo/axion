<?php

namespace App\Filament\Resources\Subscriptions\Tables;

use App\Enums\SubscriptionStatus;
use App\Filament\Resources\Customers\CustomerResource;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;

class SubscriptionsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('id')
                    ->label('Subscription ID')
                    ->sortable(),
                TextColumn::make('customer.name')
                    ->label('Customer')
                    ->searchable()
                    ->sortable()
                    ->url(fn ($record): string => CustomerResource::getUrl('view', ['record' => $record->customer])),
                TextColumn::make('service.platform.name')
                    ->label('Platform')
                    ->sortable(),
                TextColumn::make('creator.name')
                    ->label('Created By')
                    ->searchable()
                    ->toggleable(),
                TextColumn::make('status')
                    ->badge()
                    ->formatStateUsing(fn (SubscriptionStatus|string|null $state): ?string => $state instanceof SubscriptionStatus ? $state->label() : $state)
                    ->color(fn (SubscriptionStatus|string|null $state): string => match ($state instanceof SubscriptionStatus ? $state : $state) {
                        SubscriptionStatus::Active, SubscriptionStatus::Active->value => 'success',
                        SubscriptionStatus::Expired, SubscriptionStatus::Expired->value => 'warning',
                        SubscriptionStatus::Cancelled, SubscriptionStatus::Cancelled->value => 'danger',
                        default => 'gray',
                    }),
                TextColumn::make('start_date')
                    ->date()
                    ->sortable(),
                TextColumn::make('end_date')
                    ->date()
                    ->sortable(),
                TextColumn::make('provisions.server.name')
                    ->label('Server')
                    ->listWithLineBreaks(),
            ])
            ->filters([
                SelectFilter::make('status')
                    ->options(SubscriptionStatus::options()),
                SelectFilter::make('customer')
                    ->relationship('customer', 'name'),
                SelectFilter::make('service')
                    ->relationship('service', 'name'),
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
