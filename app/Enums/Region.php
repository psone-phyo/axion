<?php

namespace App\Enums;

enum Region: string
{
    case Singapore = 'singapore';
    case Japan = 'japan';
    case Usa = 'usa';
    case Thailand = 'thailand';

    public function label(): string
    {
        return match ($this) {
            self::Singapore => 'Singapore',
            self::Japan => 'Japan',
            self::Usa => 'USA',
            self::Thailand => 'Thailand',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $region): array => [$region->value => $region->label()])
            ->all();
    }

    public static function values(): array
    {
        return array_column(self::cases(), 'value');
    }
}
