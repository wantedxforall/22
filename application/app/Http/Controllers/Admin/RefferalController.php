<?php

namespace App\Http\Controllers\Admin;

use App\Models\Refferal;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class RefferalController extends Controller
{
    public function index()
    {
        $pageTitle = "Refferal";
        // رجّع كائن افتراضي لو ما فيش سجل
        $refferal  = Refferal::first() ?? new Refferal(['level' => 1, 'percent' => 0]);

        return view('admin.refferal.index', compact('pageTitle', 'refferal'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'percent' => ['required', 'numeric', 'between:0,100'],
        ]);

        // حدّث أو أنشئ سجل المستوى 1 تلقائيًا
        Refferal::updateOrCreate(
            ['level' => 1],
            ['percent' => $validated['percent']]
        );

        $notify[] = ['success', 'Successfully updated referral settings'];
        return back()->withNotify($notify);
    }
}
