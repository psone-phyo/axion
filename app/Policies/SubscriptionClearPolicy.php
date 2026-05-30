<?php

declare(strict_types=1);

namespace App\Policies;

use App\Models\SubscriptionClear;
use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Foundation\Auth\User as AuthUser;

class SubscriptionClearPolicy
{
    use HandlesAuthorization;

    public function viewAny(AuthUser $authUser): bool
    {
        return $authUser->can('ViewAny:SubscriptionClear');
    }

    public function view(AuthUser $authUser, SubscriptionClear $subscriptionClear): bool
    {
        return $authUser->can('View:SubscriptionClear');
    }

    public function create(AuthUser $authUser): bool
    {
        return $authUser->can('Create:SubscriptionClear');
    }

    public function update(AuthUser $authUser, SubscriptionClear $subscriptionClear): bool
    {
        return $authUser->can('Update:SubscriptionClear');
    }

    public function delete(AuthUser $authUser, SubscriptionClear $subscriptionClear): bool
    {
        return $authUser->can('Delete:SubscriptionClear');
    }

    public function deleteAny(AuthUser $authUser): bool
    {
        return $authUser->can('DeleteAny:SubscriptionClear');
    }

    public function restore(AuthUser $authUser, SubscriptionClear $subscriptionClear): bool
    {
        return $authUser->can('Restore:SubscriptionClear');
    }

    public function forceDelete(AuthUser $authUser, SubscriptionClear $subscriptionClear): bool
    {
        return $authUser->can('ForceDelete:SubscriptionClear');
    }

    public function forceDeleteAny(AuthUser $authUser): bool
    {
        return $authUser->can('ForceDeleteAny:SubscriptionClear');
    }

    public function restoreAny(AuthUser $authUser): bool
    {
        return $authUser->can('RestoreAny:SubscriptionClear');
    }

    public function replicate(AuthUser $authUser, SubscriptionClear $subscriptionClear): bool
    {
        return $authUser->can('Replicate:SubscriptionClear');
    }

    public function reorder(AuthUser $authUser): bool
    {
        return $authUser->can('Reorder:SubscriptionClear');
    }
}
