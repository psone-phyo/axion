@props([
    'eyebrow',
    'title',
    'description',
    'features' => [],
])

<article {{ $attributes->class('axion-card h-full p-6 sm:p-7') }}>
    <p class="text-xs font-semibold uppercase tracking-[0.3em] text-axion-cyan/80">{{ $eyebrow }}</p>
    <h3 class="mt-4 text-2xl font-semibold text-white">{{ $title }}</h3>
    <p class="mt-3 text-sm leading-7 text-slate-300">{{ $description }}</p>

    <ul class="mt-6 space-y-3 text-sm text-slate-200">
        @foreach ($features as $feature)
            <li class="flex items-start gap-3">
                <span class="mt-1 h-2.5 w-2.5 rounded-full bg-axion-cyan shadow-[0_0_16px_rgba(115,235,255,0.75)]"></span>
                <span>{{ $feature }}</span>
            </li>
        @endforeach
    </ul>
</article>
