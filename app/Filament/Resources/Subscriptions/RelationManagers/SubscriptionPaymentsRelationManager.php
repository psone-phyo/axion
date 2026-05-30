<?php

namespace App\Filament\Resources\Subscriptions\RelationManagers;

use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class SubscriptionPaymentsRelationManager extends RelationManager
{
    protected static string $relationship = 'payments';

    protected static ?string $title = 'Payment History';

    public function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('type')
                    ->badge(),
                TextColumn::make('user.name')
                    ->label('Admin')
                    ->placeholder('-'),
                TextColumn::make('service.name')
                    ->label('Service')
                    ->searchable(),
                TextColumn::make('start_date')
                    ->date(),
                TextColumn::make('end_date')
                    ->date(),
                TextColumn::make('original_price')
                    ->label('Original Price')
                    ->money('MMK'),
                TextColumn::make('discount')
                    ->money('MMK'),
                TextColumn::make('final_price')
                    ->label('Amount')
                    ->money('MMK'),
                TextColumn::make('clear.id')
                    ->label('Clear ID')
                    ->placeholder('Uncleared'),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->headerActions([])
            ->recordActions([])
            ->defaultSort('created_at', 'desc');
    }
}
