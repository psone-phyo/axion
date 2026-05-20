<?php

namespace App\Policies;

use App\Models\PlatformServer;
use App\Models\User;

class PlatformServerPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isAdmin();
    }

    public function view(User $user, PlatformServer $platformServer): bool
    {
        return $user->isAdmin();
    }

    public function create(User $user): bool
    {
        return $user->isAdmin();
    }

    public function update(User $user, PlatformServer $platformServer): bool
    {
        return $user->isAdmin();
    }

    public function delete(User $user, PlatformServer $platformServer): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, PlatformServer $platformServer): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, PlatformServer $platformServer): bool
    {
        return $user->isAdmin();
    }
}
