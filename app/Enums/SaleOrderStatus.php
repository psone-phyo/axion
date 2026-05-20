<?php

namespace App\Enums;

use App\Enums\Concerns\HasOptions;

enum SaleOrderStatus: string
{
    use HasOptions;

    case Paid = 'paid';
    case Pending = 'pending';
    case Unpaid = 'unpaid';
    case Refunded = 'refunded';

    public function label(): string
    {
        return ucfirst($this->value);
    }

    public function color(): string
    {
        return match ($this) {
            self::Paid => 'success',
            self::Pending => 'warning',
            self::Unpaid => 'gray',
            self::Refunded => 'danger',
        };
    }
}
