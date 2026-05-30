<?php

namespace App\Filament\Resources\SubscriptionClears\RelationManagers;

use App\Filament\Resources\Customers\CustomerResource;
use App\Filament\Resources\Subscriptions\SubscriptionResource;
use Filament\Actions\ViewAction;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class SubscriptionPaymentsRelationManager extends RelationManager
{
    protected static string $relationship = 'payments';

    protected static ?string $title = 'Payments';

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('subscription.id')
                    ->label('Subscription ID')
                    ->url(fn ($record): string => SubscriptionResource::getUrl('view', ['record' => $record->subscription])),
                TextColumn::make('subscription.customer.name')
                    ->label('Customer')
                    ->searchable()
                    ->url(fn ($record): string => CustomerResource::getUrl('view', ['record' => $record->subscription->customer])),
                TextColumn::make('service.name')
                    ->label('Service')
                    ->searchable(),
                TextColumn::make('type')
                    ->badge(),
                TextColumn::make('start_date')
                    ->date(),
                TextColumn::make('end_date')
                    ->date(),
                TextColumn::make('final_price')
                    ->label('Amount')
                    ->money('MMK'),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->headerActions([])
            ->recordActions([
                ViewAction::make()
                    ->url(fn ($record): string => SubscriptionResource::getUrl('view', ['record' => $record->subscription])),
            ])
            ->defaultSort('created_at', 'desc');
    }
}
