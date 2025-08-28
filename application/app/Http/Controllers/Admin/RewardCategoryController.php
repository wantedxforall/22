<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\RewardCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class RewardCategoryController extends Controller
{
    public function index()
    {
        $categories = RewardCategory::query()
            ->orderBy('sort_order')
            ->orderBy('name')
            ->paginate(20);

        $pageTitle = __('Reward Categories');

        return view('admin.reward_categories.index', compact('categories', 'pageTitle'));
    }

    public function create()
    {
        $pageTitle = __('Create Category');
        return view('admin.reward_categories.create', compact('pageTitle'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name'       => ['required', 'string', 'max:120'],
            'slug'       => ['nullable', 'string', 'max:160', 'unique:reward_categories,slug'],
            'status'     => ['sometimes', 'boolean'],
            'sort_order' => ['nullable', 'integer', 'min:0'],
            'image'      => ['nullable', 'image', 'mimes:jpg,jpeg,png,webp', 'max:4096'],
        ]);

        // slug غير فارغ دائمًا
        $baseForSlug  = trim($data['slug'] ?? '') !== '' ? $data['slug'] : $data['name'];
        $data['slug'] = $this->uniqueSlug($baseForSlug);

        // دعم status (وأيضًا is_active إن أُرسل من أي نموذج بدون تعديل الصفحات)
        $data['status'] = array_key_exists('status', $data)
            ? (bool)$data['status']
            : (bool)$request->boolean('is_active', true);

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('reward_categories', 'public');
        }

        $data['sort_order'] = $data['sort_order'] ?? 0;

        RewardCategory::create($data);

        return redirect()->route('admin.reward-categories.index')
            ->with('success', __('Category created successfully.'));
    }

    public function edit(RewardCategory $rewardCategory)
    {
        $pageTitle = __('Edit Category');

        return view('admin.reward_categories.edit', [
            'category'  => $rewardCategory, // الاسم الذي تتوقعه القوالب
            'pageTitle' => $pageTitle,
        ]);
    }

    public function update(Request $request, RewardCategory $rewardCategory)
    {
        $data = $request->validate([
            'name'       => ['required', 'string', 'max:120'],
            'slug'       => [
                'nullable', 'string', 'max:160',
                Rule::unique('reward_categories', 'slug')->ignore($rewardCategory->id),
            ],
            'status'     => ['sometimes', 'boolean'],
            'sort_order' => ['nullable', 'integer', 'min:0'],
            'image'      => ['nullable', 'image', 'mimes:jpg,jpeg,png,webp', 'max:4096'],
        ]);

        // slug غير فارغ دائمًا
        $baseForSlug  = trim($data['slug'] ?? '') !== '' ? $data['slug'] : $data['name'];
        $data['slug'] = $this->uniqueSlug($baseForSlug, $rewardCategory->id);

        // دعم status / is_active
        $data['status'] = array_key_exists('status', $data)
            ? (bool)$data['status']
            : (bool)$request->boolean('is_active', $rewardCategory->status);

        if ($request->hasFile('image')) {
            if ($rewardCategory->image && Storage::disk('public')->exists($rewardCategory->image)) {
                Storage::disk('public')->delete($rewardCategory->image);
            }
            $data['image'] = $request->file('image')->store('reward_categories', 'public');
        }

        $data['sort_order'] = $data['sort_order'] ?? ($rewardCategory->sort_order ?? 0);

        $rewardCategory->update($data);

        return redirect()->route('admin.reward-categories.index')
            ->with('success', __('Category updated successfully.'));
    }

    public function destroy(Request $request)
{
    // التقط id من أي مكان ممكن: route model / route param / query / body
    $routeTarget = $request->route('rewardCategory')
        ?? $request->route('category')
        ?? $request->route('reward_category')
        ?? $request->route('id')
        ?? null;

    $routeId = is_object($routeTarget)
        ? ($routeTarget->id ?? null)
        : (is_scalar($routeTarget) ? (int)$routeTarget : null);

    // ادمج القيمة بحيث تمرّ على الـ validation حتى لو لم تُرسل في body
    $request->merge([
        'id' => $request->input('id', $routeId),
    ]);

    $data = $request->validate([
        'id' => ['required', 'integer', 'exists:reward_categories,id'],
    ]);

    $category = RewardCategory::findOrFail($data['id']);

    if ($category->image && Storage::disk('public')->exists($category->image)) {
        Storage::disk('public')->delete($category->image);
    }

    $category->delete();

    return back()->with('success', __('Category deleted successfully.'));
}
    /**
     * توليد Slug فريد مع تجاهل السجل الحالي عند التعديل.
     * يعالج الحالة التي يرجع فيها Str::slug سلسلة فارغة (لغات غير لاتينية).
     */
    private function uniqueSlug(string $base, ?int $ignoreId = null): string
    {
        $slug = Str::slug($base);

        if ($slug === '') {
            $slug = 'rc-' . Str::lower(Str::random(6));
        }

        $original = $slug;
        $i = 1;

        $exists = function ($s) use ($ignoreId) {
            return RewardCategory::where('slug', $s)
                ->when($ignoreId, fn($q) => $q->where('id', '!=', $ignoreId))
                ->exists();
        };

        while ($exists($slug)) {
            $slug = $original . '-' . $i++;
        }

        return $slug;
    }
}
