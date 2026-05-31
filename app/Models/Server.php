<?php

namespace App\Models;

use App\Enums\Region;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Server extends Model
{
    protected $fillable = [
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

    public function platforms(): BelongsToMany
    {
        return $this->belongsToMany(Platform::class)->withTimestamps();
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
