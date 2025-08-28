<?php

namespace App\Http\Controllers;

use App\Models\RewardOrder;
use Illuminate\Http\Request;

class RewardOrderController extends Controller
{
    public function update(Request $request, RewardOrder $rewardOrder)
    {
        $rewardOrder->fill($request->all());
        $rewardOrder->acted_by = auth()->id();
        $rewardOrder->acted_at = now();
        $rewardOrder->save();

        return redirect()->back();
    }
}
