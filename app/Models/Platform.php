<?php

namespace App\Models;

use App\Enums\PlatformType;
use Database\Factories\PlatformFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Platform extends Model
{
    /** @use HasFactory<PlatformFactory> */
    use HasFactory;

    protected $fillable = [
        'name',
        'type',
        'description',
        'is_active',
    ];

    protected function casts(): array
    {
        return [
            'type' => PlatformType::class,
            'is_active' => 'boolean',
        ];
    }

    public function servers(): BelongsToMany
    {
        return $this->belongsToMany(Server::class, 'platform_servers')
            ->using(PlatformServer::class)
            ->withPivot(['id', 'is_active'])
            ->withTimestamps();
    }

    public function services(): HasMany
    {
        return $this->hasMany(Service::class);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('is_active', true);
    }
}
