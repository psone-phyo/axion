<?php

use App\Enums\ServerProvider;
use App\Enums\ServerStatus;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('servers', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->ipAddress('ip_address');
            $table->string('region');
            $table->enum('provider', ServerProvider::values());
            $table->string('api_url')->nullable();
            $table->text('api_key')->nullable();
            $table->string('status')->default(ServerStatus::Active->value)->index();
            $table->timestamps();

            $table->index(['provider', 'status']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('servers');
    }
};
