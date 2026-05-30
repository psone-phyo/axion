<?php

namespace App\Filament\Resources\SubscriptionClears\Schemas;

use App\Services\SubscriptionClearService;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Select;
use Filament\Schemas\Components\Grid;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Components\Utilities\Get;
use Filament\Schemas\Schema;

class SubscriptionClearForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Clear Save Details')
                    ->schema([
                        Select::make('user_id')
                            ->label('Admin')
                            ->relationship('user', 'name')
                            ->searchable()
                            ->preload()
                            ->default(auth()->id())
                            ->required()
                            ->live(),
                        DateTimePicker::make('clear_date')
                            ->label('Clear Date')
                            ->seconds(false)
                            ->native(false)
                            ->default(now())
                            ->required()
                            ->live(),
                        Grid::make(2)
                            ->schema([
                                Placeholder::make('eligible_subscriptions')
                                    ->label('Eligible Subscriptions')
                                    ->content(function (Get $get): string {
                                        $summary = app(SubscriptionClearService::class)->summarize($get('user_id'), $get('clear_date'));

                                        return number_format($summary['count']);
                                    }),
                                Placeholder::make('eligible_total')
                                    ->label('Eligible Total')
                                    ->content(function (Get $get): string {
                                        $summary = app(SubscriptionClearService::class)->summarize($get('user_id'), $get('clear_date'));

                                        return number_format($summary['total'], 2) . ' MMK';
                                    }),
                            ]),
                    ]),
            ]);
    }
}
