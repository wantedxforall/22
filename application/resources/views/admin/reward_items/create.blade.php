@extends('admin.layouts.app')
@section('panel')
<div class="row mb-none-30">
    <div class="col-lg-12 mb-30">
        <div class="card">
            <div class="card-body">
                <form action="{{ route('admin.reward-items.store') }}" method="POST" enctype="multipart/form-data">
                    @csrf
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">@lang('Name')</label>
                            <input type="text" name="name" value="{{ old('name') }}" class="form-control" required>
                        </div>
						<div class="col-md-6 mb-3">
						  <label class="form-label">@lang('Category')</label>
						  <select name="category_id" class="form-select">
							<option value="">@lang('No category')</option>
							@foreach($categories as $cat)
							  <option value="{{ $cat->id }}">{{ $cat->name }}</option>
							@endforeach
						  </select>
						</div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">@lang('Price Points')</label>
                            <input type="number" name="price_points" value="{{ old('price_points') }}" class="form-control" min="0" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">@lang('Image')</label>
                            <input type="file" name="image" class="form-control">
                        </div>
                        <div class="col-md-6 mb-3 d-flex align-items-center">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="is_active" name="is_active" value="1" checked>
                                <label class="form-check-label" for="is_active">@lang('Active')</label>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <button type="submit" class="btn btn--primary w-100">@lang('Save')</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection

@push('breadcrumb-plugins')
<a href="{{ route('admin.reward-items.index') }}" class="btn btn-sm btn--primary"><i class="las la-angle-double-left"></i>@lang('Go Back')</a>
@endpush