<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        $roles = collect([
            'super_admin',
            'admin',
            'support',
        ])->mapWithKeys(fn (string $name): array => [
            $name => Role::findOrCreate($name, 'web'),
        ]);

        $permissions = Permission::query()->get();

        $roles['super_admin']->syncPermissions($permissions);
        $roles['admin']->syncPermissions($permissions->where('name', '!=', 'view_logs'));
        $roles['support']->syncPermissions(
            $permissions->filter(fn (Permission $permission): bool => str_starts_with($permission->name, 'View'))
        );

        $admin = User::query()->updateOrCreate(
            ['email' => 'admin@axionservice.shop'],
            [
                'name' => 'Axion Super Admin',
                'password' => 'admin@secret',
            ]
        );

        $admin->syncRoles([$roles['super_admin']]);
        $admin->syncPermissions($permissions);
    }
}
