<?php

namespace App\Filament\Resources\Customers\Tables;

use App\Enums\CustomerPlatform;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;

class CustomersTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('username')
                    ->searchable()
                    ->placeholder('-'),
                TextColumn::make('platform')
                    ->formatStateUsing(fn (CustomerPlatform $state): string => $state->label())
                    ->badge()
                    ->sortable(),
                TextColumn::make('subscriptions_count')
                    ->counts('subscriptions')
                    ->label('Subscriptions')
                    ->sortable(),
                TextColumn::make('sale_orders_count')
                    ->counts('saleOrders')
                    ->label('Sales')
                    ->sortable(),
                IconColumn::make('status')
                    ->label('Active')
                    ->boolean(),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                SelectFilter::make('platform')
                    ->options(CustomerPlatform::options()),
                SelectFilter::make('status')
                    ->options([
                        1 => 'Active',
                        0 => 'Inactive',
                    ]),
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
