<?php

namespace App\Policies;

use App\Enums\UserRole;
use App\Models\SaleOrder;
use App\Models\User;

class SaleOrderPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->isAdmin() || $user->role === UserRole::Staff;
    }

    public function view(User $user, SaleOrder $saleOrder): bool
    {
        return $this->viewAny($user);
    }

    public function create(User $user): bool
    {
        return $this->viewAny($user);
    }

    public function update(User $user, SaleOrder $saleOrder): bool
    {
        return $this->viewAny($user);
    }

    public function delete(User $user, SaleOrder $saleOrder): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, SaleOrder $saleOrder): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, SaleOrder $saleOrder): bool
    {
        return $user->isAdmin();
    }
}
