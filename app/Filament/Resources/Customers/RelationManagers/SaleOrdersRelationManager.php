<?php

namespace App\Filament\Resources\Customers\RelationManagers;

use App\Enums\SaleOrderStatus;
use App\Models\Subscription;
use Filament\Actions\CreateAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class SaleOrdersRelationManager extends RelationManager
{
    protected static string $relationship = 'saleOrders';

    protected static ?string $title = 'Sale Orders';

    public function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Sale Order')
                    ->schema([
                        Select::make('subscription_id')
                            ->options(
                                $this->getOwnerRecord()
                                    ->subscriptions()
                                    ->with('service')
                                    ->get()
                                    ->mapWithKeys(fn (Subscription $subscription): array => [
                                        $subscription->id => "#{$subscription->id} - {$subscription->service->name}",
                                    ])
                                    ->all()
                            )
                            ->required()
                            ->live()
                            ->afterStateUpdated(function ($state, callable $set): void {
                                if (! $state) {
                                    return;
                                }

                                $subscription = Subscription::query()->with('service')->find($state);

                                if (! $subscription) {
                                    return;
                                }

                                $set('service_id', $subscription->service_id);
                                $set('amount', $subscription->service->price);
                            }),
                        Select::make('service_id')
                            ->relationship('service', 'name')
                            ->searchable()
                            ->preload()
                            ->required(),
                        TextInput::make('amount')
                            ->numeric()
                            ->prefix('$')
                            ->required()
                            ->minValue(0),
                        Select::make('status')
                            ->options(SaleOrderStatus::options())
                            ->required(),
                        DateTimePicker::make('paid_at'),
                    ])
                    ->columns(2),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(fn (Builder $query): Builder => $query->with(['service', 'subscription']))
            ->columns([
                TextColumn::make('service.name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('subscription.id')
                    ->label('Subscription')
                    ->prefix('#')
                    ->sortable(),
                TextColumn::make('amount')
                    ->money('USD')
                    ->sortable(),
                TextColumn::make('status')
                    ->formatStateUsing(fn (SaleOrderStatus $state): string => $state->label())
                    ->color(fn (SaleOrderStatus $state): string => $state->color())
                    ->badge(),
                TextColumn::make('paid_at')
                    ->dateTime()
                    ->sortable(),
            ])
            ->headerActions([
                CreateAction::make(),
            ])
            ->recordActions([
                ViewAction::make(),
                EditAction::make(),
                DeleteAction::make(),
            ]);
    }
}
