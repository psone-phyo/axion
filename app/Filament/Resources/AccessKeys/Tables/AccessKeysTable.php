<?php

namespace App\Filament\Resources\AccessKeys\Tables;

use App\Enums\AccessKeyType;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;

class AccessKeysTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('subscription.id')
                    ->label('Subscription')
                    ->prefix('#')
                    ->sortable(),
                TextColumn::make('subscription.customer.name')
                    ->label('Customer')
                    ->searchable(),
                TextColumn::make('type')
                    ->formatStateUsing(fn ($state): string => $state->label())
                    ->badge(),
                TextColumn::make('masked_preview')
                    ->label('Key Preview')
                    ->state(fn ($record): string => $record->maskedKeyPreview())
                    ->copyableState(fn ($record): string => $record->access_key),
                TextColumn::make('username')
                    ->placeholder('-'),
                IconColumn::make('is_active')
                    ->label('Active')
                    ->boolean(),
            ])
            ->filters([
                SelectFilter::make('type')
                    ->options(AccessKeyType::options()),
                SelectFilter::make('is_active')
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
