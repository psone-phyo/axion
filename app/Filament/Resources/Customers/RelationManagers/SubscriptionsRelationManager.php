<?php

namespace App\Filament\Resources\Customers\RelationManagers;

use App\Enums\SubscriptionStatus;
use App\Models\Server;
use Filament\Actions\CreateAction;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Select;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class SubscriptionsRelationManager extends RelationManager
{
    protected static string $relationship = 'subscriptions';

    protected static ?string $title = 'Subscriptions';

    public function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                Section::make('Subscription')
                    ->schema([
                        Select::make('service_id')
                            ->relationship('service', 'name')
                            ->searchable()
                            ->preload()
                            ->required(),
                        Select::make('server_id')
                            ->options(Server::query()->pluck('name', 'id')->all())
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
                    ])
                    ->columns(2),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(fn (Builder $query): Builder => $query->with(['service', 'server']))
            ->columns([
                TextColumn::make('service.name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('server.name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('status')
                    ->formatStateUsing(fn (SubscriptionStatus $state): string => $state->label())
                    ->color(fn (SubscriptionStatus $state): string => $state->color())
                    ->badge(),
                TextColumn::make('ends_at')
                    ->dateTime()
                    ->sortable(),
                TextColumn::make('days_remaining')
                    ->label('Days Remaining')
                    ->state(fn ($record): int => $record->daysRemaining())
                    ->sortable(),
            ])
            ->headerActions([
                CreateAction::make()
                    ->mutateDataUsing(fn (array $data): array => [
                        ...$data,
                        'created_by_user_id' => auth()->id(),
                    ]),
            ])
            ->recordActions([
                ViewAction::make(),
                EditAction::make(),
                DeleteAction::make(),
            ]);
    }
}
