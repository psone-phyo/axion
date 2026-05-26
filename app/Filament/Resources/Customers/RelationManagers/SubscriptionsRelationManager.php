<?php

namespace App\Filament\Resources\Customers\RelationManagers;

use App\Enums\SubscriptionStatus;
use App\Filament\Resources\Subscriptions\SubscriptionResource;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class SubscriptionsRelationManager extends RelationManager
{
    protected static string $relationship = 'subscriptions';

    protected static ?string $title = 'Subscriptions';

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('id')
                    ->label('Subscription ID')
                    ->sortable(),
                TextColumn::make('service.name')
                    ->label('Service')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('service.platform.name')
                    ->label('Platform')
                    ->sortable(),
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
            ->headerActions([])
            ->recordActions([
                ViewAction::make()
                    ->url(fn ($record): string => SubscriptionResource::getUrl('view', ['record' => $record])),
                EditAction::make()
                    ->url(fn ($record): string => SubscriptionResource::getUrl('edit', ['record' => $record])),
            ])
            ->defaultSort('created_at', 'desc');
    }
}
