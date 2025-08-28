<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\RewardOrder;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RewardOrderController extends Controller
{
    public function index(Request $request)
{
    $pageTitle = 'Reward Orders';
    $orders = RewardOrder::with(['user', 'item']);

    if ($request->filled('status')) {
        $statusParam = $request->status;

        // اسم → رقم
        $map = [
            'pending'   => RewardOrder::STATUS_PENDING,
            'approved'  => RewardOrder::STATUS_APPROVED,
            'rejected'  => RewardOrder::STATUS_REJECTED,
            'cancelled' => RewardOrder::STATUS_CANCELLED,
        ];

        if (is_numeric($statusParam)) {
            $orders->where('status', (int) $statusParam);
        } elseif (isset($map[$statusParam])) {
            $orders->where('status', $map[$statusParam]);
        }
    }

    if ($request->filled('user')) {
        $search = $request->user;
        $orders->whereHas('user', function ($q) use ($search) {
            $q->where('username', 'like', "%$search%")
              ->orWhere('email', 'like', "%$search%")
              ->orWhere('id', $search);
        });
    }

    if ($request->filled('item')) {
        $search = $request->item;
        $orders->whereHas('item', function ($q) use ($search) {
            $q->where('name', 'like', "%$search%")
              ->orWhere('id', $search);
        });
    }

    $orders = $orders->orderBy('id', 'desc')
                     ->paginate(getPaginate())
                     ->withQueryString();

    $emptyMessage = 'No reward orders found';

    return view('admin.reward_orders.index', compact('pageTitle', 'orders', 'emptyMessage'));
}


    // App\Http\Controllers\Admin\RewardOrderController.php

public function update(Request $request, RewardOrder $order)
{
    $request->validate([
        'action' => 'required|in:approve,reject,cancel',
        'refund' => 'sometimes|boolean',
        'notes'  => 'nullable|string|max:1000',

        // الهدية مطلوبة فقط عند الاعتماد
        'gift'   => 'required_if:action,approve|string|max:255',
    ]);

    // اسمح بالتعديل فقط على المُعلّق
    if ((int)$order->status !== (int) RewardOrder::STATUS_PENDING) {
        $notify[] = ['error', 'Only pending orders can be modified'];
        return back()->withNotify($notify);
    }

    $action = $request->input('action');

    // اعتماد
    if ($action === 'approve') {
        $order->status     = RewardOrder::STATUS_APPROVED;
        $order->admin_note = $request->filled('notes') ? $request->notes : $order->admin_note;

        // حفظ الهدية
        $order->gift       = $request->input('gift');

        $order->acted_by   = auth('admin')->id() ?? null;
        $order->acted_at   = now();
        $order->save();

        $notify[] = ['success', 'Reward order approved successfully'];
        return back()->withNotify($notify);
    }

    // رفض أو إلغاء + ترجيع نقاط (إن طُلب)
    DB::transaction(function () use ($request, $order, $action) {
        if ($request->boolean('refund')) {
            $amount = (int) ($order->price_points ?? 0);

            $user = User::lockForUpdate()->find($order->user_id);
            $fieldsPriority = ['credits', 'reward_points', 'points', 'balance'];

            $field = null;
            foreach ($fieldsPriority as $f) {
                if (array_key_exists($f, $user->getAttributes())) {
                    $field = $f; break;
                }
            }

            if ($field && $amount > 0) {
                $user->{$field} = (int) ($user->{$field} ?? 0) + $amount;
                $user->save();
            }
        }

        $order->status = $action === 'reject'
            ? RewardOrder::STATUS_REJECTED
            : RewardOrder::STATUS_CANCELLED;

        if ($request->filled('notes')) {
            $order->admin_note = $request->notes;
        }

        // عند الرفض/الإلغاء لا نحفظ gift
        $order->acted_by = auth('admin')->id() ?? null;
        $order->acted_at = now();
        $order->save();
    });

    $msg = $action === 'reject'
        ? 'Reward order rejected successfully'
        : 'Reward order cancelled successfully';

    $notify[] = ['success', $msg];
    return back()->withNotify($notify);
}



}