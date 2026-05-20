<?php

namespace App\Models;

use App\Enums\AccessKeyType;
use Database\Factories\AccessKeyFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Str;

class AccessKey extends Model
{
    /** @use HasFactory<AccessKeyFactory> */
    use HasFactory;

    protected $fillable = [
        'subscription_id',
        'type',
        'external_id',
        'access_key',
        'username',
        'is_active',
    ];

    protected function casts(): array
    {
        return [
            'type' => AccessKeyType::class,
            'is_active' => 'boolean',
        ];
    }

    public function subscription(): BelongsTo
    {
        return $this->belongsTo(Subscription::class);
    }

    public function maskedKeyPreview(): string
    {
        return Str::mask($this->access_key, '*', 8, max(strlen($this->access_key) - 16, 0));
    }
}
