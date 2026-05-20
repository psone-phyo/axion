<?php

namespace App\Enums;

use App\Enums\Concerns\HasOptions;

enum PlatformType: string
{
    use HasOptions;

    case Vpn = 'vpn';
    case Music = 'music';
    case Other = 'other';

    public function label(): string
    {
        return match ($this) {
            self::Vpn => 'VPN',
            self::Music => 'Music',
            self::Other => 'Other',
        };
    }
}
