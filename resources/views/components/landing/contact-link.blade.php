@props([
    'platform',
    'handle',
    'href' => '#',
])

<a
    href="{{ $href }}"
    class="axion-card flex items-center gap-4 p-5 transition duration-300 hover:-translate-y-1 hover:border-axion-cyan/35 hover:bg-white/10"
>
    <span class="flex h-12 w-12 items-center justify-center rounded-2xl border border-axion-cyan/20 bg-axion-cyan/10 text-axion-cyan">
        @switch($platform)
            @case('Telegram')
                <svg class="h-5 w-5" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
                    <path d="M21.5 4.5 18.4 19c-.2 1-.8 1.3-1.7.8l-4.7-3.4-2.3 2.2c-.3.3-.5.5-1 .5l.3-4.8 8.8-7.9c.4-.3-.1-.5-.6-.2L6.3 12 1.7 10.5c-1-.3-1-1 .2-1.5L20 2.1c.9-.3 1.7.2 1.5 2.4Z"/>
                </svg>
                @break
            @case('Facebook')
                <svg class="h-5 w-5" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
                    <path d="M13.5 21v-8h2.7l.4-3h-3.1V8.1c0-.9.3-1.5 1.6-1.5h1.7V4c-.3 0-1.4-.1-2.6-.1-2.5 0-4.2 1.5-4.2 4.4V10H7v3h3v8h3.5Z"/>
                </svg>
                @break
            @case('Messenger')
                <svg class="h-5 w-5" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
                    <path d="M12 2C6.5 2 2 6.1 2 11.2c0 2.9 1.5 5.5 3.9 7.2V22l3.4-1.9c.9.2 1.8.3 2.7.3 5.5 0 10-4.1 10-9.2S17.5 2 12 2Zm1 12.4-2.5-2.6-5 2.6 5.5-5.8 2.6 2.6 4.8-2.6-5.4 5.8Z"/>
                </svg>
                @break
            @case('TikTok')
                <svg class="h-5 w-5" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">
                    <path d="M14.8 3c.2 1.7 1.2 3.4 2.8 4.4 1 .6 2.2 1 3.4 1v3.2c-1.5 0-3-.4-4.2-1.1v5.5c0 3.3-2.7 6-6.1 6A6.1 6.1 0 0 1 4.6 16c0-3.3 2.7-6 6.1-6 .4 0 .7 0 1.1.1v3.3a3.2 3.2 0 0 0-1.1-.2c-1.6 0-2.8 1.2-2.8 2.8s1.2 2.8 2.8 2.8 2.9-1.2 2.9-2.8V3h3.2Z"/>
                </svg>
                @break
            @default
                <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true">
                    <path d="M4 12h16M12 4v16"/>
                </svg>
        @endswitch
    </span>

    <span class="min-w-0">
        <span class="block text-sm font-semibold uppercase tracking-[0.24em] text-axion-cyan/80">{{ $platform }}</span>
        <span class="mt-1 block truncate text-base text-white">{{ $handle }}</span>
    </span>
</a>
