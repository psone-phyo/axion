<?php

namespace Database\Seeders;

use App\Enums\CustomerPlatform;
use App\Models\Customer;
use Illuminate\Database\Seeder;

class CustomerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Customer::factory()->count(20)->create();

        Customer::query()->updateOrCreate(
            ['name' => 'Aung Naing'],
            [
                'username' => 'aung.naing',
                'email' => 'aung@example.com',
                'phone' => '+95 912345678',
                'platform' => CustomerPlatform::Telegram,
                'status' => true,
            ],
        );
    }
}
