@extends('admin.layouts.app')

@section('panel')
<div class="card">
  <div class="card-body">

    {{-- رسالة النجاح --}}
    @if(session('success'))
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        {{ session('success') }}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    @endif

    <form method="POST" action="{{ route('admin.reward-categories.update',$category) }}" enctype="multipart/form-data">
      @csrf @method('PUT')
      <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label">@lang('Name')</label>
          <input type="text" name="name" class="form-control" value="{{ $category->name }}" required>
        </div>

        <div class="col-md-6">
          <label class="form-label">@lang('Slug')</label>
          <input type="text" name="slug" class="form-control" value="{{ $category->slug }}">
        </div>

        <div class="col-md-3">
          <label class="form-label">@lang('Status')</label>
          <select name="status" class="form-select">
            <option value="1" @selected($category->status==1)>@lang('Active')</option>
            <option value="0" @selected($category->status==0)>@lang('Inactive')</option>
          </select>
        </div>

        <div class="col-md-3">
          <label class="form-label">@lang('Sort order')</label>
          <input type="number" name="sort_order" class="form-control" min="0" value="{{ $category->sort_order }}">
        </div>

        <div class="col-md-6">
          <label class="form-label">@lang('Image')</label>
          <input type="file" name="image" class="form-control">

          @php
            // نجهّز اسم الملف والرابط عبر الراوت /reward_categories
            $placeholder = asset('assets/images/placeholder.png');
            $file = $category->image ? ltrim(str_replace('reward_categories/', '', $category->image), '/') : null;
            $abs  = $file ? storage_path('app/public/reward_categories/'.$file) : null;
            $url  = $file ? url('/reward_categories/'.$file) : null;
          @endphp

          @if($file && file_exists($abs))
            <div class="mt-2">
              <a href="{{ $url }}" target="_blank" rel="noopener" onclick="event.stopPropagation();">
                <img src="{{ $url }}" alt="{{ $category->name }}"
                     style="height:60px; border-radius:6px; border:1px solid #ddd; padding:2px; background:#fff;">
              </a>
              
            </div>
          @else
            <div class="mt-2">
              <img src="{{ $placeholder }}" alt="No Image"
                   style="height:60px; border-radius:6px; border:1px solid #ddd; padding:2px; background:#fff; opacity:.7;">
            </div>
          @endif
        </div>

        <div class="col-12 d-flex justify-content-between">
          <a href="{{ route('admin.reward-categories.index') }}" class="btn btn--secondary">
            <i class="fas fa-arrow-left"></i> @lang('Back')
          </a>
          <button class="btn btn--primary">
            @lang('Update')
          </button>
        </div>
      </div>
    </form>
  </div>
</div>
@endsection
