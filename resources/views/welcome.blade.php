<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta
            name="description"
            content="Axion provides fast and simple VPN subscriptions for Outline, V2Box, and Hiddify users."
        >

        <title>Axion | VPN Subscription Service</title>
        <link rel="icon" type="image/jpeg" href="{{ asset('logo/axion_main_logo.jpg') }}">
        <link rel="apple-touch-icon" href="{{ asset('logo/axion_main_logo.jpg') }}">

        @vite(['resources/css/app.css', 'resources/js/app.js'])
    </head>
    <body class="bg-axion-night text-white">
        @php
            $services = [
                [
                    'eyebrow' => 'Outline',
                    'title' => 'Outline VPN Access',
                    'description' => 'Simple access for users who want a clean setup, stable routing, and quick onboarding.',
                    'features' => [
                        'Fast activation after payment confirmation',
                        'Easy configuration for daily secure browsing',
                        'Good fit for students, work, and streaming',
                    ],
                ],
                [
                    'eyebrow' => 'V2Box',
                    'title' => 'V2Box Premium Nodes',
                    'description' => 'Built for users who want stronger flexibility, modern protocols, and smoother performance.',
                    'features' => [
                        'Optimized profiles for stable connection quality',
                        'Suitable for advanced VPN users and power users',
                        'Consistent speeds with curated server options',
                    ],
                ],
                [
                    'eyebrow' => 'Hiddify',
                    'title' => 'Hiddify Subscription',
                    'description' => 'A polished option for mobile and desktop users who prefer a modern client experience.',
                    'features' => [
                        'Clean import flow for faster setup',
                        'Balanced performance for everyday privacy use',
                        'Helpful for users switching between multiple devices',
                    ],
                ],
            ];

            $plans = [
                [
                    'name' => 'Outline Starter',
                    'duration' => '1 Month',
                    'price' => '5,000',
                    'description' => 'A simple monthly plan for users who want reliable access with a low entry price.',
                    'features' => [
                        'Best for individual everyday use',
                        'Quick delivery after confirmation',
                        'Easy renewal cycle',
                    ],
                    'featured' => false,
                ],
                [
                    'name' => 'V2Box Plus',
                    'duration' => '1 Month',
                    'price' => '8,000',
                    'description' => 'A more flexible plan for users who want stronger protocol support and smoother routing.',
                    'features' => [
                        'Stable performance for regular heavy use',
                        'Great choice for multi-device customers',
                        'Priority-ready plan structure',
                    ],
                    'featured' => true,
                ],
                [
                    'name' => 'Hiddify Access',
                    'duration' => '1 Month',
                    'price' => '7,000',
                    'description' => 'A clean monthly subscription focused on comfort, compatibility, and modern client support.',
                    'features' => [
                        'Comfortable setup for mobile and desktop',
                        'Reliable option for personal privacy use',
                        'Smooth subscription management',
                    ],
                    'featured' => false,
                ],
            ];

            $contacts = [
                ['platform' => 'Telegram', 'handle' => '@axionvpn', 'href' => '#'],
                ['platform' => 'Facebook', 'handle' => 'Axion VPN', 'href' => '#'],
                ['platform' => 'Messenger', 'handle' => 'm.me/axionvpn', 'href' => '#'],
                ['platform' => 'TikTok', 'handle' => '@axionvpn', 'href' => '#'],
            ];
        @endphp

        <div class="axion-shell relative min-h-screen overflow-hidden">
            <div class="axion-grid absolute inset-0 opacity-40"></div>
            <div class="absolute inset-x-0 top-0 h-[34rem] bg-[radial-gradient(circle_at_top,rgba(115,235,255,0.22),transparent_52%)]"></div>
            <div class="absolute left-1/2 top-32 h-72 w-72 -translate-x-1/2 rounded-full bg-axion-cyan/12 blur-3xl"></div>

            <div class="relative mx-auto flex min-h-screen w-full max-w-7xl flex-col px-6 lg:px-10">
                <header class="flex items-center justify-between border-b border-white/10 py-6">
                    <a href="#top" class="flex items-center gap-4">
                        <span class="flex h-12 w-12 items-center justify-center rounded-2xl border border-white/15 bg-white/6 shadow-[0_0_40px_rgba(115,235,255,0.12)]">
                            <span class="font-brand text-2xl uppercase tracking-[0.18em] text-axion-cyan">A</span>
                        </span>
                        <span>
                            <span class="axion-title block text-2xl sm:text-3xl">Axion</span>
                            <span class="block text-xs uppercase tracking-[0.32em] text-slate-400">VPN Subscription Service</span>
                        </span>
                    </a>

                    <nav class="hidden items-center gap-8 text-sm text-slate-300 md:flex">
                        <a href="#services" class="transition hover:text-white">Services</a>
                        <a href="#pricing" class="transition hover:text-white">Pricing</a>
                        <a href="#contact" class="transition hover:text-white">Contact</a>
                    </nav>
                </header>

                <main id="top" class="flex-1">
                    <section class="grid gap-14 py-16 lg:grid-cols-[1.15fr_0.85fr] lg:items-center lg:py-24">
                        <div>
                            <span class="axion-pill">Secure. Simple. Subscription Ready.</span>
                            <h1 class="mt-8 max-w-4xl text-5xl font-semibold leading-tight text-white sm:text-6xl lg:text-7xl">
                                VPN subscriptions for
                                <span class="text-transparent bg-linear-to-r from-axion-cyan via-axion-mist to-axion-sky bg-clip-text">Outline, V2Box, and Hiddify</span>
                            </h1>
                            <p class="mt-6 max-w-2xl text-lg leading-8 text-slate-300">
                                Axion is a simple landing page for customers who want fast VPN subscription access, clear pricing,
                                and direct contact channels for support and ordering.
                            </p>

                            <div class="mt-10 flex flex-col gap-4 sm:flex-row">
                                <a
                                    href="#pricing"
                                    class="inline-flex items-center justify-center rounded-full bg-axion-cyan px-7 py-3.5 text-sm font-semibold text-axion-night transition hover:bg-axion-mist"
                                >
                                    View Plans
                                </a>
                                <a
                                    href="#contact"
                                    class="inline-flex items-center justify-center rounded-full border border-white/15 bg-white/6 px-7 py-3.5 text-sm font-semibold text-white transition hover:border-axion-cyan/40 hover:bg-white/10"
                                >
                                    Contact Us
                                </a>
                            </div>

                            <div class="mt-12 grid gap-4 sm:grid-cols-3">
                                <div class="axion-card p-5">
                                    <p class="text-xs uppercase tracking-[0.3em] text-slate-400">Delivery</p>
                                    <p class="mt-3 text-2xl font-semibold text-white">Fast Setup</p>
                                </div>
                                <div class="axion-card p-5">
                                    <p class="text-xs uppercase tracking-[0.3em] text-slate-400">Platforms</p>
                                    <p class="mt-3 text-2xl font-semibold text-white">3 Services</p>
                                </div>
                                <div class="axion-card p-5">
                                    <p class="text-xs uppercase tracking-[0.3em] text-slate-400">Support</p>
                                    <p class="mt-3 text-2xl font-semibold text-white">Social Contact</p>
                                </div>
                            </div>
                        </div>

                        <div class="relative">
                            <div class="axion-card relative overflow-hidden p-8 sm:p-10">
                                <div class="absolute inset-x-0 top-0 h-px bg-linear-to-r from-transparent via-axion-cyan/60 to-transparent"></div>
                                <div class="absolute -right-16 top-10 h-44 w-44 rounded-full bg-axion-cyan/18 blur-3xl"></div>
                                <div class="absolute -left-10 bottom-0 h-32 w-32 rounded-full bg-axion-sky/18 blur-3xl"></div>

                                <div class="relative">
                                    <p class="text-sm uppercase tracking-[0.34em] text-axion-cyan/80">Axion Network</p>
                                    <h2 class="axion-title mt-6 text-5xl sm:text-6xl">AXION</h2>
                                    <p class="mt-4 max-w-md text-sm leading-7 text-slate-300">
                                        A dark, modern subscription page inspired by the logo colors with a cleaner presentation for selling VPN access.
                                    </p>

                                    <div class="mt-10 space-y-4">
                                        <div class="rounded-2xl border border-white/10 bg-white/6 p-4">
                                            <div class="flex items-center justify-between gap-3">
                                                <span class="text-sm font-medium text-white">Outline</span>
                                                <span class="rounded-full bg-emerald-400/14 px-3 py-1 text-xs font-semibold text-emerald-200">Available</span>
                                            </div>
                                        </div>
                                        <div class="rounded-2xl border border-white/10 bg-white/6 p-4">
                                            <div class="flex items-center justify-between gap-3">
                                                <span class="text-sm font-medium text-white">V2Box</span>
                                                <span class="rounded-full bg-axion-cyan/12 px-3 py-1 text-xs font-semibold text-axion-mist">Premium</span>
                                            </div>
                                        </div>
                                        <div class="rounded-2xl border border-white/10 bg-white/6 p-4">
                                            <div class="flex items-center justify-between gap-3">
                                                <span class="text-sm font-medium text-white">Hiddify</span>
                                                <span class="rounded-full bg-white/10 px-3 py-1 text-xs font-semibold text-slate-200">Modern Client</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-10 h-px bg-linear-to-r from-transparent via-axion-cyan/50 to-transparent"></div>
                                    <p class="mt-8 text-xs uppercase tracking-[0.36em] text-slate-400">Subscription landing page v1</p>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section id="services" class="py-12 sm:py-16">
                        <div class="max-w-3xl">
                            <span class="axion-pill">Our Services</span>
                            <h2 class="mt-6 text-4xl font-semibold text-white sm:text-5xl">Choose the VPN platform that fits your style.</h2>
                            <p class="mt-5 text-lg leading-8 text-slate-300">
                                Each service is presented clearly so customers can quickly understand what they are buying before they message you.
                            </p>
                        </div>

                        <div class="mt-10 grid gap-6 lg:grid-cols-3">
                            @foreach ($services as $service)
                                <x-landing.service-card
                                    :eyebrow="$service['eyebrow']"
                                    :title="$service['title']"
                                    :description="$service['description']"
                                    :features="$service['features']"
                                />
                            @endforeach
                        </div>
                    </section>

                    <section id="pricing" class="py-12 sm:py-16">
                        <div class="flex flex-col gap-6 lg:flex-row lg:items-end lg:justify-between">
                            <div class="max-w-3xl">
                                <span class="axion-pill">Pricing</span>
                                <h2 class="mt-6 text-4xl font-semibold text-white sm:text-5xl">Simple monthly pricing for your subscription offers.</h2>
                            </div>
                            <p class="max-w-xl text-base leading-7 text-slate-300">
                                You can edit these prices later. I set them up as clean cards so your customers can compare quickly at a glance.
                            </p>
                        </div>

                        <div class="mt-10 grid gap-6 lg:grid-cols-3">
                            @foreach ($plans as $plan)
                                <x-landing.pricing-card
                                    :name="$plan['name']"
                                    :duration="$plan['duration']"
                                    :price="$plan['price']"
                                    :description="$plan['description']"
                                    :features="$plan['features']"
                                    :featured="$plan['featured']"
                                />
                            @endforeach
                        </div>
                    </section>

                    <section id="contact" class="py-12 sm:py-16">
                        <div class="grid gap-10 lg:grid-cols-[0.9fr_1.1fr] lg:items-start">
                            <div>
                                <span class="axion-pill">Contact</span>
                                <h2 class="mt-6 text-4xl font-semibold text-white sm:text-5xl">Let customers reach you from the channels they already use.</h2>
                                <p class="mt-5 text-lg leading-8 text-slate-300">
                                    These links are placeholders for now. You can replace each URL later with your real Telegram, Facebook, Messenger, and TikTok pages.
                                </p>
                            </div>

                            <div class="grid gap-5 sm:grid-cols-2">
                                @foreach ($contacts as $contact)
                                    <x-landing.contact-link
                                        :platform="$contact['platform']"
                                        :handle="$contact['handle']"
                                        :href="$contact['href']"
                                    />
                                @endforeach
                            </div>
                        </div>
                    </section>
                </main>

                <footer class="mt-8 border-t border-white/10 py-8 text-sm text-slate-400">
                    <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                        <p>&copy; {{ now()->year }} Axion. Static subscription landing page for VPN services.</p>
                        <div class="flex flex-wrap gap-5">
                            <a href="#services" class="transition hover:text-white">Services</a>
                            <a href="#pricing" class="transition hover:text-white">Pricing</a>
                            <a href="#contact" class="transition hover:text-white">Contact</a>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    </body>
</html>
