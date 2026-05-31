<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('platform_server', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('platform_id')->constrained()->cascadeOnDelete();
            $table->foreignId('server_id')->constrained()->cascadeOnDelete();
            $table->timestamps();

            $table->unique(['platform_id', 'server_id']);
        });

        DB::table('servers')
            ->whereNotNull('platform_id')
            ->orderBy('id')
            ->chunkById(100, function ($servers): void {
                $rows = [];

                foreach ($servers as $server) {
                    $rows[] = [
                        'platform_id' => $server->platform_id,
                        'server_id' => $server->id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                }

                if ($rows !== []) {
                    DB::table('platform_server')->insertOrIgnore($rows);
                }
            });

        Schema::table('servers', function (Blueprint $table): void {
            $table->dropConstrainedForeignId('platform_id');
        });
    }

    public function down(): void
    {
        Schema::table('servers', function (Blueprint $table): void {
            $table->foreignId('platform_id')
                ->nullable()
                ->after('id')
                ->constrained()
                ->nullOnDelete();
        });

        $serverPlatformMap = DB::table('platform_server')
            ->select('server_id', DB::raw('MIN(platform_id) as platform_id'))
            ->groupBy('server_id')
            ->get();

        foreach ($serverPlatformMap as $row) {
            DB::table('servers')
                ->where('id', $row->server_id)
                ->update(['platform_id' => $row->platform_id]);
        }

        Schema::dropIfExists('platform_server');
    }
};
