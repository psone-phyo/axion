<?php

namespace App\Filament\Resources\Subscriptions\Pages;

use App\Enums\SubscriptionStatus;
use App\Filament\Exports\SubscriptionExporter;
use App\Filament\Resources\Subscriptions\SubscriptionResource;
use App\Models\Subscription;
use Filament\Actions\CreateAction;
use Filament\Actions\ExportAction;
use Filament\Resources\Pages\ListRecords;
use Filament\Schemas\Components\Tabs\Tab;
use Illuminate\Database\Eloquent\Builder;

class ListSubscriptions extends ListRecords
{
    protected static string $resource = SubscriptionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
            ExportAction::make('exportSubscriptions')
                ->label('Export Excel')
                ->exporter(SubscriptionExporter::class)
                ->columnMapping(false)
                ->modifyQueryUsing(function (Builder $query, array $options): Builder {
                    return $query
                        ->when(
                            filled($options['created_from'] ?? null),
                            fn (Builder $query): Builder => $query->whereDate('created_at', '>=', $options['created_from'])
                        )
                        ->when(
                            filled($options['created_until'] ?? null),
                            fn (Builder $query): Builder => $query->whereDate('created_at', '<=', $options['created_until'])
                        );
                }),
        ];
    }

    public function getTabs(): array
    {
        $tomorrow = now()->addDay()->toDateString();

        return [
            'active' => Tab::make('Active')
                ->badge((string) Subscription::query()->where('status', SubscriptionStatus::Active->value)->count())
                ->modifyQueryUsing(fn (Builder $query): Builder => $query->where('status', SubscriptionStatus::Active->value)),
            'expire_soon' => Tab::make('Expire Soon')
                ->badge((string) Subscription::query()
                    ->where('status', SubscriptionStatus::Active->value)
                    ->whereDate('end_date', $tomorrow)
                    ->count())
                ->modifyQueryUsing(fn (Builder $query): Builder => $query
                    ->where('status', SubscriptionStatus::Active->value)
                    ->whereDate('end_date', $tomorrow)),
            'expired' => Tab::make('Expired')
                ->badge((string) Subscription::query()->where('status', SubscriptionStatus::Expired->value)->count())
                ->modifyQueryUsing(fn (Builder $query): Builder => $query->where('status', SubscriptionStatus::Expired->value)),
            'cancelled' => Tab::make('Cancelled')
                ->badge((string) Subscription::query()->where('status', SubscriptionStatus::Cancelled->value)->count())
                ->modifyQueryUsing(fn (Builder $query): Builder => $query->where('status', SubscriptionStatus::Cancelled->value)),
        ];
    }
}
