<?php

namespace App\Policies;

use App\Enums\UserRole;
use App\Models\Platform;
use App\Models\User;

class PlatformPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isAdmin() || $user->role === UserRole::Staff;
    }

    public function view(User $user, Platform $platform): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function update(User $user, Platform $platform): bool
    {
        return $this->viewAny($user);
    }

    public function delete(User $user, Platform $platform): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, Platform $platform): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, Platform $platform): bool
    {
        return $user->isAdmin();
    }
}
