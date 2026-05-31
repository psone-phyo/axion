<?php

return [
    'brand_name' => env('LANDING_BRAND_NAME', 'Axion'),
    'brand_tagline' => env('LANDING_BRAND_TAGLINE', 'VPN Subscription Service'),
    'meta_description' => env(
        'LANDING_META_DESCRIPTION',
        'Axion provides Outline, V2Box, and Hiddify VPN subscriptions with simple pricing and direct social contact support.'
    ),
    'hero_badge' => env('LANDING_HERO_BADGE', 'Fast Setup. Clear Pricing. Reliable Access.'),
    'hero_title' => env('LANDING_HERO_TITLE', 'VPN subscriptions for Outline, V2Box, and Hiddify'),
    'hero_description' => env(
        'LANDING_HERO_DESCRIPTION',
        'Axion sells easy-to-buy VPN subscriptions for customers who want stable access, simple setup, and direct support through social channels.'
    ),
    'hero_primary_label' => env('LANDING_HERO_PRIMARY_LABEL', 'View Pricing'),
    'hero_primary_href' => env('LANDING_HERO_PRIMARY_HREF', '#pricing'),
    'hero_secondary_label' => env('LANDING_HERO_SECONDARY_LABEL', 'Contact Us'),
    'hero_secondary_href' => env('LANDING_HERO_SECONDARY_HREF', '#contact'),
    'stats' => [
        [
            'label' => 'Popular Choice',
            'value' => env('LANDING_STAT_ONE_VALUE', 'Outline Access'),
        ],
        [
            'label' => 'Platforms',
            'value' => env('LANDING_STAT_TWO_VALUE', '3 Supported Apps'),
        ],
        [
            'label' => 'Support',
            'value' => env('LANDING_STAT_THREE_VALUE', 'Telegram & Social'),
        ],
    ],
    'network_eyebrow' => env('LANDING_NETWORK_EYEBROW', 'Axion Network'),
    'network_title' => env('LANDING_NETWORK_TITLE', 'AXION'),
    'network_description' => env(
        'LANDING_NETWORK_DESCRIPTION',
        'A clean subscription landing page for selling VPN access across the most common client apps your customers already use.'
    ),
    'network_footer' => env('LANDING_NETWORK_FOOTER', 'Outline-focused VPN subscription service'),
    'services_heading' => env('LANDING_SERVICES_HEADING', 'Choose the VPN platform that fits your device and usage style.'),
    'services_description' => env(
        'LANDING_SERVICES_DESCRIPTION',
        'Outline is the most popular option, while V2Box and Hiddify give customers more choice depending on the app experience they prefer.'
    ),
    'pricing_heading' => env('LANDING_PRICING_HEADING', 'Simple pricing for all supported platforms.'),
    'pricing_description' => env(
        'LANDING_PRICING_DESCRIPTION',
        'The same subscription pricing applies across Outline, V2Box, and Hiddify, so customers can pick the app they prefer without confusion.'
    ),
    'contact_heading' => env('LANDING_CONTACT_HEADING', 'Contact us from the platforms you already use.'),
    'contact_description' => env(
        'LANDING_CONTACT_DESCRIPTION',
        'Message us on Telegram, Facebook, Messenger, or TikTok to ask questions, place an order, or renew your subscription.'
    ),
    'footer_text' => env('LANDING_FOOTER_TEXT', 'VPN subscription service for Outline, V2Box, and Hiddify users.'),
    'contacts' => [
        [
            'platform' => 'Telegram',
            'handle' => env('LANDING_CONTACT_TELEGRAM_HANDLE', '@axionvpn'),
            'href' => env('LANDING_CONTACT_TELEGRAM_URL', '#'),
        ],
        [
            'platform' => 'Facebook',
            'handle' => env('LANDING_CONTACT_FACEBOOK_HANDLE', 'Axion VPN'),
            'href' => env('LANDING_CONTACT_FACEBOOK_URL', '#'),
        ],
        [
            'platform' => 'Messenger',
            'handle' => env('LANDING_CONTACT_MESSENGER_HANDLE', 'm.me/axionvpn'),
            'href' => env('LANDING_CONTACT_MESSENGER_URL', '#'),
        ],
        [
            'platform' => 'TikTok',
            'handle' => env('LANDING_CONTACT_TIKTOK_HANDLE', '@axionvpn'),
            'href' => env('LANDING_CONTACT_TIKTOK_URL', '#'),
        ],
    ],
];
