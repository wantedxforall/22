<?php

namespace App\Http\Controllers\User;

use App\Models\Proof;
use App\Models\Service;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ServiceController extends Controller
{
    public function index(){
        $pageTitle = 'All Posts';
        $user = auth()->user();
        $services = Service::with('category')->where('user_id',$user->id)->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.services.index',compact('pageTitle','services'));
    }

    public function create()
{
    $pageTitle  = 'Add Post';
    $categories = Category::with('actor')->where('status', 1)->get();

    $user = auth()->user()->fresh();
    // مجموع الاعتمادات المحجوزة في الخدمات النشطة
    $totalAllocated = Service::where('user_id', $user->id)
        ->where('status', 1)
        ->sum('allocated_credits');

    $totalCredits     = (int) ($user->credits ?? 0);
    $availableCredits = max(0, $totalCredits - (int) $totalAllocated);

    return view($this->activeTemplate.'user.services.create', compact(
        'pageTitle',
        'categories',
        'totalCredits',
        'availableCredits'
    ));
}


    public function store(Request $request){
        $category = Category::findOrFail($request->category);

        $request->validate([
            'name' => 'required',
            'link' => 'required|url',
            'category' => 'required',
            'allocated_credits' => "required|integer|min:{$category->min_points}",
        ],[
            'allocated_credits.min' => "Allocated credits must be at least {$category->min_points}",
        ]);

        $user =  auth()->user()->load('level.benefits');

        $reduction = optional($user->level?->benefits->firstWhere('type', 'post_creation_cost_reduction_percent'))->value ?? 0;

        $totalAllocated = Service::where('user_id', $user->id)
                         ->where('status', 1)
                         ->sum('allocated_credits');

		$availableCredits = max(0, ($user->credits - $totalAllocated));

        $requiredCredits = (int) ceil($request->allocated_credits - ($request->allocated_credits * $reduction / 100));

        if ($requiredCredits > $availableCredits) {
                // كم متابع يقدر يحجزه الآن حسب رصيده المتاح و min_points للتصنيف مع التخفيض
                $costPerFollower = max(1, (int) ceil($category->min_points - ($category->min_points * $reduction / 100)));
                $maxFollowers = (int) floor($availableCredits / $costPerFollower);
                return back()
                        ->withErrors(['allocated_credits' => "رصيدك الحالي يسمح بطلب {$maxFollowers} متابع فقط"])
                        ->withInput();
        }


        $purifier = new \HTMLPurifier();

        $service = new Service();
        $service->user_id = $user->id;
        $service->category_id = $request->category;
        $service->name = $request->name;
        $service->link = $request->link;
        $service->link_description = $purifier->purify($request->link_description);
        $service->allocated_credits = intval($request->allocated_credits ?? 0);
        $service->status = (gs()->auto_approved == 1) ? 1 : 0;

        // تعبئة المنصة تلقائياً من الرابط
        $service->platform = Service::detectPlatformFromLink($request->link);
        
        //$user->credits = max(0, $user->credits - $request->allocated_credits);

        $service->save();
        $user->save();

        $notify[] = ['success', 'Service has been created successfully'];
        return back()->withNotify($notify);
    }

    public function edit($id){
        $pageTitle = 'Update Post';
        $categories = Category::with('actor')->where('status',1)->get();
        $service = Service::findOrFail($id);
        return view($this->activeTemplate.'user.services.edit',compact('pageTitle','categories','service'));
    }

    public function update(Request $request,$id){
        $category = Category::findOrFail($request->category);

        $request->validate([
            'name' => 'required',
            'link' => 'required|url',
            'category' => 'required',
            'allocated_credits' => "required|integer|min:{$category->min_points}",
        ],[
            'allocated_credits.min' => "Allocated credits must be at least {$category->min_points}",
        ]);

        $user = auth()->user()->load('level.benefits');
        $purifier = new \HTMLPurifier();

        $service = Service::findOrFail($id);

        $previousCredits = $service->allocated_credits;
        
        $reduction = optional($user->level?->benefits->firstWhere('type', 'post_creation_cost_reduction_percent'))->value ?? 0;
        $additional = max(0, $request->allocated_credits - $previousCredits);
        $requiredCredits = (int) ceil($additional - ($additional * $reduction / 100));

        if ($requiredCredits > $user->credits) {
            $notify[] = ['error', 'Insufficient credits to update the service'];
            return back()->withNotify($notify);
        }

        $difference = $request->allocated_credits - $previousCredits;

        $service->user_id = $user->id;
        $service->category_id = $request->category;
        $service->name = $request->name;
        $service->link = $request->link;
        $service->link_description = $purifier->purify($request->link_description);
        $service->allocated_credits = $request->allocated_credits;

        // إعادة تحديد المنصة إذا تغير الرابط
        $service->platform = Service::detectPlatformFromLink($request->link);
        
        $service->save();

        //*if ($difference > 0) {
        //    $user->credits = max(0, $user->credits - $difference);
        //} elseif ($difference < 0) {
        //    $user->credits += abs($difference);
        //}

        $user->save();

        $notify[] = ['success', 'Service has been updated successfully'];
        return back()->withNotify($notify);
    }

    public function pending(){
        $pageTitle = 'Pending Posts';
        $user = auth()->user();
        $services = Service::with('category')->where('user_id',$user->id)->where('status',0)->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.services.index',compact('pageTitle','services'));
    }

    public function active(){
        $pageTitle = 'Pending Posts';
        $user = auth()->user();
        $services = Service::with('category')->where('user_id',$user->id)->where('status',1)->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.services.index',compact('pageTitle','services'));
    }

    public function changeStatus(Request $request)
    {
        $user = auth()->user();
        $service = $user->services()->where('id', $request->id)->firstOrFail();

        if ($request->status == 1 && $service->allocated_credits > $user->credits) {
            $notify[] = ['error', 'Insufficient credits to activate the service'];
            return back()->withNotify($notify);
        }

        $service->status = $request->status;
        $service->save();

        $notify[] = ['success', 'Service status has been changed successfully'];
        return back()->withNotify($notify);
    }

}