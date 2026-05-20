<?php

namespace App\Policies;

use App\Enums\UserRole;
use App\Models\Subscription;
use App\Models\User;

class SubscriptionPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isAdmin() || $user->role === UserRole::Staff;
    }

    public function view(User $user, Subscription $subscription): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function update(User $user, Subscription $subscription): bool
    {
        return $this->viewAny($user);
    }

    public function delete(User $user, Subscription $subscription): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, Subscription $subscription): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, Subscription $subscription): bool
    {
        return $user->isAdmin();
    }
}
