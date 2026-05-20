<?php

namespace App\Filament\Widgets;

use App\Models\SaleOrder;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget;
use Illuminate\Database\Eloquent\Builder;

class LatestSales extends TableWidget
{
    protected static ?string $heading = 'Latest Sales';

    public function table(Table $table): Table
    {
        return $table
            ->query(fn (): Builder => SaleOrder::query()->with(['customer', 'service'])->latest())
            ->columns([
                TextColumn::make('customer.name')
                    ->label('Customer'),
                TextColumn::make('service.name')
                    ->label('Service'),
                TextColumn::make('amount')
                    ->money('USD'),
                TextColumn::make('status')
                    ->formatStateUsing(fn ($state): string => $state->label())
                    ->badge()
                    ->color(fn ($state): string => $state->color()),
                TextColumn::make('created_at')
                    ->dateTime(),
            ])
            ->paginated(false);
    }
}
