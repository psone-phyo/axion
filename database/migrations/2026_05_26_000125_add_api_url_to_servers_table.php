<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('servers', function (Blueprint $table): void {
            $table->string('api_url')->nullable()->after('ip');
        });
    }

    public function down(): void
    {
        Schema::table('servers', function (Blueprint $table): void {
            $table->dropColumn('api_url');
        });
    }
};
