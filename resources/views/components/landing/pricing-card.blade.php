@props([
    'name',
    'price',
    'duration',
    'description',
    'features' => [],
    'featured' => false,
])

<article
    {{ $attributes->class([
        'axion-card relative h-full p-6 sm:p-7',
        'border-axion-cyan/40 bg-linear-to-b from-axion-cyan/12 via-white/8 to-transparent shadow-[0_22px_80px_rgba(66,191,247,0.22)]' => $featured,
    ]) }}
>
    @if ($featured)
        <span class="absolute right-5 top-5 rounded-full bg-axion-cyan px-3 py-1 text-[11px] font-bold uppercase tracking-[0.28em] text-axion-night">
            Popular
        </span>
    @endif

    <p class="text-sm font-semibold uppercase tracking-[0.3em] text-axion-cyan/80">{{ $duration }}</p>
    <h3 class="mt-4 text-2xl font-semibold text-white">{{ $name }}</h3>
    <div class="mt-5 flex items-end gap-2">
        <span class="text-4xl font-semibold text-white">{{ $price }}</span>
        <span class="pb-1 text-sm text-slate-300">MMK</span>
    </div>
    <p class="mt-3 text-sm leading-7 text-slate-300">{{ $description }}</p>

    <ul class="mt-6 space-y-3 text-sm text-slate-200">
        @foreach ($features as $feature)
            <li class="flex items-start gap-3">
                <span class="mt-1 h-2.5 w-2.5 rounded-full bg-axion-sky shadow-[0_0_18px_rgba(66,191,247,0.75)]"></span>
                <span>{{ $feature }}</span>
            </li>
        @endforeach
    </ul>
</article>
