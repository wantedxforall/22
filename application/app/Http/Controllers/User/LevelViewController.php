<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Level;
use App\Models\UserLevel;
use Illuminate\Http\Request;

class LevelViewController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();
        $progress = UserLevel::progress($user);
        $userPoints = $progress['points'];

        $levels = Level::with('benefits')
            ->where('is_active', 1)
            ->orderBy('min_points_spent', 'asc')
            ->get();

        $currentLevel = $levels
            ->where('min_points_spent', '<=', $userPoints)
            ->last();

        return view($this->activeTemplate.'user.levels.index', [
            'levels'       => $levels,
            'currentLevel' => $currentLevel,
            'nextLevel'    => $progress['nextLevel'],
            'pointsToNext' => $progress['pointsToNext'],
            'user'         => $user,
        ]);
    }

}