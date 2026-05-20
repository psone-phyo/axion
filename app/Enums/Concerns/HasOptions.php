<?php

namespace App\Enums\Concerns;

trait HasOptions
{
    public static function options(): array
    {
        return collect(static::cases())
            ->mapWithKeys(fn (self $case): array => [$case->value => $case->label()])
            ->all();
    }

    public static function values(): array
    {
        return array_column(static::cases(), 'value');
    }
}
