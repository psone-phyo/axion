<?php

namespace App\Models;

use App\Enums\SubscriptionStatus;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Subscription extends Model
{
    protected $fillable = [
        'customer_id',
        'service_id',
        'original_price',
        'discount',
        'final_price',
        'remark',
        'status',
        'start_date',
        'end_date',
    ];

    protected function casts(): array
    {
        return [
            'status' => SubscriptionStatus::class,
            'original_price' => 'decimal:2',
            'discount' => 'decimal:2',
            'final_price' => 'decimal:2',
            'start_date' => 'date',
            'end_date' => 'date',
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

    public function provisions(): HasMany
    {
        return $this->hasMany(SubscriptionProvision::class);
    }

    public function usageLogs(): HasMany
    {
        return $this->hasMany(ServerUsageLog::class);
    }
}
