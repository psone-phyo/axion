<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Platform extends Model
{
    protected $fillable = [
        'name',
        'description',
    ];

    public function servers(): BelongsToMany
    {
        return $this->belongsToMany(Server::class)->withTimestamps();
    }

    public function services(): HasMany
    {
        return $this->hasMany(Service::class);
    }
}
