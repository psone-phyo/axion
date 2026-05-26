<?php

namespace App\Services;

use App\Exceptions\OutlineApiException;
use App\Models\Server;
use Illuminate\Http\Client\PendingRequest;
use Illuminate\Support\Facades\Http;

class OutlineApiService
{
    public function createAccessKey(Server $server, array $payload = []): array
    {
        return $this->request($server)
            ->post('/access-keys', $payload)
            ->throw()
            ->json();
    }

    public function renameAccessKey(Server $server, string $keyId, string $name): void
    {
        $this->request($server)
            ->put("/access-keys/{$keyId}/name", [
                'name' => $name,
            ])
            ->throw();
    }

    public function deleteAccessKey(Server $server, string $keyId): void
    {
        $this->request($server)
            ->delete("/access-keys/{$keyId}")
            ->throw();
    }

    public function setDataLimit(Server $server, string $keyId, int $bytes): void
    {
        $this->request($server)
            ->put("/access-keys/{$keyId}/data-limit", [
                'limit' => [
                    'bytes' => $bytes,
                ],
            ])
            ->throw();
    }

    public function removeDataLimit(Server $server, string $keyId): void
    {
        $this->request($server)
            ->delete("/access-keys/{$keyId}/data-limit")
            ->throw();
    }

    public function getTransferredBytesByAccessKey(Server $server): array
    {
        return $this->request($server)
            ->get('/metrics/transfer')
            ->throw()
            ->json('bytesTransferredByUserId', []);
    }

    protected function request(Server $server): PendingRequest
    {
        if (blank($server->api_url)) {
            throw new OutlineApiException("Server [{$server->name}] does not have an Outline API URL configured.");
        }

        return Http::acceptJson()
            ->asJson()
            ->baseUrl(rtrim($server->api_url, '/'))
            ->timeout((int) config('services.outline.timeout', 15))
            ->withOptions([
                'verify' => (bool) config('services.outline.verify_ssl', false),
            ]);
    }
}
