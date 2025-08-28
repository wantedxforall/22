@extends('admin.layouts.app')

@section('panel')
<div class="card">
  <div class="card-body">
    <form method="POST" action="{{ route('admin.reward-categories.store') }}" enctype="multipart/form-data">
      @csrf
      <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label">@lang('Name')</label>
          <input type="text" name="name" class="form-control" required>
        </div>
        <div class="col-md-6">
          <label class="form-label">@lang('Slug')</label>
          <input type="text" name="slug" class="form-control" placeholder="@lang('Auto if empty')">
        </div>
        <div class="col-md-3">
          <label class="form-label">@lang('Status')</label>
          <select name="status" class="form-select">
            <option value="1">@lang('Active')</option>
            <option value="0">@lang('Inactive')</option>
          </select>
        </div>
        <div class="col-md-3">
          <label class="form-label">@lang('Sort order')</label>
          <input type="number" name="sort_order" class="form-control" min="0" value="0">
        </div>
        <div class="col-md-6">
          <label class="form-label">@lang('Image')</label>
          <input type="file" name="image" class="form-control">
        </div>
        <div class="col-12">
          <button class="btn btn--primary w-100">@lang('Save')</button>
        </div>
      </div>
    </form>
  </div>
</div>
@endsection
