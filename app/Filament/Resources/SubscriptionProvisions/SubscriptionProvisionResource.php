<?php

namespace App\Filament\Resources\SubscriptionProvisions;

use App\Filament\Resources\SubscriptionProvisions\Pages\CreateSubscriptionProvision;
use App\Filament\Resources\SubscriptionProvisions\Pages\EditSubscriptionProvision;
use App\Filament\Resources\SubscriptionProvisions\Pages\ListSubscriptionProvisions;
use App\Filament\Resources\SubscriptionProvisions\Pages\ViewSubscriptionProvision;
use App\Filament\Resources\SubscriptionProvisions\Schemas\SubscriptionProvisionForm;
use App\Filament\Resources\SubscriptionProvisions\Schemas\SubscriptionProvisionInfolist;
use App\Filament\Resources\SubscriptionProvisions\Tables\SubscriptionProvisionsTable;
use App\Models\SubscriptionProvision;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;
use UnitEnum;

class SubscriptionProvisionResource extends Resource
{
    protected static ?string $model = SubscriptionProvision::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedKey;

    protected static string|UnitEnum|null $navigationGroup = 'VPN Management';

    protected static ?int $navigationSort = 6;

    protected static ?string $recordTitleAttribute = 'key_name';

    public static function form(Schema $schema): Schema
    {
        return SubscriptionProvisionForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return SubscriptionProvisionInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return SubscriptionProvisionsTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListSubscriptionProvisions::route('/'),
            'create' => CreateSubscriptionProvision::route('/create'),
            'view' => ViewSubscriptionProvision::route('/{record}'),
            'edit' => EditSubscriptionProvision::route('/{record}/edit'),
        ];
    }
}
