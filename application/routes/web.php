<?php

use App\Lib\Router;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\Api\AdminApiController;
use App\Http\Controllers\User\WithdrawController;
use App\Http\Controllers\Admin\WithdrawController as AdminWithdrawController;
use App\Http\Controllers\User\DashboardController;
use App\Http\Controllers\PaymentWebhookController;
use App\Http\Controllers\RewardsStoreController;
use App\Http\Controllers\User\RewardController;
use App\Http\Controllers\RewardItemController;
use Illuminate\Support\Facades\File;
use App\Http\Controllers\Payments\InlineDepositController;

Route::match(['GET','POST'], '/adminapi/v1', [AdminApiController::class, 'handleRequest']);
    
// User Support Ticket
Route::controller('TicketController')->prefix('ticket')->group(function () {
    Route::get('/', 'supportTicket')->name('ticket');
    Route::get('/new', 'openSupportTicket')->name('ticket.open');
    Route::post('/create', 'storeSupportTicket')->name('ticket.store');
    Route::get('/view/{ticket}', 'viewTicket')->name('ticket.view');
    Route::post('/reply/{ticket}', 'replyTicket')->name('ticket.reply');
    Route::post('/close/{ticket}', 'closeTicket')->name('ticket.close');
    Route::get('/download/{ticket}', 'ticketDownload')->name('ticket.download');
});

// web.php
Route::get('/reward_items/{filename}', function ($filename) {
    $path = storage_path('app/public/reward_items/' . $filename);

    if (!File::exists($path)) {
        abort(404);
    }

    $file = File::get($path);
    $type = File::mimeType($path);

    return response($file, 200)->header("Content-Type", $type);
});

Route::get('/reward_categories/{path}', function ($path) {
    $full = storage_path('app/public/reward_categories/' . $path);
    if (!File::exists($full)) abort(404);

    return response(File::get($full), 200)
        ->header('Content-Type', File::mimeType($full));
})->where('path', '.*');

Route::controller('Admin\AdController')->group(function () {
    Route::get('/ads/{ad}/{type}/{adType}', 'getAdvertise')->name('adsUrl');
    Route::get('/ad-clicked/{adid}', 'adClicked')->name('adClicked');
});

Route::get('app/deposit/confirm/{hash}', 'Gateway\PaymentController@appDepositConfirm')->name('deposit.app.confirm');
Route::post('/payment/confirm', [PaymentController::class, 'confirmTransfer'])->name('payment.confirm');
Route::match(['get', 'post'], '/payment/webhook/confirm', [PaymentWebhookController::class, 'confirm'])
    ->middleware('auth')
    ->name('payment.webhook.confirm');
Route::match(['GET','POST'], '/adminapi/v1', [AdminApiController::class, 'handleRequest']);

Route::middleware('auth')
    ->prefix('user')
    ->name('user.')
    ->group(function () {
	        // قائمة السحوبات للمستخدم
        Route::get('withdraw',           [WithdrawController::class, 'index'])->name('withdraw.index');

        // إنشاء طلب جديد (صفحة الخيارين أو حسب تصميمك)
        Route::get('withdraw/create',    [WithdrawController::class, 'create'])->name('withdraw.create');

        // صفحات كل طريقة بشكل مستقل
        Route::get('withdraw/phone',     [WithdrawController::class, 'phoneForm'])->name('withdraw.phone');
        Route::get('withdraw/usdt',      [WithdrawController::class, 'usdtForm'])->name('withdraw.usdt');

        // حفظ الطلب (POST واحد فقط)
        Route::post('withdraw',          [WithdrawController::class, 'store'])->name('withdraw.store');

        // إلغاء الطلب
        Route::post('withdraw/cancel',   [WithdrawController::class, 'cancel'])->name('withdraw.cancel');
		});

	Route::middleware('auth')->get('/user/levels', [\App\Http\Controllers\User\LevelViewController::class, 'index'])->name('user.levels');

Route::middleware('auth')->group(function () {

    Route::get('/payment/bootstrap/{provider}', [InlineDepositController::class, 'bootstrap'])
        ->whereIn('provider', ['libyana','almadar'])
        ->name('payments.bootstrap');

    Route::post('/payment/inline-confirm/{provider}', [InlineDepositController::class, 'confirm'])
        ->whereIn('provider', ['libyana','almadar'])
        ->name('payments.inline.confirm');

    Route::get('/payment/bootstrap/{provider}', [InlineDepositController::class, 'bootstrap']);
    Route::post('/payment/inline-confirm/{provider}', [InlineDepositController::class, 'confirm']);


    // صفحة الفئات
    Route::get('/rewards', [RewardsStoreController::class, 'categories'])->name('rewards.index');

    // عناصر فئة معيّنة
    Route::get('/rewards/c/{slug}', [RewardsStoreController::class, 'category'])->name('rewards.category');

    // تنفيذ الاسترداد
    Route::post('/rewards/{item}', [RewardsStoreController::class, 'store'])
        ->name('rewards.store')
        ->middleware('throttle:5,1');

    // طلباتي
    Route::get('/my-orders', [RewardsStoreController::class, 'ordersIndex'])->name('rewards.orders');
});

// Reward items
Route::resource('reward-items', RewardItemController::class)->only(['create', 'store']);
Route::post('reward-items/{rewardItem}/redeem', [RewardItemController::class, 'redeem'])
    ->middleware('auth')
    ->name('reward-items.redeem');
	

Route::controller('SiteController')->group(function () {
    Route::get('/contact', 'contact')->name('contact');
    Route::post('/contact', 'contactSubmit');
    Route::get('/change/{lang?}', 'changeLanguage')->name('lang');

    Route::get('cookie-policy', 'cookiePolicy')->name('cookie.policy');

    Route::get('/cookie/accept', 'cookieAccept')->name('cookie.accept');

    //blog
    Route::get('/blog','blog')->name('blog');
    Route::get('blog/{slug}/{id}', 'blogDetails')->name('blog.details');

    Route::get('policy/{slug}/{id}', 'policyPages')->name('policy.pages');

    Route::get('placeholder-image/{size}', 'placeholderImage')->name('placeholder.image');

    //subscriber
    Route::match(['get','post'],'/subscribe','subscribe')->name('subscribe');

    //plan
    Route::get('/plan','plan')->name('plan');


    Route::get('/{slug}', 'pages')->name('pages');
    Route::get('/', 'index')->name('home');
});


