<?php

namespace App\Filament\Resources\Services\Tables;

use App\Enums\Region;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;

class ServicesTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('platform.name')
                    ->label('Platform')
                    ->sortable(),
                TextColumn::make('name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('duration_days')
                    ->suffix(' days')
                    ->sortable(),
                TextColumn::make('price')
                    ->money('MMK')
                    ->sortable(),
                TextColumn::make('region')
                    ->badge()
                    ->formatStateUsing(fn (Region|string|null $state): ?string => $state instanceof Region ? $state->label() : $state),
                TextColumn::make('is_active')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn (bool $state): string => $state ? 'Active' : 'Inactive')
                    ->color(fn (bool $state): string => $state ? 'success' : 'danger'),
            ])
            ->filters([
                SelectFilter::make('platform')
                    ->relationship('platform', 'name'),
                SelectFilter::make('region')
                    ->options(Region::options()),
                SelectFilter::make('is_active')
                    ->options([
                        '1' => 'Active',
                        '0' => 'Inactive',
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
            ])
            ->defaultSort('name');
    }
}
