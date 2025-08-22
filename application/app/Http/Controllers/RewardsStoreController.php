<?php

namespace App\Http\Controllers;

use App\Models\RewardItem;
use App\Models\RewardOrder;
use App\Models\RewardCategory;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class RewardsStoreController extends Controller
{
    public function index(Request $request)
    {
        $query = RewardItem::active();

        if ($request->filled('min')) {
            $query->where('price_points', '>=', (int) $request->input('min'));
        }
        if ($request->filled('max')) {
            $query->where('price_points', '<=', (int) $request->input('max'));
        }

        $sort = $request->input('sort') === 'desc' ? 'desc' : 'asc';
        $query->orderBy('price_points', $sort);

        $cacheKey = 'reward_items_' . md5($request->fullUrl());
        $items = Cache::remember($cacheKey, 30, function () use ($query) {
            return $query->paginate(12);
        });

        // ولّد توكن جلسة لكل عنصر (idempotency per item)
        foreach ($items as $item) {
            $token = (string) Str::uuid();
            session(['reward_token_' . $item->id => $token]);
            $item->idempotency_token = $token;
        }

        return view('rewards.index', [
            'items' => $items,
            'user'  => $request->user(),
            'sort'  => $sort,
        ]);
    }

    public function store(Request $request, RewardItem $item)
    {
        // تحقّق من التوكن القادم من الفورم
        $data = $request->validate([
            'token' => ['required', 'string', 'uuid'],
        ]);
        $token = $data['token'];
        $user  = $request->user();

        // طابق توكن الجلسة بالعنصر
        $sessionToken = session('reward_token_' . $item->id);
        if (!$sessionToken || !hash_equals($sessionToken, $token)) {
            return back()->with('error', __('Duplicate or invalid submission'));
        }

        // مانع تكرار قصير الأجل (5 دقائق)
        $cacheKey = "redeem:{$item->id}:{$token}:{$user->id}";
        if (! Cache::add($cacheKey, true, now()->addMinutes(5))) {
            return back()->with('error', __('Duplicate or invalid submission'));
        }

        try {
            DB::transaction(function () use ($user, $item, $token) {
                /** @var \App\Models\RewardItem $lockedItem */
                $lockedItem = RewardItem::whereKey($item->id)->lockForUpdate()->first();
                if (! $lockedItem || ! $lockedItem->is_active) {
                    throw ValidationException::withMessages([
                        'item' => __('Item is not available at the moment.'),
                    ]);
                }

                // تحقّق المخزون إن كان مفعّلاً
                if (! is_null($lockedItem->stock) && (int) $lockedItem->stock < 1) {
                    throw ValidationException::withMessages([
                        'item' => __('Out of stock.'),
                    ]);
                }

                /** @var \App\Models\User $lockedUser */
                $lockedUser = User::whereKey($user->id)->lockForUpdate()->first();

                $price = (int) ($lockedItem->price_points ?? 0);
                if ($price < 0) { $price = 0; }

                if ((int) $lockedUser->credits < $price) {
                    throw ValidationException::withMessages([
                        'credits' => __('Not enough points.'),
                    ]);
                }

                // idempotency على مستوى قاعدة البيانات
                if (RewardOrder::where('token', $token)->exists()) {
                    throw ValidationException::withMessages([
                        'token' => __('Duplicate or invalid submission'),
                    ]);
                }

                // الخصم/المخزون
                if ($price > 0) {
                    $lockedUser->decrement('credits', $price);
                }
                if (! is_null($lockedItem->stock)) {
                    $lockedItem->decrement('stock');
                }

                // إنشاء الطلب — الحالة رقمية لتفادي Data truncated
                RewardOrder::create([
                    'user_id'        => $lockedUser->id,
                    'reward_item_id' => $lockedItem->id,
                    'price_points'   => $price,
                    'token'          => $token,
                    'status'         => RewardOrder::STATUS_PENDING, // start with pending status
                ]);
            });
        } catch (\Throwable $e) {
            Cache::forget($cacheKey);

            if ($e instanceof ValidationException) {
                return back()
                    ->withErrors($e->errors())
                    ->with('error', __('Duplicate or invalid submission'));
            }

            report($e);
            return back()->with('error', __('Something went wrong. Please try again.'));
        }

        // نظّف توكن الجلسة لهذا العنصر
        session()->forget('reward_token_' . $item->id);

        return redirect()
            ->route('rewards.orders')
            ->with('success', __('Redeemed successfully.'));
    }

    public function ordersIndex(Request $request)
    {
        $orders = RewardOrder::with('item')
            ->where('user_id', $request->user()->id)
            ->latest()
            ->paginate(15);

        return view('rewards.orders', ['orders' => $orders]);
    }

    public function categories()
    {
        $categories = RewardCategory::active()
            ->withCount(['items' => function($q){ $q->where('is_active',1); }])
            ->orderBy('sort_order')->orderBy('name')
            ->get();

        return view('rewards.categories', compact('categories'));
    }

    public function category(Request $request, $slug)
    {
        $category = RewardCategory::active()->where('slug', $slug)->firstOrFail();

        $items = RewardItem::active()
            ->where('category_id', $category->id)
            ->orderBy('sort_order')->latest()
            ->paginate(12);

        $user = $request->user();

        // مهم: ولّد توكن لكل عنصر أيضاً داخل صفحة التصنيف
        foreach ($items as $it) {
            $token = (string) Str::uuid();
            session(['reward_token_' . $it->id => $token]);
            $it->idempotency_token = $token;
        }

        return view('rewards.index', compact('items','user','category'));
    }
}
