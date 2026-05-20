<?php

namespace App\Models;

use App\Enums\ServerProvider;
use App\Enums\ServerStatus;
use Database\Factories\ServerFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Server extends Model
{
    /** @use HasFactory<ServerFactory> */
    use HasFactory;

    protected $fillable = [
        'name',
        'ip_address',
        'region',
        'provider',
        'api_url',
        'api_key',
        'status',
    ];

    protected function casts(): array
    {
        return [
            'provider' => ServerProvider::class,
            'status' => ServerStatus::class,
            'api_key' => 'encrypted',
        ];
    }

    public function platforms(): BelongsToMany
    {
        return $this->belongsToMany(Platform::class, 'platform_servers')
            ->using(PlatformServer::class)
            ->withPivot(['id', 'is_active'])
            ->withTimestamps();
    }

    public function subscriptions(): HasMany
    {
        return $this->hasMany(Subscription::class);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('status', ServerStatus::Active);
    }
}
