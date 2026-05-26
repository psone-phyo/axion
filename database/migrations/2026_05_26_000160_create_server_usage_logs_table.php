<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('server_usage_logs', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('server_id')->constrained()->cascadeOnDelete();
            $table->foreignId('subscription_id')->constrained()->cascadeOnDelete();
            $table->unsignedBigInteger('bandwidth_used')->default(0);
            $table->timestamps();

            $table->index(['server_id', 'subscription_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('server_usage_logs');
    }
};
