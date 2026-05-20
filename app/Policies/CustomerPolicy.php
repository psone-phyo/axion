<?php

namespace App\Policies;

use App\Enums\UserRole;
use App\Models\Customer;
use App\Models\User;

class CustomerPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isAdmin() || $user->role === UserRole::Staff;
    }

    public function view(User $user, Customer $customer): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function update(User $user, Customer $customer): bool
    {
        return $this->viewAny($user);
    }

    public function delete(User $user, Customer $customer): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, Customer $customer): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, Customer $customer): bool
    {
        return $user->isAdmin();
    }
}
