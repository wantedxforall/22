<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\RewardItem;
use App\Rules\FileTypeValidate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Storage;
use App\Models\RewardCategory;

class RewardItemController extends Controller
{
    public function index(Request $request)
    {
        $pageTitle = 'Reward Items';
        $query = RewardItem::with('category')->orderBy('sort_order')->latest();

        if ($request->search) {
            $query->where('name', 'like', "%" . $request->search . "%");
        }
		
		if ($request->filled('category_id')) {
			$query->where('category_id', $request->integer('category_id'));
		}

        if ($request->status != null && $request->status !== '') {
            $query->where('is_active', $request->status);
        }
		
		$items      = $query->paginate(20);
		$categories = RewardCategory::orderBy('sort_order')->orderBy('name')->get();

        $rewardItems = $query->latest()->paginate(getPaginate());

        return view('admin.reward_items.index', compact('pageTitle', 'rewardItems','items','categories'));
    }

    public function create()
	{
		$pageTitle  = 'Add Reward Item';
		$categories = RewardCategory::orderBy('sort_order')->orderBy('name')->get();

		return view('admin.reward_items.create', compact('pageTitle', 'categories'));
	}

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'price_points' => 'required|integer|min:0',
			'category_id'  => 'nullable|exists:reward_categories,id',
            'image' => ['nullable', 'image', new FileTypeValidate(['jpg', 'jpeg', 'png'])],
            'is_active' => 'nullable|boolean',
        ]);

        $rewardItem = new RewardItem();
        $rewardItem->name = $request->name;
        $rewardItem->price_points = $request->price_points;
        $rewardItem->is_active = $request->is_active ? 1 : 0;
		$rewardItem->category_id = $request->category_id;

        if ($request->hasFile('image')) {
            $rewardItem->image = $request->file('image')->store('reward_items', 'public');
        }

        $rewardItem->save();
        Cache::forget('reward_items');

        $notify[] = ['success', 'Reward item created successfully'];
        return to_route('admin.reward-items.index')->withNotify($notify);
    }

    public function edit($id)
	{
		$pageTitle  = 'Edit Reward Item';
		$rewardItem = RewardItem::findOrFail($id);
		$categories = RewardCategory::orderBy('sort_order')->orderBy('name')->get();

		return view('admin.reward_items.edit', compact('pageTitle', 'rewardItem', 'categories'));
	}

    public function update(Request $request, $id)
    {
        $rewardItem = RewardItem::findOrFail($id);

        $request->validate([
            'name' => 'required|string|max:255',
            'price_points' => 'required|integer|min:0',
			'category_id' => 'nullable|exists:reward_categories,id',
            'image' => ['nullable', 'image', new FileTypeValidate(['jpg', 'jpeg', 'png'])],
            'is_active' => 'nullable|boolean',
        ]);

        $rewardItem->name = $request->name;
        $rewardItem->price_points = $request->price_points;
        $rewardItem->is_active = $request->is_active ? 1 : 0;
		$rewardItem->category_id = $request->category_id;

        if ($request->hasFile('image')) {
            if ($rewardItem->image) {
                Storage::disk('public')->delete($rewardItem->image);
            }
            $rewardItem->image = $request->file('image')->store('reward_items', 'public');
        }

        $rewardItem->save();
        Cache::forget('reward_items');

        $notify[] = ['success', 'Reward item updated successfully'];
        return to_route('admin.reward-items.index')->withNotify($notify);
    }

    public function destroy($id)
    {
        $rewardItem = RewardItem::findOrFail($id);
        $rewardItem->delete();
        Cache::forget('reward_items');

        $notify[] = ['success', 'Reward item deleted successfully'];
        return back()->withNotify($notify);
    }

    public function toggle($id)
    {
        $rewardItem = RewardItem::findOrFail($id);
        $rewardItem->is_active = !$rewardItem->is_active;
        $rewardItem->save();
        Cache::forget('reward_items');

        $notify[] = ['success', 'Reward item status updated'];
        return back()->withNotify($notify);
    }
}