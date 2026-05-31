<?php

namespace App\Filament\Resources\Subscriptions\Schemas;

use App\Enums\Region;
use App\Enums\SubscriptionStatus;
use App\Enums\CustomerPlatform;
use App\Models\Platform;
use App\Models\Service;
use App\Models\Subscription;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Hidden;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
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
                                Select::make('platform_id')
                                    ->label('Platform')
                                    ->options(fn (): array => Platform::query()->orderBy('name')->pluck('name', 'id')->all())
                                    ->searchable()
                                    ->preload()
                                    ->required()
                                    ->live()
                                    ->dehydrated(false)
                                    ->afterStateHydrated(function (Set $set, ?Subscription $record): void {
                                        $set('platform_id', $record?->service?->platform_id);
                                    })
                                    ->afterStateUpdated(function (Set $set, Get $get, $state): void {
                                        $selectedService = filled($get('service_id'))
                                            ? Service::query()->find($get('service_id'))
                                            : null;

                                        if ($selectedService?->platform_id !== (int) $state) {
                                            $set('service_id', null);
                                            $set('original_price', null);
                                            $set('discount', 0);
                                            $set('final_price', null);
                                            $set('end_date', null);
                                        }
                                    }),
                                Select::make('region')
                                    ->label('Region')
                                    ->options(Region::options())
                                    ->required()
                                    ->live()
                                    ->dehydrated(false)
                                    ->afterStateHydrated(function (Set $set, ?Subscription $record): void {
                                        $set('region', $record?->service?->region?->value);
                                    })
                                    ->afterStateUpdated(function (Set $set, Get $get, $state): void {
                                        $selectedService = filled($get('service_id'))
                                            ? Service::query()->find($get('service_id'))
                                            : null;

                                        if ($selectedService?->region?->value !== $state) {
                                            $set('service_id', null);
                                            $set('original_price', null);
                                            $set('discount', 0);
                                            $set('final_price', null);
                                            $set('end_date', null);
                                        }
                                    }),
                                Select::make('service_id')
                                    ->options(function (Get $get): array {
                                        if (blank($get('platform_id')) || blank($get('region'))) {
                                            return [];
                                        }

                                        return Service::query()
                                            ->where('is_active', true)
                                            ->where('platform_id', $get('platform_id'))
                                            ->where('region', $get('region'))
                                            ->orderBy('name')
                                            ->pluck('name', 'id')
                                            ->all();
                                    })
                                    ->required()
                                    ->searchable()
                                    ->preload()
                                    ->live()
                                    ->helperText('Select platform and region first.')
                                    ->afterStateUpdated(function (Set $set, Get $get, $state): void {
                                        self::syncPricing($set, $get, $state);
                                        self::syncEndDate($set, $get, $state);
                                    }),
                                Hidden::make('status')
                                    ->default(SubscriptionStatus::Active->value)
                                    ->dehydrated(fn (string $operation): bool => $operation === 'create'),
                                Select::make('status')
                                    ->options(SubscriptionStatus::options())
                                    ->required()
                                    ->disabled(fn ($record): bool => in_array($record?->status, [SubscriptionStatus::Expired, SubscriptionStatus::Cancelled], true))
                                    ->visible(fn (string $operation): bool => $operation === 'edit'),
                                TextInput::make('original_price')
                                    ->label('Service Price')
                                    ->numeric()
                                    ->prefix('MMK')
                                    ->readOnly()
                                    ->required()
                                    ->visible(fn (string $operation): bool => $operation === 'create'),
                                TextInput::make('discount')
                                    ->numeric()
                                    ->default(0)
                                    ->prefix('MMK')
                                    ->live(onBlur: true)
                                    ->afterStateUpdated(function (Set $set, Get $get): void {
                                        self::recalculateFinalPrice($set, $get);
                                    })
                                    ->required()
                                    ->visible(fn (string $operation): bool => $operation === 'create'),
                                TextInput::make('final_price')
                                    ->label('Final Price')
                                    ->numeric()
                                    ->prefix('MMK')
                                    ->readOnly()
                                    ->required()
                                    ->visible(fn (string $operation): bool => $operation === 'create'),
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
                                Textarea::make('remark')
                                    ->rows(3)
                                    ->columnSpanFull(),
                            ]),
                    ]),
            ]);
    }

    protected static function syncPricing(Set $set, Get $get, mixed $serviceId): void
    {
        if (! $serviceId) {
            return;
        }

        $service = Service::query()->find($serviceId);

        if (! $service) {
            return;
        }

        $set('original_price', (float) $service->price);
        self::recalculateFinalPrice($set, $get);
    }

    protected static function recalculateFinalPrice(Set $set, Get $get): void
    {
        $originalPrice = (float) ($get('original_price') ?: 0);
        $discount = (float) ($get('discount') ?: 0);

        $set('final_price', max($originalPrice - $discount, 0));
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
