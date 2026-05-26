<?php

use App\Enums\Region;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('servers', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('platform_id')->constrained()->cascadeOnDelete();
            $table->string('name');
            $table->string('ip');
            $table->enum('region', Region::values());
            $table->decimal('price', 10, 2);
            $table->unsignedInteger('capacity');
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->index(['platform_id', 'region', 'is_active']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('servers');
    }
};
