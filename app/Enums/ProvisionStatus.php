<?php

namespace App\Enums;

enum ProvisionStatus: string
{
    case Active = 'active';
    case Revoked = 'revoked';

    public function label(): string
    {
        return ucfirst($this->value);
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $status): array => [$status->value => $status->label()])
            ->all();
    }

    public static function values(): array
    {
        return array_column(self::cases(), 'value');
    }
}
