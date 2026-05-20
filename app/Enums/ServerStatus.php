<?php

namespace App\Enums;

use App\Enums\Concerns\HasOptions;

enum ServerStatus: string
{
    use HasOptions;

    case Active = 'active';
    case Maintenance = 'maintenance';
    case Offline = 'offline';

    public function label(): string
    {
        return ucfirst($this->value);
    }

    public function color(): string
    {
        return match ($this) {
            self::Active => 'success',
            self::Maintenance => 'warning',
            self::Offline => 'danger',
        };
    }
}
