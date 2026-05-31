<?php

namespace App\Filament\Resources\Servers\Tables;

use App\Enums\Region;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;

class ServersTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('platforms.name')
                    ->label('Platforms')
                    ->badge()
                    ->listWithLineBreaks(),
                TextColumn::make('name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('ip')
                    ->label('IP Address')
                    ->searchable(),
                TextColumn::make('api_url')
                    ->label('API URL')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('region')
                    ->badge()
                    ->formatStateUsing(fn (Region|string|null $state): ?string => $state instanceof Region ? $state->label() : $state),
                TextColumn::make('price')
                    ->money('USD')
                    ->sortable(),
                TextColumn::make('capacity')
                    ->sortable(),
                TextColumn::make('active_provisions_count')
                    ->counts('provisions')
                    ->label('Provisions')
                    ->sortable(),
                TextColumn::make('is_active')
                    ->label('Status')
                    ->badge()
                    ->formatStateUsing(fn (bool $state): string => $state ? 'Active' : 'Inactive')
                    ->color(fn (bool $state): string => $state ? 'success' : 'danger'),
            ])
            ->filters([
                SelectFilter::make('platform')
                    ->relationship('platforms', 'name'),
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
