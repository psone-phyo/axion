<?php

namespace App\Policies;

use App\Enums\UserRole;
use App\Models\Service;
use App\Models\User;

class ServicePolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isAdmin() || $user->role === UserRole::Staff;
    }

    public function view(User $user, Service $service): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function update(User $user, Service $service): bool
    {
        return $this->viewAny($user);
    }

    public function delete(User $user, Service $service): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, Service $service): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, Service $service): bool
    {
        return $user->isAdmin();
    }
}
