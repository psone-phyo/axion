<?php

namespace App\Models;

use App\Enums\SaleOrderStatus;
use Database\Factories\SaleOrderFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SaleOrder extends Model
{
    /** @use HasFactory<SaleOrderFactory> */
    use HasFactory;

    protected $fillable = [
        'customer_id',
        'service_id',
        'subscription_id',
        'amount',
        'status',
        'paid_at',
    ];

    protected function casts(): array
    {
        return [
            'amount' => 'decimal:2',
            'status' => SaleOrderStatus::class,
            'paid_at' => 'datetime',
        ];
    }

    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class);
    }

    public function service(): BelongsTo
    {
        return $this->belongsTo(Service::class);
    }

    public function subscription(): BelongsTo
    {
        return $this->belongsTo(Subscription::class);
    }

    public function isPaid(): bool
    {
        return $this->status === SaleOrderStatus::Paid;
    }

    public function scopePaid(Builder $query): Builder
    {
        return $query->where('status', SaleOrderStatus::Paid);
    }
}
