<?php

namespace App\Models;

use App\Enums\SubscriptionStatus;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Subscription extends Model
{
    protected $fillable = [
        'customer_id',
        'service_id',
        'created_by',
        'remark',
        'status',
        'start_date',
        'end_date',
    ];

    protected function casts(): array
    {
        return [
            'status' => SubscriptionStatus::class,
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

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function provisions(): HasMany
    {
        return $this->hasMany(SubscriptionProvision::class);
    }

    public function payments(): HasMany
    {
        return $this->hasMany(SubscriptionPayment::class);
    }

    public function latestPayment(): HasOne
    {
        return $this->hasOne(SubscriptionPayment::class)->latestOfMany();
    }

    public function hasUnclearedPayments(): bool
    {
        return $this->payments()->whereNull('clear_id')->exists();
    }

    public function latestClearedPayment(): ?SubscriptionPayment
    {
        return $this->payments()->whereNotNull('clear_id')->latest('id')->first();
    }

    public function usageLogs(): HasMany
    {
        return $this->hasMany(ServerUsageLog::class);
    }
}
