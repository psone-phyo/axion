<?php

namespace App\Enums;

use App\Enums\Concerns\HasOptions;

enum SubscriptionStatus: string
{
    use HasOptions;

    case Active = 'active';
    case Expired = 'expired';
    case Suspended = 'suspended';
    case Cancelled = 'cancelled';

    public function label(): string
    {
        return ucfirst($this->value);
    }

    public function color(): string
    {
        return match ($this) {
            self::Active => 'success',
            self::Expired => 'danger',
            self::Suspended => 'warning',
            self::Cancelled => 'gray',
        };
    }
}
