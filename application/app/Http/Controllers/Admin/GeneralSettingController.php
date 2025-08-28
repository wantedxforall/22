<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Frontend;
use App\Models\GeneralSetting;
use App\Rules\FileTypeValidate;
use Illuminate\Http\Request;
use Image;
use Illuminate\Support\Facades\Log;

class GeneralSettingController extends Controller
{
    public function index()
    {
        $pageTitle = 'Global Settings';
        $timezones = json_decode(file_get_contents(resource_path('views/admin/components/timezone.json')));
        return view('admin.setting.general', compact('pageTitle','timezones'));
    }

    public function update(Request $request)
{
    $request->validate([
        'site_name'             => 'required|string|max:40',
        'cur_text'              => 'required|string|max:40',
        'cur_sym'               => 'required|string|max:40',
        'base_color'            => ['nullable','regex:/^[a-f0-9]{6}$/i'],
        'secondary_color'       => ['nullable','regex:/^[a-f0-9]{6}$/i'],
        'timezone'              => 'required',
        'deduct_credits'        => 'required|integer|min:0',
        'add_credits'           => 'required|integer|min:0',
        'given_credits'         => 'required|integer|min:0',
        'daily_login_credits'   => 'required|integer|min:0',
        'withdraw_notify_email' => 'nullable|email',
        'withdraw_rate_phone'   => 'required|numeric|min:0',
        'withdraw_rate_usdt'    => 'required|numeric|min:0',
        'withdraw_min_phone'    => ['required','numeric','min:0'],
        'withdraw_min_usdt'     => ['required','numeric','min:0'],

        // رقم المدار الذي سيُستخدم كرقم المستلم في بوابة Almadar
        'almadar_wallet'        => ['required','numeric','min:0'], // عدّل الريجيكس حسب صيغة أرقام المدار لديك
    ]);

    // احصل على السجل العام
    $general = gs(); // أو GeneralSetting::first();

    // قيم نصّية وأعلام
    $general->site_name         = $request->site_name;
    $general->cur_text          = $request->cur_text;
    $general->cur_sym           = $request->cur_sym;
    $general->base_color        = $request->base_color;
    $general->secondary_color   = $request->secondary_color;

    $general->kv                = $request->boolean('kv');
    $general->ev                = $request->boolean('ev');
    $general->en                = $request->boolean('en');
    $general->sv                = $request->boolean('sv');
    $general->sn                = $request->boolean('sn');
    $general->force_ssl         = $request->boolean('force_ssl');
    $general->secure_password   = $request->boolean('secure_password');
    $general->registration      = $request->boolean('registration');
    $general->agree             = $request->boolean('agree');
    $general->auto_approved     = $request->boolean('auto_approved');

    // الكريدتس
    $general->deduct_credits        = (int) $request->deduct_credits;
    $general->add_credits           = (int) $request->add_credits;
    $general->given_credits         = (int) $request->given_credits;
    $general->daily_login_credits   = (int) $request->daily_login_credits;

    // السحب/التحويل
    $general->withdraw_notify_email = $request->withdraw_notify_email;
    $general->withdraw_rate_phone   = (float) $request->withdraw_rate_phone;
    $general->withdraw_rate_usdt    = (float) $request->withdraw_rate_usdt;
    $general->withdraw_min_phone    = (float) $request->withdraw_min_phone;
    $general->withdraw_min_usdt     = (float) $request->withdraw_min_usdt;

    // رقم المدار من قاعدة البيانات
    $general->almadar_wallet        = $request->almadar_wallet;

    $general->save();

    // حفظ المنطقة الزمنية في ملف الإعدادات
    $timezoneFile = config_path('timezone.php');
    $content = '<?php $timezone = ' . var_export($request->timezone, true) . ';';
    file_put_contents($timezoneFile, $content);

    // إشعار النجاح
    $notify[] = ['success', 'General Settings have been updated successfully'];
    return back()->withNotify($notify);
}

    public function logoIcon()
    {
        $pageTitle = 'Logo & Favicon';
        return view('admin.setting.logo_icon', compact('pageTitle'));
    }

    public function logoIconUpdate(Request $request)
    {
        $request->validate([
            'logo' => ['image',new FileTypeValidate(['jpg','jpeg','png'])],
            'favicon' => ['image',new FileTypeValidate(['png'])],
        ]);
        if ($request->hasFile('logo')) {
            try {
                $path = getFilePath('logoIcon');
                if (!file_exists($path)) {
                    mkdir($path, 0755, true);
                }
                Image::make($request->logo)->save($path . '/logo.png');
            } catch (\Exception $exp) {
                $notify[] = ['error', 'Couldn\'t upload the logo'];
                return back()->withNotify($notify);
            }
        }

        if ($request->hasFile('favicon')) {
            try {
                $path = getFilePath('logoIcon');
                if (!file_exists($path)) {
                    mkdir($path, 0755, true);
                }
                $size = explode('x', getFileSize('favicon'));
                Image::make($request->favicon)->resize($size[0], $size[1])->save($path . '/favicon.png');
            } catch (\Exception $exp) {
                $notify[] = ['error', 'Couldn\'t upload the favicon'];
                return back()->withNotify($notify);
            }
        }
        $notify[] = ['success', 'Logo & favicon has been updated successfully'];
        return redirect()->to(url()->previous() . '#refresh')->withNotify($notify);
    }

    public function cookie(){
        $pageTitle = 'GDPR Cookie';
        $cookie = Frontend::where('data_keys','cookie.data')->firstOrFail();
        return view('admin.setting.cookie',compact('pageTitle','cookie'));
    }

    public function cookieSubmit(Request $request){
        $request->validate([
            'short_desc'=>'required|string|max:255',
            'description'=>'required',
        ]);
        $cookie = Frontend::where('data_keys','cookie.data')->firstOrFail();
        $cookie->data_values = [
            'short_desc' => $request->short_desc,
            'description' => $request->description,
            'status' => $request->status ? 1 : 0,
        ];
        $cookie->save();
        $notify[] = ['success','Cookie policy has been updated successfully'];
        return back()->withNotify($notify);
    }

    public function customCss()
    {
        $pageTitle = 'Custom CSS';
        $file = activeTemplate(true) . 'css/custom.css';
        $file_content = @file_get_contents($file);
        return view('admin.setting.custom_css', compact('pageTitle', 'file_content'));
    }


    public function customCssSubmit(Request $request)
    {
        $request->validate([
            'css' => 'nullable|string|max:10000',
        ]);

        $css = $request->css ?? '';

        // Remove potentially dangerous @import rules and javascript expressions
        $css = preg_replace('/@import[^;]+;?/i', '', $css);
        $css = preg_replace('/expression\([^\)]+\)/i', '', $css);
        $css = preg_replace('/url\((\s*["\']?)javascript:[^\)]*\)/i', 'url()', $css);

        // Run through HTMLPurifier for additional CSS sanitization
        $config = \HTMLPurifier_Config::createDefault();
        $purifier = new \HTMLPurifier($config);
        $css = $purifier->purify('<style>' . $css . '</style>');
        $css = preg_replace('#^<style>|</style>$#', '', $css);

        $file = activeTemplate(true) . 'css/custom.css';
        if (!file_exists($file)) {
            fopen($file, "w");
        }
        file_put_contents($file, $css);

        // Store versioned copy for audit
        $versionPath = storage_path('app/custom-css');
        if (!file_exists($versionPath)) {
            mkdir($versionPath, 0755, true);
        }
        file_put_contents($versionPath . '/' . now()->format('YmdHis') . '.css', $css);

        // Log the update
        Log::info('Custom CSS updated', [
            'user_id' => auth()->id(),
            'checksum' => sha1($css),
        ]);

        $notify[] = ['success', 'CSS updated successfully'];
        return back()->withNotify($notify);
    }
}
