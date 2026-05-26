<?php

namespace App\Filament\Resources\Platforms;

use App\Filament\Resources\Platforms\Pages\CreatePlatform;
use App\Filament\Resources\Platforms\Pages\EditPlatform;
use App\Filament\Resources\Platforms\Pages\ListPlatforms;
use App\Filament\Resources\Platforms\Pages\ViewPlatform;
use App\Filament\Resources\Platforms\Schemas\PlatformForm;
use App\Filament\Resources\Platforms\Schemas\PlatformInfolist;
use App\Filament\Resources\Platforms\Tables\PlatformsTable;
use App\Models\Platform;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;
use UnitEnum;

class PlatformResource extends Resource
{
    protected static ?string $model = Platform::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedGlobeAlt;

    protected static string|UnitEnum|null $navigationGroup = 'VPN Management';

    protected static ?int $navigationSort = 1;

    protected static ?string $recordTitleAttribute = 'name';

    public static function form(Schema $schema): Schema
    {
        return PlatformForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return PlatformInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return PlatformsTable::configure($table);
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
            'index' => ListPlatforms::route('/'),
            'create' => CreatePlatform::route('/create'),
            'view' => ViewPlatform::route('/{record}'),
            'edit' => EditPlatform::route('/{record}/edit'),
        ];
    }
}
