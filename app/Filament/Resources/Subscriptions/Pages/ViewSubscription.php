<?php

namespace App\Filament\Resources\Subscriptions\Pages;

use App\Enums\SubscriptionStatus;
use App\Filament\Resources\Subscriptions\SubscriptionResource;
use App\Models\Service;
use App\Services\SubscriptionExtensionService;
use Carbon\Carbon;
use Filament\Actions\Action;
use Filament\Actions\EditAction;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\ViewRecord;
use Filament\Schemas\Components\Utilities\Get;

class ViewSubscription extends ViewRecord
{
    protected static string $resource = SubscriptionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Action::make('extendSubscription')
                ->label('Extend Subscription')
                ->icon('heroicon-o-plus-circle')
                ->visible(fn (): bool => $this->record->status === SubscriptionStatus::Active)
                ->schema([
                    Placeholder::make('customer')
                        ->label('Customer')
                        ->content(fn (): string => $this->record->customer?->name ?? '-'),
                    Placeholder::make('platform')
                        ->label('Platform')
                        ->content(fn (): string => $this->record->service?->platform?->name ?? '-'),
                    Placeholder::make('region')
                        ->label('Region')
                        ->content(fn (): string => $this->record->service?->region?->label() ?? '-'),
                    Select::make('service_id')
                        ->label('Service')
                        ->options(fn (): array => Service::query()
                            ->where('is_active', true)
                            ->where('platform_id', $this->record->service->platform_id)
                            ->where('region', $this->record->service->region->value)
                            ->orderBy('name')
                            ->pluck('name', 'id')
                            ->all())
                        ->required()
                        ->searchable()
                        ->preload()
                        ->live(),
                    Placeholder::make('extension_start_date')
                        ->label('Extension Start Date')
                        ->content(fn (): string => Carbon::parse($this->record->end_date)->addDay()->toDateString()),
                    Placeholder::make('extension_end_date')
                        ->label('Extension End Date')
                        ->content(function (Get $get): string {
                            $service = filled($get('service_id'))
                                ? Service::query()->find($get('service_id'))
                                : null;

                            if (! $service) {
                                return '-';
                            }

                            return Carbon::parse($this->record->end_date)
                                ->addDay()
                                ->addDays($service->duration_days)
                                ->toDateString();
                        }),
                    Placeholder::make('original_price_preview')
                        ->label('Original Price')
                        ->content(function (Get $get): string {
                            $service = filled($get('service_id'))
                                ? Service::query()->find($get('service_id'))
                                : null;

                            return $service ? number_format((float) $service->price, 2) . ' MMK' : '-';
                        }),
                    TextInput::make('discount')
                        ->numeric()
                        ->default(0)
                        ->prefix('MMK')
                        ->live(),
                    Placeholder::make('final_price_preview')
                        ->label('Final Price')
                        ->content(function (Get $get): string {
                            $service = filled($get('service_id'))
                                ? Service::query()->find($get('service_id'))
                                : null;

                            if (! $service) {
                                return '-';
                            }

                            $discount = (float) ($get('discount') ?: 0);
                            $finalPrice = max((float) $service->price - $discount, 0);

                            return number_format($finalPrice, 2) . ' MMK';
                        }),
                    Textarea::make('remark')
                        ->rows(3),
                ])
                ->action(function (array $data): void {
                    $this->record = app(SubscriptionExtensionService::class)->extend(
                        $this->record,
                        $data,
                        auth()->user(),
                    );

                    Notification::make()
                        ->success()
                        ->title('Subscription extended')
                        ->body('The subscription end date and payment history have been updated.')
                        ->send();
                }),
            EditAction::make(),
        ];
    }
}
