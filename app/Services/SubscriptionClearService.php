<?php

namespace App\Services;

use App\Models\Subscription;
use App\Models\SubscriptionClear;
use App\Models\SubscriptionPayment;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use RuntimeException;

class SubscriptionClearService
{
    public function eligiblePaymentsQuery(int|string|null $userId, Carbon|string|null $clearDate): Builder
    {
        if (blank($userId) || blank($clearDate)) {
            return SubscriptionPayment::query()->whereRaw('1 = 0');
        }

        $normalizedClearDate = $clearDate instanceof Carbon
            ? $clearDate
            : Carbon::parse($clearDate);

        return SubscriptionPayment::query()
            ->where('user_id', $userId)
            ->whereNull('clear_id')
            ->where('created_at', '<=', $normalizedClearDate);
    }

    /**
     * @return array{count:int,total:float}
     */
    public function summarize(int|string|null $userId, Carbon|string|null $clearDate): array
    {
        $query = $this->eligiblePaymentsQuery($userId, $clearDate);

        return [
            'count' => (clone $query)->count(),
            'total' => (float) (clone $query)->sum('final_price'),
        ];
    }

    public function createClear(array $data, User $actor): SubscriptionClear
    {
        $selectedUserId = (int) $data['user_id'];
        $clearDate = Carbon::parse($data['clear_date']);
        $summary = $this->summarize($selectedUserId, $clearDate);

        if ($summary['count'] === 0) {
            throw new RuntimeException('No uncleared payment records were found for the selected admin and clear date.');
        }

        return DB::transaction(function () use ($selectedUserId, $clearDate, $summary, $actor): SubscriptionClear {
            $subscriptionClear = SubscriptionClear::query()->create([
                'user_id' => $selectedUserId,
                'clear_date' => $clearDate,
                'total' => $summary['total'],
            ]);

            $updatedCount = $this->eligiblePaymentsQuery($selectedUserId, $clearDate)->update([
                'clear_id' => $subscriptionClear->id,
            ]);

            Log::info('Subscription clear batch created.', [
                'subscription_clear_id' => $subscriptionClear->id,
                'selected_user_id' => $selectedUserId,
                'created_by_user_id' => $actor->id,
                'clear_date' => $clearDate->toDateTimeString(),
                'payments_count' => $updatedCount,
                'total' => $summary['total'],
            ]);

            return $subscriptionClear->load(['user'])->loadCount('payments');
        });
    }
}
