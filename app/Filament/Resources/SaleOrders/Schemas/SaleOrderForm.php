<?php

namespace App\Filament\Resources\SaleOrders\Schemas;

use App\Enums\SaleOrderStatus;
use App\Models\Subscription;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;

class SaleOrderForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Sale Order')
                    ->schema([
                        Select::make('subscription_id')
                            ->relationship('subscription', 'id')
                            ->searchable()
                            ->preload()
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

                                $set('customer_id', $subscription->customer_id);
                                $set('service_id', $subscription->service_id);
                                $set('amount', $subscription->service->price);
                            }),
                        Select::make('customer_id')
                            ->relationship('customer', 'name')
                            ->searchable()
                            ->preload()
                            ->required(),
                        Select::make('service_id')
                            ->relationship('service', 'name')
                            ->searchable()
                            ->preload()
                            ->required(),
                        TextInput::make('amount')
                            ->numeric()
                            ->required()
                            ->prefix('$')
                            ->minValue(0),
                        Select::make('status')
                            ->options(SaleOrderStatus::options())
                            ->required(),
                        DateTimePicker::make('paid_at'),
                    ])
                    ->columns(2),
            ]);
    }
}
