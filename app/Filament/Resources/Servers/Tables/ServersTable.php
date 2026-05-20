<?php

namespace App\Filament\Resources\Servers\Tables;

use App\Enums\ServerProvider;
use App\Enums\ServerStatus;
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
                TextColumn::make('name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('ip_address')
                    ->label('IP Address')
                    ->searchable(),
                TextColumn::make('region')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('provider')
                    ->formatStateUsing(fn (ServerProvider $state): string => $state->label())
                    ->badge(),
                TextColumn::make('status')
                    ->formatStateUsing(fn (ServerStatus $state): string => $state->label())
                    ->badge()
                    ->color(fn (ServerStatus $state): string => $state->color()),
                TextColumn::make('subscriptions_count')
                    ->counts('subscriptions')
                    ->label('Subscriptions'),
            ])
            ->filters([
                SelectFilter::make('provider')
                    ->options(ServerProvider::options()),
                SelectFilter::make('status')
                    ->options(ServerStatus::options()),
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
