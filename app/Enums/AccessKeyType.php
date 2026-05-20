<?php

namespace App\Enums;

use App\Enums\Concerns\HasOptions;

enum AccessKeyType: string
{
    use HasOptions;

    case Outline = 'outline';
    case Vless = 'vless';
    case V2Box = 'v2box';

    public function label(): string
    {
        return match ($this) {
            self::Outline => 'Outline',
            self::Vless => 'VLESS',
            self::V2Box => 'V2Box',
        };
    }
}
