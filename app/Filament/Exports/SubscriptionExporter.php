<?php

namespace App\Filament\Exports;

use App\Models\Subscription;
use Filament\Actions\Exports\Enums\ExportFormat;
use Filament\Actions\Exports\ExportColumn;
use Filament\Actions\Exports\Exporter;
use Filament\Actions\Exports\Models\Export;
use Filament\Forms\Components\DatePicker;
use Illuminate\Support\Number;

class SubscriptionExporter extends Exporter
{
    protected static ?string $model = Subscription::class;

    public static function getColumns(): array
    {
        return [
            ExportColumn::make('id')->label('Subscription ID'),
            ExportColumn::make('customer.name')->label('Customer'),
            ExportColumn::make('service.name')->label('Service'),
            ExportColumn::make('service.platform.name')->label('Platform'),
            ExportColumn::make('creator.name')->label('Created By'),
            ExportColumn::make('original_price')->label('Service Price'),
            ExportColumn::make('discount')->label('Discount'),
            ExportColumn::make('final_price')->label('Final Price'),
            ExportColumn::make('status')->label('Status'),
            ExportColumn::make('start_date')->label('Start Date'),
            ExportColumn::make('end_date')->label('End Date'),
            ExportColumn::make('remark')->label('Remark'),
            ExportColumn::make('created_at')->label('Created At'),
        ];
    }

    public static function getOptionsFormComponents(): array
    {
        return [
            DatePicker::make('created_from')
                ->label('Created From'),
            DatePicker::make('created_until')
                ->label('Created Until'),
        ];
    }

    public function getFormats(): array
    {
        return [ExportFormat::Xlsx];
    }

    public static function getCompletedNotificationBody(Export $export): string
    {
        $body = 'Your subscription export has completed and ' . Number::format($export->successful_rows) . ' ' . str('row')->plural($export->successful_rows) . ' exported.';

        if ($failedRowsCount = $export->getFailedRowsCount()) {
            $body .= ' ' . Number::format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to export.';
        }

        return $body;
    }
}
