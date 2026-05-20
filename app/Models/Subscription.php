<?php

namespace App\Models;

use App\Enums\SubscriptionStatus;
use Database\Factories\SubscriptionFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Subscription extends Model
{
    /** @use HasFactory<SubscriptionFactory> */
    use HasFactory;

    protected $fillable = [
        'customer_id',
        'service_id',
        'server_id',
        'status',
        'starts_at',
        'ends_at',
        'created_by_user_id',
    ];

    protected function casts(): array
    {
        return [
            'status' => SubscriptionStatus::class,
            'starts_at' => 'datetime',
            'ends_at' => 'datetime',
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

    public function server(): BelongsTo
    {
        return $this->belongsTo(Server::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by_user_id');
    }

    public function saleOrders(): HasMany
    {
        return $this->hasMany(SaleOrder::class);
    }

    public function accessKeys(): HasMany
    {
        return $this->hasMany(AccessKey::class);
    }

    public function isExpired(): bool
    {
        return $this->status === SubscriptionStatus::Expired
            || $this->ends_at?->isPast() === true;
    }

    public function daysRemaining(): int
    {
        if ($this->isExpired() || blank($this->ends_at)) {
            return 0;
        }

        return max(0, now()->startOfDay()->diffInDays($this->ends_at->copy()->startOfDay(), false));
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query
            ->where('status', SubscriptionStatus::Active)
            ->where('ends_at', '>=', now());
    }

    public function scopeExpired(Builder $query): Builder
    {
        return $query->where(function (Builder $query): void {
            $query
                ->where('status', SubscriptionStatus::Expired)
                ->orWhere('ends_at', '<', now());
        });
    }
}
