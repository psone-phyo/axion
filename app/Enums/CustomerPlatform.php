<?php

namespace App\Enums;

use App\Enums\Concerns\HasOptions;

enum CustomerPlatform: string
{
    use HasOptions;

    case Facebook = 'facebook';
    case Tiktok = 'tiktok';
    case Telegram = 'telegram';
    case Instagram = 'instagram';
    case Offline = 'offline';

    public function label(): string
    {
        return ucfirst($this->value);
    }
}
