<?php

declare(strict_types=1);

namespace App\Policies;

use Illuminate\Foundation\Auth\User as AuthUser;
use App\Models\SubscriptionProvision;
use Illuminate\Auth\Access\HandlesAuthorization;

class SubscriptionProvisionPolicy
{
    use HandlesAuthorization;
    
    public function viewAny(AuthUser $authUser): bool
    {
        return $authUser->can('ViewAny:SubscriptionProvision');
    }

    public function view(AuthUser $authUser, SubscriptionProvision $subscriptionProvision): bool
    {
        return $authUser->can('View:SubscriptionProvision');
    }

    public function create(AuthUser $authUser): bool
    {
        return $authUser->can('Create:SubscriptionProvision');
    }

    public function update(AuthUser $authUser, SubscriptionProvision $subscriptionProvision): bool
    {
        return $authUser->can('Update:SubscriptionProvision');
    }

    public function delete(AuthUser $authUser, SubscriptionProvision $subscriptionProvision): bool
    {
        return $authUser->can('Delete:SubscriptionProvision');
    }

    public function deleteAny(AuthUser $authUser): bool
    {
        return $authUser->can('DeleteAny:SubscriptionProvision');
    }

    public function restore(AuthUser $authUser, SubscriptionProvision $subscriptionProvision): bool
    {
        return $authUser->can('Restore:SubscriptionProvision');
    }

    public function forceDelete(AuthUser $authUser, SubscriptionProvision $subscriptionProvision): bool
    {
        return $authUser->can('ForceDelete:SubscriptionProvision');
    }

    public function forceDeleteAny(AuthUser $authUser): bool
    {
        return $authUser->can('ForceDeleteAny:SubscriptionProvision');
    }

    public function restoreAny(AuthUser $authUser): bool
    {
        return $authUser->can('RestoreAny:SubscriptionProvision');
    }

    public function replicate(AuthUser $authUser, SubscriptionProvision $subscriptionProvision): bool
    {
        return $authUser->can('Replicate:SubscriptionProvision');
    }

    public function reorder(AuthUser $authUser): bool
    {
        return $authUser->can('Reorder:SubscriptionProvision');
    }

}