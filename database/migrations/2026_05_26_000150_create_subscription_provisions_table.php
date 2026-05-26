<?php

use App\Enums\ProvisionStatus;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('subscription_provisions', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('subscription_id')->constrained()->cascadeOnDelete();
            $table->foreignId('server_id')->constrained()->cascadeOnDelete();
            $table->string('external_user_id');
            $table->text('access_key');
            $table->string('key_name');
            $table->enum('status', ProvisionStatus::values())->default(ProvisionStatus::Active->value);
            $table->timestamps();

            $table->unique('subscription_id');
            $table->index(['server_id', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('subscription_provisions');
    }
};
