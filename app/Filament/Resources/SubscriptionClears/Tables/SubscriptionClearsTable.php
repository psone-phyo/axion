<?php

namespace App\Filament\Resources\SubscriptionClears\Tables;

use Filament\Actions\CreateAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class SubscriptionClearsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('id')
                    ->label('Clear ID')
                    ->sortable(),
                TextColumn::make('user.name')
                    ->label('Admin')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('clear_date')
                    ->dateTime()
                    ->sortable(),
                TextColumn::make('payments_count')
                    ->label('Payments')
                    ->counts('payments')
                    ->sortable(),
                TextColumn::make('total')
                    ->money('MMK')
                    ->sortable(),
                TextColumn::make('created_at')
                    ->label('Saved At')
                    ->dateTime()
                    ->sortable(),
            ])
            ->recordActions([
                ViewAction::make(),
            ])
            ->headerActions([
                CreateAction::make(),
            ])
            ->defaultSort('created_at', 'desc');
    }
}
