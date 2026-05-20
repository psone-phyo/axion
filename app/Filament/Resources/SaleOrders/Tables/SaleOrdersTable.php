<?php

namespace App\Filament\Resources\SaleOrders\Tables;

use App\Enums\SaleOrderStatus;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\Summarizers\Sum;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class SaleOrdersTable
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
                TextColumn::make('subscription.id')
                    ->label('Subscription')
                    ->prefix('#')
                    ->sortable(),
                TextColumn::make('amount')
                    ->money('USD')
                    ->sortable()
                    ->summarize(Sum::make()->money('USD')),
                TextColumn::make('status')
                    ->formatStateUsing(fn (SaleOrderStatus $state): string => $state->label())
                    ->badge()
                    ->color(fn (SaleOrderStatus $state): string => $state->color())
                    ->sortable(),
                TextColumn::make('paid_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->filters([
                SelectFilter::make('status')
                    ->options(SaleOrderStatus::options()),
                Filter::make('today')
                    ->query(fn (Builder $query): Builder => $query->whereDate('created_at', now()->toDateString())),
                Filter::make('this_week')
                    ->label('This Week')
                    ->query(fn (Builder $query): Builder => $query->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()])),
                Filter::make('this_month')
                    ->label('This Month')
                    ->query(fn (Builder $query): Builder => $query->whereBetween('created_at', [now()->startOfMonth(), now()->endOfMonth()])),
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
