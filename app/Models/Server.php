<?php

namespace App\Models;

use App\Enums\Region;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Server extends Model
{
    protected $fillable = [
        'platform_id',
        'name',
        'ip',
        'api_url',
        'region',
        'price',
        'capacity',
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

    public function provisions(): HasMany
    {
        return $this->hasMany(SubscriptionProvision::class);
    }

    public function usageLogs(): HasMany
    {
        return $this->hasMany(ServerUsageLog::class);
    }
}
