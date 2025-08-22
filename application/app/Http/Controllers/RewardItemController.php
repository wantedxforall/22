<?php

namespace App\Http\Controllers;

use App\Events\RewardRedeemed;
use App\Models\RewardItem;
use App\Services\LevelDiscountService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RewardItemController extends Controller
{
    public function create()
    {
        return view('reward_items.form');
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'cost' => 'required|integer|min:0',
            'quantity' => 'nullable|integer|min:0',
            'delivery_method' => 'nullable|string',
        ]);

        RewardItem::create($data);

        return redirect()->back();
    }

    public function redeem(RewardItem $rewardItem, LevelDiscountService $discounts)
    {
        $user = Auth::user();
        $multiplier = $discounts->multiplier($user);
        $cost = (int) round($rewardItem->cost * $multiplier);

        $rewardItem->decrementQuantity();

        event(new RewardRedeemed($rewardItem, $user, $cost, $multiplier));

        return response()->json([
            'cost' => $cost,
        ]);
    }
}