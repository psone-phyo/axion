<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('subscription_provisions', function (Blueprint $table): void {
            $table->string('outline_access_key_id')->nullable()->after('server_id');
            $table->string('outline_method')->nullable()->after('key_name');
            $table->unsignedInteger('outline_port')->nullable()->after('outline_method');
            $table->unsignedBigInteger('data_limit_bytes')->nullable()->after('outline_port');
            $table->unsignedBigInteger('transferred_bytes')->default(0)->after('data_limit_bytes');
            $table->timestamp('last_synced_at')->nullable()->after('transferred_bytes');
            $table->text('last_error')->nullable()->after('last_synced_at');

            $table->index('outline_access_key_id');
        });
    }

    public function down(): void
    {
        Schema::table('subscription_provisions', function (Blueprint $table): void {
            $table->dropIndex(['outline_access_key_id']);
            $table->dropColumn([
                'outline_access_key_id',
                'outline_method',
                'outline_port',
                'data_limit_bytes',
                'transferred_bytes',
                'last_synced_at',
                'last_error',
            ]);
        });
    }
};
