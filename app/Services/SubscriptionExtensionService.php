<?php

namespace App\Services;

use App\Enums\SubscriptionStatus;
use App\Models\Service;
use App\Models\Subscription;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class SubscriptionExtensionService
{
    public function extend(Subscription $subscription, array $data, User $user): Subscription
    {
        if ($subscription->status !== SubscriptionStatus::Active) {
            throw new RuntimeException('Only active subscriptions can be extended.');
        }

        $service = Service::query()
            ->where('is_active', true)
            ->findOrFail($data['service_id']);

        if (
            $service->platform_id !== $subscription->service->platform_id ||
            $service->region !== $subscription->service->region
        ) {
            throw new RuntimeException('Selected service must match the subscription platform and region.');
        }

        $startDate = Carbon::parse($subscription->end_date)->addDay()->startOfDay();
        $endDate = $startDate->copy()->addDays($service->duration_days);
        $originalPrice = (float) $service->price;
        $discount = (float) ($data['discount'] ?? 0);
        $finalPrice = max($originalPrice - $discount, 0);

        return DB::transaction(function () use ($subscription, $service, $user, $startDate, $endDate, $originalPrice, $discount, $finalPrice, $data): Subscription {
            $subscription->update([
                'end_date' => $endDate->toDateString(),
            ]);

            $subscription->payments()->create([
                'user_id' => $user->id,
                'service_id' => $service->id,
                'type' => 'extend',
                'start_date' => $startDate->toDateString(),
                'end_date' => $endDate->toDateString(),
                'original_price' => $originalPrice,
                'discount' => $discount,
                'final_price' => $finalPrice,
                'remark' => $data['remark'] ?? null,
            ]);

            return $subscription->fresh(['customer', 'service.platform', 'payments.service', 'payments.user', 'provisions.server']);
        });
    }
}
