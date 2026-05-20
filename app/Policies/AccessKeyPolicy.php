<?php

namespace App\Policies;

use App\Enums\UserRole;
use App\Models\AccessKey;
use App\Models\User;

class AccessKeyPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isAdmin() || $user->role === UserRole::Staff;
    }

    public function view(User $user, AccessKey $accessKey): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function update(User $user, AccessKey $accessKey): bool
    {
        return $this->viewAny($user);
    }

    public function delete(User $user, AccessKey $accessKey): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, AccessKey $accessKey): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, AccessKey $accessKey): bool
    {
        return $user->isAdmin();
    }
}
