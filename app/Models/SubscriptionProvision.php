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
        'outline_access_key_id',
        'external_user_id',
        'access_key',
        'key_name',
        'outline_method',
        'outline_port',
        'data_limit_bytes',
        'transferred_bytes',
        'last_synced_at',
        'last_error',
        'status',
    ];

    protected function casts(): array
    {
        return [
            'status' => ProvisionStatus::class,
            'data_limit_bytes' => 'integer',
            'transferred_bytes' => 'integer',
            'last_synced_at' => 'datetime',
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
