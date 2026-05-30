<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('subscription_payments', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('subscription_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->foreignId('service_id')->constrained()->cascadeOnDelete();
            $table->foreignId('clear_id')->nullable()->constrained('subscription_clears')->nullOnDelete();
            $table->string('type')->default('create');
            $table->date('start_date');
            $table->date('end_date');
            $table->decimal('original_price', 10, 2)->default(0);
            $table->decimal('discount', 10, 2)->default(0);
            $table->decimal('final_price', 10, 2)->default(0);
            $table->text('remark')->nullable();
            $table->timestamps();

            $table->index(['user_id', 'clear_id', 'created_at']);
            $table->index(['subscription_id', 'type']);
        });

        DB::table('subscriptions')
            ->orderBy('id')
            ->chunkById(100, function ($subscriptions): void {
                $rows = [];

                foreach ($subscriptions as $subscription) {
                    $rows[] = [
                        'subscription_id' => $subscription->id,
                        'user_id' => $subscription->created_by,
                        'service_id' => $subscription->service_id,
                        'clear_id' => $subscription->clear_id,
                        'type' => 'create',
                        'start_date' => $subscription->start_date,
                        'end_date' => $subscription->end_date,
                        'original_price' => $subscription->original_price ?? 0,
                        'discount' => $subscription->discount ?? 0,
                        'final_price' => $subscription->final_price ?? 0,
                        'remark' => $subscription->remark,
                        'created_at' => $subscription->created_at,
                        'updated_at' => $subscription->updated_at,
                    ];
                }

                if ($rows !== []) {
                    DB::table('subscription_payments')->insert($rows);
                }
            });
    }

    public function down(): void
    {
        Schema::dropIfExists('subscription_payments');
    }
};
