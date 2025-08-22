<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;

class RewardController extends Controller
{
    public function index()
    {
        $pageTitle = trans('rewards.title');

        $items = [
            ['id' => 1, 'name' => trans('rewards.sample_reward'), 'points' => 100, 'image' => route('placeholder.image', '60x60')],
        ];

        $orders = [];

        return view($this->activeTemplate . 'user.rewards', compact('pageTitle', 'items', 'orders'));
    }
}