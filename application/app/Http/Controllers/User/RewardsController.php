<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\RewardItem;
use App\Models\RewardCategory;
use Illuminate\Http\Request;
use App\Models\RewardCategory;

class RewardsController extends Controller
{
    public function index(Request $request, $slug = null)
    {
        $q    = trim((string) $request->get('q', ''));
        $min  = $request->filled('min') ? (int) $request->min : null;
        $max  = $request->filled('max') ? (int) $request->max : null;
        $sort = $request->get('sort', 'points_asc'); // points_asc, points_desc, name_asc, name_desc, newest

        $categories = RewardCategory::where('is_active', true)
            ->orderBy('name')->get(['id','name','slug']);

        $activeCategory = null;
        if ($slug) {
            $activeCategory = $categories->firstWhere('slug', $slug);
            if (!$activeCategory) {
                abort(404);
            }
        } elseif ($request->filled('category')) {
            $activeCategory = $categories->firstWhere('slug', $request->get('category'));
        }

        $items = RewardItem::query()
            ->with('category')
            ->when($activeCategory, fn($q2) => $q2->where('category_id', $activeCategory->id))
            ->when($q !== '', fn($q2) => $q2->where('name', 'like', '%'.$q.'%'))
            ->when(!is_null($min), fn($q2) => $q2->where('price_points', '>=', $min))
            ->when(!is_null($max), fn($q2) => $q2->where('price_points', '<=', $max))
            ->when(true, function ($q2) use ($sort) {
                return match ($sort) {
                    'points_desc' => $q2->orderBy('price_points', 'desc'),
                    'name_asc'    => $q2->orderBy('name', 'asc'),
                    'name_desc'   => $q2->orderBy('name', 'desc'),
                    'newest'      => $q2->orderBy('created_at', 'desc'),
                    default       => $q2->orderBy('price_points', 'asc'),
                };
            })
            ->paginate(12)
            ->withQueryString();

        $pageTitle = __('Rewards Store');
        $user = auth()->user();

        return view($this->activeTemplate.'user.rewards.index', compact(
            'pageTitle', 'items', 'user', 'categories', 'activeCategory'
        ));
    }
}
