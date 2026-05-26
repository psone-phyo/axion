<?php

namespace App\Models;

use App\Enums\Region;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Service extends Model
{
    protected $fillable = [
        'platform_id',
        'name',
        'duration_days',
        'price',
        'region',
        'is_active',
    ];

    protected function casts(): array
    {
        return [
            'region' => Region::class,
            'price' => 'decimal:2',
            'is_active' => 'boolean',
        ];
    }

    public function platform(): BelongsTo
    {
        return $this->belongsTo(Platform::class);
    }

    public function subscriptions(): HasMany
    {
        return $this->hasMany(Subscription::class);
    }
}
