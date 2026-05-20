<?php

namespace Database\Factories;

use App\Enums\ServerProvider;
use App\Enums\ServerStatus;
use App\Models\Server;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Server>
 */
class ServerFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => sprintf('%s Node %s', fake()->randomElement(['Singapore', 'Tokyo', 'Frankfurt', 'New York']), fake()->unique()->numberBetween(1, 99)),
            'ip_address' => fake()->ipv4(),
            'region' => fake()->randomElement(['Singapore', 'Tokyo', 'Frankfurt', 'New York']),
            'provider' => fake()->randomElement(ServerProvider::cases()),
            'api_url' => fake()->optional()->url(),
            'api_key' => fake()->optional()->sha256(),
            'status' => fake()->randomElement(ServerStatus::cases()),
        ];
    }
}
