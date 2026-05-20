<?php

namespace App\Enums;

use App\Enums\Concerns\HasOptions;

enum ServerProvider: string
{
    use HasOptions;

    case Manual = 'manual';
    case DigitalOcean = 'digitalocean';

    public function label(): string
    {
        return match ($this) {
            self::Manual => 'Manual',
            self::DigitalOcean => 'DigitalOcean',
        };
    }
}
