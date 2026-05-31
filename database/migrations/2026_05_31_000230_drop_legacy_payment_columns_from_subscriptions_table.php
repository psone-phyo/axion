<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('subscriptions', function (Blueprint $table): void {
            $table->dropConstrainedForeignId('clear_id');
            $table->dropColumn([
                'original_price',
                'discount',
                'final_price',
            ]);
        });
    }

    public function down(): void
    {
        Schema::table('subscriptions', function (Blueprint $table): void {
            $table->decimal('original_price', 12, 2)->default(0)->after('service_id');
            $table->decimal('discount', 12, 2)->default(0)->after('original_price');
            $table->decimal('final_price', 12, 2)->default(0)->after('discount');
            $table->foreignId('clear_id')
                ->nullable()
                ->after('created_by')
                ->constrained('subscription_clears')
                ->nullOnDelete();
        });
    }
};
