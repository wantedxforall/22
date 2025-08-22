<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\LevelController;
use App\Http\Controllers\Admin\RewardItemController;
use App\Http\Controllers\Admin\RewardOrderController;
use App\Http\Controllers\Admin\RewardCategoryController;
use App\Http\Controllers\Admin\BenefitOverrideController;

Route::namespace('Auth')->group(function () {
    Route::controller('LoginController')->group(function () {
        Route::get('/', 'showLoginForm')->name('login');
        Route::post('/', 'login')->name('login');
        Route::get('logout', 'logout')->name('logout');
    });

    // Admin Password Reset
    Route::controller('ForgotPasswordController')->group(function(){
        Route::get('password/reset', 'showLinkRequestForm')->name('password.reset');
        Route::post('password/reset', 'sendResetCodeEmail');
        Route::get('password/code-verify', 'codeVerify')->name('password.code.verify');
        Route::post('password/verify-code', 'verifyCode')->name('password.verify.code');
    });

    Route::controller('ResetPasswordController')->group(function(){
        Route::get('password/reset/{token}', 'showResetForm')->name('password.reset.form');
        Route::post('password/reset/change', 'reset')->name('password.change');
    });
});

Route::middleware('admin')->group(function () {

    Route::name('admin.')->group(function () {
        Route::resource('benefit-overrides', BenefitOverrideController::class)->except(['show']);
    });
    
    Route::resource('benefit-overrides', BenefitOverrideController::class)->except(['show']);

    Route::controller('AuthorizationController')->group(function(){
        Route::get('authorization', 'authorizeForm')->name('authorization');
        Route::post('go2fa/verify', 'g2faVerification')->name('go2fa.verify');
    });

    Route::middleware('admin.status')->group(function () {

        // ===== Utilities
        Route::get('/clear', function(){
            \Illuminate\Support\Facades\Artisan::call('optimize:clear');
            return redirect()->back();
        })->name('clear.cache');

        // ===== Core Admin
        Route::controller('AdminController')->group(function(){
            Route::get('dashboard', 'dashboard')->name('dashboard');
            Route::get('profile', 'profile')->name('profile');
            Route::post('profile', 'profileUpdate')->name('profile.update');
            Route::post('password', 'passwordUpdate')->name('password.update');

            // Notification
            Route::get('notifications','notifications')->name('notifications');
            Route::get('notification/read/{id}','notificationRead')->name('notification.read');
            Route::get('notifications/read-all','readAll')->name('notifications.readAll');

            // Report Bugs
            Route::get('request/report','requestReport')->name('request.report');
            Route::post('request/report','reportSubmit');

            Route::get('download/attachments/{file_hash}', 'downloadAttachment')->name('download.attachment');
        });

        // ===== Users Manager
        Route::controller('ManageUsersController')->name('users.')->prefix('manage/users')->group(function(){
            Route::get('/', 'allUsers')->name('all');
            Route::get('active', 'activeUsers')->name('active');
            Route::get('banned', 'bannedUsers')->name('banned');
            Route::get('email/verified', 'emailVerifiedUsers')->name('email.verified');
            Route::get('email/unverified', 'emailUnverifiedUsers')->name('email.unverified');
            Route::get('mobile/unverified', 'mobileUnverifiedUsers')->name('mobile.unverified');
            Route::get('mobile/verified', 'mobileVerifiedUsers')->name('mobile.verified');
            Route::get('with/balance', 'usersWithBalance')->name('with.balance');

            Route::get('detail/{id}', 'detail')->name('detail');
            Route::post('update/{id}', 'update')->name('update');
            Route::post('add/sub/balance/{id}', 'addSubBalance')->name('add.sub.balance');
            Route::get('send/notification/{id}', 'showNotificationSingleForm')->name('notification.single');
            Route::post('send/notification/{id}', 'sendNotificationSingle')->name('notification.single');
            Route::get('login/{id}', 'login')->name('login');
            Route::post('status/{id}', 'status')->name('status');

            Route::get('send/notification', 'showNotificationAllForm')->name('notification.all');
            Route::post('send/notification', 'sendNotificationAll')->name('notification.all.send');
            Route::get('notification/log/{id}', 'notificationLog')->name('notification.log');
        });

        // ===== Two-Factor
        Route::controller('TwoFactorController')->group(function(){
            Route::get('twofactor', 'show2faForm')->name('twofactor');
            Route::post('twofactor/enable', 'enable2fa')->name('twofactor.enable');
            Route::post('twofactor/disable', 'disable2fa')->name('twofactor.disable');
        });

        // ===== Reward Categories (Admin)
        Route::resource('reward-categories', RewardCategoryController::class)->except(['show']);

        // ===== Reward Items (Admin)
        Route::resource('reward-items', RewardItemController::class)->except(['show']);
        Route::post('reward-items/{reward_item}/toggle', [RewardItemController::class, 'toggle'])
            ->name('reward-items.toggle');

        // ===== Reward Orders (Admin)
        Route::controller(RewardOrderController::class)
            ->prefix('reward-orders')
            ->name('reward-orders.')
            ->group(function () {
                Route::get('/', 'index')->name('index');
                Route::put('{order}', 'update')->name('update');
            });

        // ===== Subscriber
        Route::controller('SubscriberController')->group(function(){
            Route::get('subscriber', 'index')->name('subscriber.index');
            Route::get('subscriber/send/email', 'sendEmailForm')->name('subscriber.send.email');
            Route::post('subscriber/remove/{id}', 'remove')->name('subscriber.remove');
            Route::post('subscriber/send/email', 'sendEmail')->name('subscriber.send.email');
        });

        // ===== Plan
        Route::controller('PlanController')->name('plan.')->prefix('plan')->group(function(){
            Route::get('/','index')->name('index');
            Route::get('create','create')->name('create');
            Route::post('store','store')->name('store');
            Route::get('edit/{id}','edit')->name('edit');
            Route::post('update/{id}','update')->name('update');
            Route::post('delete','delete')->name('delete');
        });

        // ===== Category
        Route::controller('CategoryController')->name('category.')->prefix('category')->group(function(){
            Route::get('/','index')->name('index');
            Route::get('create','create')->name('create');
            Route::post('store','store')->name('store');
            Route::get('edit/{id}','edit')->name('edit');
            Route::post('update','update')->name('update');
        });

        // ===== Levels
        Route::controller('LevelController')->name('levels.')->prefix('levels')->group(function(){
            Route::get('/','index')->name('index');
            Route::get('create','create')->name('create');
            Route::post('store','store')->name('store');
            Route::get('edit/{id}','edit')->name('edit');

            Route::match(['POST','PUT'],'update/{id}','update')->name('update');
            Route::post('delete','destroy')->name('destroy');                // body: id
            Route::delete('delete/{id}','destroy')->name('destroy.alt');     // URL: {id}
        });

        // ===== Level Benefits
        Route::controller('LevelBenefitController')->name('levels.benefits.')->prefix('levels/benefits')->group(function(){
            Route::post('store','store')->name('store');
            Route::match(['POST','PUT'],'update/{id}','update')->name('update');
            Route::post('delete','destroy')->name('destroy');
            Route::delete('delete/{id}','destroy')->name('destroy.alt');
        });

        // ===== Apify (actors)
        Route::controller('ApifyController')->name('apify.')->prefix('apify-actors')->group(function(){
            Route::get('/', 'index')->name('index');
            Route::post('store', 'store')->name('store');
            Route::post('update', 'update')->name('update');
            Route::post('delete', 'delete')->name('delete');
        });

        // ===== Admin Withdraw actions (quick)
        Route::controller('WithdrawController')->name('withdraw.')->prefix('withdraw')->group(function(){
            Route::post('approve/{id}', 'approve')->name('approve');
            Route::post('cancel/{id}', 'cancel')->name('cancel');
        });

        // ===== Refferal Commission
        Route::controller('RefferalController')->name('refferal.')->prefix('refferal')->group(function(){
            Route::get('/', 'index')->name('index');
            Route::post('store', 'store')->name('store');
        });

        // ===== Service
        Route::controller('ServiceController')->name('service.')->prefix('service')->group(function(){
            Route::get('/','index')->name('index');
            Route::get('create','create')->name('create');
            Route::post('store','store')->name('store');
            Route::get('edit/{id}','edit')->name('edit');
            Route::post('update/{id}','update')->name('update');

            Route::get('pending', 'pending')->name('pending');
            Route::get('ban', 'ban')->name('ban');
            Route::get('active', 'active')->name('active');
            Route::post('change-status', 'changeStatus')->name('change.status');

            Route::get('reports', 'report')->name('report');
            Route::post('report/ban', 'reportBan')->name('report.ban');
        });

        // ===== Ads
        Route::controller('AdController')->name('ad.')->prefix('ad')->group(function(){
            Route::get('type','fetchAdType')->name('type.index');
            Route::post('type/store','AdTypeStore')->name('type.store');
            Route::post('type/update','AdTypeUpdate')->name('type.update');
            Route::get('{id}','fetchAd')->name('index');
            Route::post('store','store')->name('store');
            Route::post('update','update')->name('update');
            Route::post('delete','delete')->name('delete');
        });

        // ===== Payment Gateways
        Route::name('gateway.')->prefix('payment/gateways')->group(function(){

            // Automatic
            Route::controller('AutomaticGatewayController')->group(function(){
                Route::get('automatic', 'index')->name('automatic.index');
                Route::get('automatic/edit/{alias}', 'edit')->name('automatic.edit');
                Route::post('automatic/update/{code}', 'update')->name('automatic.update');
                Route::post('automatic/remove/{id}', 'remove')->name('automatic.remove');
                Route::post('automatic/activate/{code}', 'activate')->name('automatic.activate');
                Route::post('automatic/deactivate/{code}', 'deactivate')->name('automatic.deactivate');
            });

            // Manual
            Route::controller('ManualGatewayController')->group(function(){
                Route::get('manual', 'index')->name('manual.index');
                Route::get('manual/new', 'create')->name('manual.create');
                Route::post('manual/new', 'store')->name('manual.store');
                Route::get('manual/edit/{alias}', 'edit')->name('manual.edit');
                Route::post('manual/update/{id}', 'update')->name('manual.update');
                Route::post('manual/activate/{code}', 'activate')->name('manual.activate');
                Route::post('manual/deactivate/{code}', 'deactivate')->name('manual.deactivate');
            });
        });

        // ===== Deposit System
        Route::name('deposit.')->controller('DepositController')->prefix('manage/deposits')->group(function(){
            Route::get('/', 'deposit')->name('list');
            Route::get('pending', 'pending')->name('pending');
            Route::get('rejected', 'rejected')->name('rejected');
            Route::get('approved', 'approved')->name('approved');
            Route::get('successful', 'successful')->name('successful');
            Route::get('initiated', 'initiated')->name('initiated');
            Route::get('details/{id}', 'details')->name('details');

            Route::post('reject', 'reject')->name('reject');
            Route::post('approve/{id}', 'approve')->name('approve');
        });

        // ===== Withdraw System (تقارير)
        Route::name('withdraw.')->prefix('withdraw')->controller('WithdrawController')->group(function(){
            Route::get('/', 'index')->name('index');
            Route::get('report/points', 'points')->name('report.points');
            Route::post('approve/{id}', 'approve')->name('approve');
            Route::post('reject/{id}', 'reject')->name('reject');
        });

        // ===== Reports
        Route::controller('ReportController')->group(function(){
            Route::get('report/transaction', 'transaction')->name('report.transaction');
            Route::get('report/login/history', 'loginHistory')->name('report.login.history');
            Route::get('report/login/ipHistory/{ip}', 'loginIpHistory')->name('report.login.ipHistory');
            Route::get('report/notification/history', 'notificationHistory')->name('report.notification.history');
            Route::get('report/email/detail/{id}', 'emailDetails')->name('report.email.details');
        });

        // ===== Admin Support
        Route::controller('SupportTicketController')->prefix('support')->group(function(){
            Route::get('tickets', 'tickets')->name('ticket');
            Route::get('tickets/pending', 'pendingTicket')->name('ticket.pending');
            Route::get('tickets/closed', 'closedTicket')->name('ticket.closed');
            Route::get('tickets/answered', 'answeredTicket')->name('ticket.answered');
            Route::get('tickets/view/{id}', 'ticketReply')->name('ticket.view');
            Route::post('ticket/reply/{id}', 'replyTicket')->name('ticket.reply');
            Route::post('ticket/close/{id}', 'closeTicket')->name('ticket.close');
            Route::get('ticket/download/{ticket}', 'ticketDownload')->name('ticket.download');
            Route::post('ticket/delete/{id}', 'ticketDelete')->name('ticket.delete');
        });

        // ===== Language Manager
        Route::controller('LanguageController')->prefix('manage')->group(function(){
            Route::get('languages', 'langManage')->name('language.manage');
            Route::post('language', 'langStore')->name('language.manage.store');
            Route::post('language/delete/{id}', 'langDelete')->name('language.manage.delete');
            Route::post('language/update/{id}', 'langUpdate')->name('language.manage.update');
            Route::get('language/edit/{id}', 'langEdit')->name('language.key');
            Route::post('language/import', 'langImport')->name('language.import.lang');
            Route::post('language/store/key/{id}', 'storeLanguageJson')->name('language.store.key');
            Route::post('language/delete/key/{id}', 'deleteLanguageJson')->name('language.delete.key');
            Route::post('language/update/key/{id}', 'updateLanguageJson')->name('language.update.key');
            Route::get('language/search/', 'langSearch')->name('language.manage.search');
            Route::get('language/search/replace/', 'langSearch')->name('language.manage.search.replace');
        });

        // ===== General Settings
        Route::controller('GeneralSettingController')->group(function(){
            Route::get('global/settings', 'index')->name('setting.index');
            Route::post('global/settings', 'update')->name('setting.update');

            Route::post('setting/system-configuration','systemConfigurationSubmit');

            Route::get('setting/logo', 'logoIcon')->name('setting.logo.icon');
            Route::post('setting/logo', 'logoIconUpdate')->name('setting.logo.icon');

            Route::get('cookie','cookie')->name('setting.cookie');
            Route::post('cookie','cookieSubmit');

            Route::get('custom-css', 'customCss')->name('setting.custom.css');
            Route::post('custom-css', 'customCssSubmit');
        });

        // ===== Apify (عام)
        Route::controller('ApifyController')->prefix('apify')->name('apify.')->group(function(){
            Route::get('/', 'index')->name('index');
            Route::post('token', 'updateToken')->name('token.update');
            Route::post('actor', 'storeActor')->name('actor.store');
            Route::post('actor/update/{id}', 'updateActor')->name('actor.update');
            Route::post('actor/delete', 'deleteActor')->name('actor.delete');
        });

        // ===== API Setting
        Route::controller('ApiSettingController')->group(function(){
            Route::get('api-setting', 'index')->name('api.setting');
            Route::post('api-setting/generate', 'generate')->name('api.generate');
        });

        // ===== Notification Setting
        Route::name('setting.notification.')->controller('NotificationController')->prefix('notifications')->group(function(){
            Route::get('global','global')->name('global');
            Route::post('global/update','globalUpdate')->name('global.update');
            Route::get('templates','templates')->name('templates');
            Route::get('template/edit/{id}','templateEdit')->name('template.edit');
            Route::post('template/update/{id}','templateUpdate')->name('template.update');

            // Email/SMS
            Route::get('email/setting','emailSetting')->name('email');
            Route::post('email/setting','emailSettingUpdate');
            Route::post('email/test','emailTest')->name('email.test');

            Route::get('sms/setting','smsSetting')->name('sms');
            Route::post('sms/setting','smsSettingUpdate');
            Route::post('sms/test','smsTest')->name('sms.test');
        });

        // ===== Plugins
        Route::controller('ExtensionController')->group(function(){
            Route::get('extensions', 'index')->name('extensions.index');
            Route::post('extensions/update/{id}', 'update')->name('extensions.update');
            Route::post('extensions/status/{id}', 'status')->name('extensions.status');
        });

        // ===== SEO
        Route::get('seo', 'FrontendController@seoEdit')->name('seo');

        // ===== Frontend
        Route::name('frontend.')->prefix('frontend')->group(function () {
            Route::controller('FrontendController')->group(function(){
                Route::get('templates', 'templates')->name('templates');
                Route::post('templates', 'templatesActive')->name('templates.active');
                Route::get('frontend-sections/{key}', 'frontendSections')->name('sections');
                Route::post('frontend-content/{key}', 'frontendContent')->name('sections.content');
                Route::get('frontend-element/{key}/{id?}', 'frontendElement')->name('sections.element');
                Route::post('remove/{id}', 'remove')->name('remove');
            });

            // Page Builder
            Route::controller('PageBuilderController')->prefix('manage')->group(function(){
                Route::get('pages', 'managePages')->name('manage.pages');
                Route::post('pages', 'managePagesSave')->name('manage.pages.save');
                Route::post('pages/update', 'managePagesUpdate')->name('manage.pages.update');
                Route::post('pages/delete/{id}', 'managePagesDelete')->name('manage.pages.delete');
                Route::get('section/{id}', 'manageSection')->name('manage.section');
                Route::post('section/{id}', 'manageSectionUpdate')->name('manage.section.update');
            });
        });

    }); // end admin.status
}); // end admin middleware
