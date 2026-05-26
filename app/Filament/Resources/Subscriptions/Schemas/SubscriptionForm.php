<?php

namespace App\Filament\Resources\Subscriptions\Schemas;

use App\Enums\SubscriptionStatus;
use App\Enums\CustomerPlatform;
use App\Models\Service;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Toggle;
use Filament\Schemas\Components\Fieldset;
use Filament\Schemas\Components\Grid;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Components\Utilities\Get;
use Filament\Schemas\Components\Utilities\Set;
use Filament\Schemas\Schema;
use Illuminate\Support\Carbon;

class SubscriptionForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Subscription Details')
                    ->schema([
                        Grid::make(2)
                            ->schema([
                                Toggle::make('create_customer')
                                    ->label('Create new customer')
                                    ->default(false)
                                    ->live()
                                    ->visible(fn (string $operation): bool => $operation === 'create')
                                    ->columnSpanFull(),
                                Select::make('customer_id')
                                    ->relationship('customer', 'name')
                                    ->required(fn (Get $get, string $operation): bool => ! ($operation === 'create' && $get('create_customer')))
                                    ->searchable()
                                    ->preload()
                                    ->dehydrated(fn (Get $get, string $operation): bool => ! ($operation === 'create' && $get('create_customer')))
                                    ->visible(fn (Get $get, string $operation): bool => ! ($operation === 'create' && $get('create_customer'))),
                                Fieldset::make('New Customer')
                                    ->schema([
                                        Grid::make(2)
                                            ->schema([
                                                TextInput::make('customer_name')
                                                    ->label('Name')
                                                    ->required(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                                    ->dehydrated(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                                    ->maxLength(255),
                                                Select::make('customer_platform')
                                                    ->label('Lead Platform')
                                                    ->options(CustomerPlatform::options())
                                                    ->required(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                                    ->dehydrated(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                                    ->searchable()
                                                    ->preload(),
                                                TextInput::make('customer_email')
                                                    ->label('Email')
                                                    ->email()
                                                    ->dehydrated(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                                    ->maxLength(255),
                                                TextInput::make('customer_phone')
                                                    ->label('Phone')
                                                    ->tel()
                                                    ->dehydrated(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                                    ->maxLength(255),
                                                TextInput::make('customer_profile_url')
                                                    ->label('Profile URL')
                                                    ->url()
                                                    ->required(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                                    ->dehydrated(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                                    ->columnSpanFull(),
                                            ]),
                                    ])
                                    ->visible(fn (Get $get, string $operation): bool => $operation === 'create' && (bool) $get('create_customer'))
                                    ->columnSpanFull(),
                                Select::make('service_id')
                                    ->relationship('service', 'name', modifyQueryUsing: fn ($query) => $query->where('is_active', true))
                                    ->required()
                                    ->searchable()
                                    ->preload()
                                    ->live()
                                    ->afterStateUpdated(function (Set $set, Get $get, $state): void {
                                        self::syncEndDate($set, $get, $state);
                                    }),
                                Select::make('status')
                                    ->options(SubscriptionStatus::options())
                                    ->default(SubscriptionStatus::Active->value)
                                    ->required(),
                                DatePicker::make('start_date')
                                    ->required()
                                    ->default(now()->toDateString())
                                    ->live()
                                    ->afterStateUpdated(function (Set $set, Get $get): void {
                                        self::syncEndDate($set, $get, $get('service_id'));
                                    }),
                                DatePicker::make('end_date')
                                    ->required()
                                    ->helperText('Auto-calculated from the selected service, but can be adjusted if needed.'),
                            ]),
                    ]),
            ]);
    }

    protected static function syncEndDate(Set $set, Get $get, mixed $serviceId): void
    {
        if (! $serviceId || ! $get('start_date')) {
            return;
        }

        $service = Service::query()->find($serviceId);

        if (! $service) {
            return;
        }

        $set(
            'end_date',
            Carbon::parse($get('start_date'))
                ->addDays($service->duration_days)
                ->toDateString()
        );
    }
}
