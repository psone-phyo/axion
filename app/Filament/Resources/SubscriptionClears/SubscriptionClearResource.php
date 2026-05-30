<?php

namespace App\Filament\Resources\SubscriptionClears;

use App\Filament\Resources\SubscriptionClears\Pages\CreateSubscriptionClear;
use App\Filament\Resources\SubscriptionClears\Pages\ListSubscriptionClears;
use App\Filament\Resources\SubscriptionClears\Pages\ViewSubscriptionClear;
use App\Filament\Resources\SubscriptionClears\RelationManagers\SubscriptionPaymentsRelationManager;
use App\Filament\Resources\SubscriptionClears\Schemas\SubscriptionClearForm;
use App\Filament\Resources\SubscriptionClears\Schemas\SubscriptionClearInfolist;
use App\Filament\Resources\SubscriptionClears\Tables\SubscriptionClearsTable;
use App\Models\SubscriptionClear;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;
use UnitEnum;

class SubscriptionClearResource extends Resource
{
    protected static ?string $model = SubscriptionClear::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedClipboardDocumentList;

    protected static string|UnitEnum|null $navigationGroup = 'VPN Management';

    protected static ?int $navigationSort = 7;

    protected static ?string $recordTitleAttribute = 'id';

    public static function form(Schema $schema): Schema
    {
        return SubscriptionClearForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return SubscriptionClearInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return SubscriptionClearsTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            SubscriptionPaymentsRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListSubscriptionClears::route('/'),
            'create' => CreateSubscriptionClear::route('/create'),
            'view' => ViewSubscriptionClear::route('/{record}'),
        ];
    }
}
