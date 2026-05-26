<?php

namespace App\Models;

use App\Enums\CustomerPlatform;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Customer extends Model
{
    protected $fillable = [
        'name',
        'email',
        'phone',
        'platform',
        'profile_url',
    ];

    protected function casts(): array
    {
        return [
            'platform' => CustomerPlatform::class,
        ];
    }

    public function subscriptions(): HasMany
    {
        return $this->hasMany(Subscription::class);
    }
}
