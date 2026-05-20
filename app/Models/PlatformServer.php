<?php

namespace App\Models;

use Database\Factories\PlatformServerFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\Pivot;

class PlatformServer extends Pivot
{
    /** @use HasFactory<PlatformServerFactory> */
    use HasFactory;

    protected $table = 'platform_servers';

    protected $fillable = [
        'platform_id',
        'server_id',
        'is_active',
    ];

    protected function casts(): array
    {
        return [
            'is_active' => 'boolean',
        ];
    }

    public function platform(): BelongsTo
    {
        return $this->belongsTo(Platform::class);
    }

    public function server(): BelongsTo
    {
        return $this->belongsTo(Server::class);
    }
}
