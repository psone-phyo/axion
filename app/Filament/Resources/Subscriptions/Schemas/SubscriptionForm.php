<?php

namespace App\Filament\Resources\Subscriptions\Schemas;

use App\Enums\SubscriptionStatus;
use App\Models\Service;
use Carbon\Carbon;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Select;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Components\Utilities\Get;
use Filament\Schemas\Schema;

class SubscriptionForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Subscription Details')
                    ->schema([
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
                        Select::make('server_id')
                            ->relationship('server', 'name')
                            ->searchable()
                            ->preload()
                            ->required(),
                        Select::make('status')
                            ->options(SubscriptionStatus::options())
                            ->required(),
                        DateTimePicker::make('starts_at')
                            ->required(),
                        DateTimePicker::make('ends_at')
                            ->required()
                            ->after('starts_at'),
                        Placeholder::make('expiry_preview')
                            ->label('Expiry Preview')
                            ->content(function (Get $get): string {
                                $startsAt = $get('starts_at');
                                $endsAt = $get('ends_at');
                                $serviceId = $get('service_id');
                                $service = $serviceId ? Service::query()->find($serviceId) : null;

                                if (! $startsAt || ! $endsAt) {
                                    return 'Select start and end dates to preview the subscription term.';
                                }

                                $duration = $service?->duration_days ? "{$service->duration_days} day service" : 'Custom term';

                                return "{$duration} ending on ".Carbon::parse($endsAt)->format('M d, Y H:i');
                            })
                            ->columnSpanFull(),
                    ])
                    ->columns(2),
            ]);
    }
}
