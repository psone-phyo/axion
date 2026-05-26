<?php

namespace App\Models;

use App\Enums\ProvisionStatus;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SubscriptionProvision extends Model
{
    protected $fillable = [
        'subscription_id',
        'server_id',
        'external_user_id',
        'access_key',
        'key_name',
        'status',
    ];

    protected function casts(): array
    {
        return [
            'status' => ProvisionStatus::class,
        ];
    }

    public function subscription(): BelongsTo
    {
        return $this->belongsTo(Subscription::class);
    }

    public function server(): BelongsTo
    {
        return $this->belongsTo(Server::class);
    }
}
