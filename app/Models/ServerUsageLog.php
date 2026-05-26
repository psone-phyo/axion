<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ServerUsageLog extends Model
{
    protected $fillable = [
        'server_id',
        'subscription_id',
        'bandwidth_used',
    ];

    protected function casts(): array
    {
        return [
            'bandwidth_used' => 'integer',
        ];
    }

    public function server(): BelongsTo
    {
        return $this->belongsTo(Server::class);
    }

    public function subscription(): BelongsTo
    {
        return $this->belongsTo(Subscription::class);
    }
}
