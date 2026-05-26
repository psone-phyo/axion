<?php

namespace App\Filament\Resources\SubscriptionProvisions\Pages;

use App\Filament\Resources\SubscriptionProvisions\SubscriptionProvisionResource;
use App\Services\VpnProvisionService;
use App\Support\ByteFormatter;
use Filament\Actions\Action;
use Filament\Actions\EditAction;
use Filament\Forms\Components\TextInput;
use Filament\Notifications\Notification;
use Filament\Resources\Pages\ViewRecord;
use Throwable;

class ViewSubscriptionProvision extends ViewRecord
{
    protected static string $resource = SubscriptionProvisionResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
            Action::make('renameKey')
                ->label('Rename Key')
                ->schema([
                    TextInput::make('name')
                        ->default(fn (): ?string => $this->record->key_name)
                        ->required(),
                ])
                ->action(function (array $data): void {
                    $this->runOutlineAction(fn () => app(VpnProvisionService::class)->renameProvisionKey($this->record, $data['name']), 'Access key renamed');
                }),
            Action::make('setDataLimit')
                ->label('Set Data Limit')
                ->schema([
                    TextInput::make('gigabytes')
                        ->label('Data Limit (GB)')
                        ->numeric()
                        ->required(),
                ])
                ->action(function (array $data): void {
                    $this->runOutlineAction(
                        fn () => app(VpnProvisionService::class)->setProvisionDataLimit(
                            $this->record,
                            ByteFormatter::gigabytesToBytes((float) $data['gigabytes'])
                        ),
                        'Data limit updated'
                    );
                }),
            Action::make('removeDataLimit')
                ->label('Remove Data Limit')
                ->requiresConfirmation()
                ->action(function (): void {
                    $this->runOutlineAction(fn () => app(VpnProvisionService::class)->removeProvisionDataLimit($this->record), 'Data limit removed');
                }),
            Action::make('syncTransfer')
                ->label('Sync Transfer')
                ->action(function (): void {
                    $this->runOutlineAction(function () {
                        $provision = app(VpnProvisionService::class)->syncProvisionTransfer($this->record);

                        Notification::make()
                            ->success()
                            ->title('Transfer synced')
                            ->body('Transferred: ' . ByteFormatter::humanReadable($provision->transferred_bytes))
                            ->send();
                    });
                }),
            Action::make('deleteRemoteKey')
                ->label('Delete Remote Key')
                ->color('danger')
                ->requiresConfirmation()
                ->action(function (): void {
                    $this->runOutlineAction(fn () => app(VpnProvisionService::class)->deleteProvisionKey($this->record), 'Remote access key deleted');
                }),
        ];
    }

    protected function runOutlineAction(callable $callback, ?string $successTitle = null): void
    {
        try {
            $callback();
            $this->record->refresh();

            if ($successTitle) {
                Notification::make()
                    ->success()
                    ->title($successTitle)
                    ->send();
            }
        } catch (Throwable $exception) {
            Notification::make()
                ->danger()
                ->title('Outline API action failed')
                ->body($exception->getMessage())
                ->send();
        }
    }
}
