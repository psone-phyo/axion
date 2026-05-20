<?php

namespace App\Models;

use App\Enums\CustomerPlatform;
use Database\Factories\CustomerFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Customer extends Model
{
    /** @use HasFactory<CustomerFactory> */
    use HasFactory;

    protected $fillable = [
        'name',
        'username',
        'email',
        'phone',
        'platform',
        'status',
    ];

    protected function casts(): array
    {
        return [
            'platform' => CustomerPlatform::class,
            'status' => 'boolean',
        ];
    }

    public function subscriptions(): HasMany
    {
        return $this->hasMany(Subscription::class);
    }

    public function saleOrders(): HasMany
    {
        return $this->hasMany(SaleOrder::class);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('status', true);
    }
}
