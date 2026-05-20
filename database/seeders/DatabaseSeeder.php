<?php

namespace Database\Seeders;

use App\Enums\UserRole;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        User::query()->firstOrCreate(
            ['email' => 'admin@example.com'],
            [
                'name' => 'Admin User',
                'password' => 'password',
                'role' => UserRole::Admin,
                'email_verified_at' => now(),
            ],
        );

        User::query()->firstOrCreate(
            ['email' => 'staff@example.com'],
            [
                'name' => 'Staff User',
                'password' => 'password',
                'role' => UserRole::Staff,
                'email_verified_at' => now(),
            ],
        );

        $this->call([
            PlatformSeeder::class,
            ServerSeeder::class,
            PlatformServerSeeder::class,
            ServiceSeeder::class,
            CustomerSeeder::class,
            SubscriptionSeeder::class,
            SaleOrderSeeder::class,
            AccessKeySeeder::class,
        ]);
    }
}
