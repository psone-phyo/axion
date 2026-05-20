<?php

namespace App\Filament\Resources\AccessKeys;

use App\Filament\Resources\AccessKeys\Pages\CreateAccessKey;
use App\Filament\Resources\AccessKeys\Pages\EditAccessKey;
use App\Filament\Resources\AccessKeys\Pages\ListAccessKeys;
use App\Filament\Resources\AccessKeys\Pages\ViewAccessKey;
use App\Filament\Resources\AccessKeys\Schemas\AccessKeyForm;
use App\Filament\Resources\AccessKeys\Schemas\AccessKeyInfolist;
use App\Filament\Resources\AccessKeys\Tables\AccessKeysTable;
use App\Models\AccessKey;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use UnitEnum;

class AccessKeyResource extends Resource
{
    protected static ?string $model = AccessKey::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::Key;

    protected static string|UnitEnum|null $navigationGroup = 'Infrastructure';

    protected static ?string $recordTitleAttribute = 'id';

    protected static ?int $navigationSort = 2;

    public static function form(Schema $schema): Schema
    {
        return AccessKeyForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return AccessKeyInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return AccessKeysTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with(['subscription.customer', 'subscription.service']);
    }

    public static function getPages(): array
    {
        return [
            'index' => ListAccessKeys::route('/'),
            'create' => CreateAccessKey::route('/create'),
            'view' => ViewAccessKey::route('/{record}'),
            'edit' => EditAccessKey::route('/{record}/edit'),
        ];
    }
}
