<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Platform extends Model
{
    protected $fillable = [
        'name',
        'description',
    ];

    public function servers(): HasMany
    {
        return $this->hasMany(Server::class);
    }

    public function services(): HasMany
    {
        return $this->hasMany(Service::class);
    }
}
