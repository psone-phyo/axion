<?php

namespace App\Filament\Resources\Subscriptions\RelationManagers;

use Filament\Actions\ViewAction;
use Filament\Infolists\Components\TextEntry;
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
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'create' => 'success',
                        'extend' => 'warning',
                        default => 'gray',
                    }),
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
            ->recordActions([
                ViewAction::make()
                    ->modalHeading('Payment Details')
                    ->infolist([
                        TextEntry::make('id')
                            ->label('Payment ID'),
                        TextEntry::make('type')
                            ->badge()
                            ->color(fn (string $state): string => match ($state) {
                                'create' => 'success',
                                'extend' => 'warning',
                                default => 'gray',
                            }),
                        TextEntry::make('subscription.id')
                            ->label('Subscription ID'),
                        TextEntry::make('user.name')
                            ->label('Admin')
                            ->placeholder('-'),
                        TextEntry::make('service.name')
                            ->label('Service'),
                        TextEntry::make('start_date')
                            ->date(),
                        TextEntry::make('end_date')
                            ->date(),
                        TextEntry::make('original_price')
                            ->label('Original Price')
                            ->money('MMK'),
                        TextEntry::make('discount')
                            ->money('MMK'),
                        TextEntry::make('final_price')
                            ->label('Amount')
                            ->money('MMK'),
                        TextEntry::make('clear.id')
                            ->label('Clear ID')
                            ->placeholder('Uncleared'),
                        TextEntry::make('remark')
                            ->placeholder('-'),
                        TextEntry::make('created_at')
                            ->label('Created At')
                            ->dateTime(),
                        TextEntry::make('updated_at')
                            ->label('Updated At')
                            ->dateTime(),
                    ]),
            ])
            ->defaultSort('created_at', 'desc');
    }
}
