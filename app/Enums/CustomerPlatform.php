<?php

namespace App\Enums;

enum CustomerPlatform: string
{
    case Facebook = 'facebook';
    case Tiktok = 'tiktok';
    case Telegram = 'telegram';
    case Whatsapp = 'whatsapp';
    case Viber = 'viber';
    case Other = 'other';

    public function label(): string
    {
        return match ($this) {
            self::Facebook => 'Facebook',
            self::Tiktok => 'TikTok',
            self::Telegram => 'Telegram',
            self::Whatsapp => 'WhatsApp',
            self::Viber => 'Viber',
            self::Other => 'Other',
        };
    }

    public static function options(): array
    {
        return collect(self::cases())
            ->mapWithKeys(fn (self $platform): array => [$platform->value => $platform->label()])
            ->all();
    }
}
