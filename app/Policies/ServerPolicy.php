<?php

namespace App\Policies;

use App\Enums\UserRole;
use App\Models\Server;
use App\Models\User;

class ServerPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isAdmin() || $user->role === UserRole::Staff;
    }

    public function view(User $user, Server $server): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function update(User $user, Server $server): bool
    {
        return $this->viewAny($user);
    }

    public function delete(User $user, Server $server): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, Server $server): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, Server $server): bool
    {
        return $user->isAdmin();
    }
}
