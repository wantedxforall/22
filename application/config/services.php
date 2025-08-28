<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'mailgun' => [
        'domain' => env('MAILGUN_DOMAIN'),
        'secret' => env('MAILGUN_SECRET'),
        'endpoint' => env('MAILGUN_ENDPOINT', 'api.mailgun.net'),
        'scheme' => 'https',
    ],

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

'libyana' => [
    'store_id' => (int) env('LIBYANA_STORE_ID', 11),
    'info_url' => env('LIBYANA_INFO_URL', 'https://inanastore.com/api/stores/payment_info'),
    'api_url'  => env('LIBYANA_API_URL',  'https://inanastore.com/api/stores/payment_link_check'),
],

    'almadar' => [
        'store_id' => (int) env('ALMADAR_STORE_ID', 11),
        'api_url'  => env('ALMADAR_API_URL', 'https://inanastore.com/api/stores/payment_link_check'),
        'info_url' => env('ALMADAR_INFO_URL', 'https://inanastore.com/api/stores/payment_info'),
        // اختياري: fallback من .env إن حبيت
        'dest_phone' => env('ALMADAR_DEST_PHONE', null),
    ],


    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'libyana' => [
        'api_url'  => env('LIBYANA_API_URL', 'https://inanastore.com/api/stores/payment_link_check'),
        'store_id' => env('LIBYANA_STORE_ID', '11'),
        'info_url' => env('LIBYANA_INFO_URL', 'https://inanastore.com/api/stores/payment_info'),
    ],

    'payment_webhook' => [
        'secret' => env('PAYMENT_WEBHOOK_SECRET'),
    ],


];
