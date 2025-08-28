@extends('admin.layouts.app')
@section('panel')
<div class="row">
  <div class="col-xl-8 col-lg-9">
    <div class="card">
      <div class="card-header">
        <h5 class="card-title mb-0">{{ $pageTitle ?? 'Edit Benefit Override' }}</h5>
      </div>
      <div class="card-body">
        <form method="post" action="{{ route('admin.benefit-overrides.update', $override->id) }}">
          @csrf
          @method('PUT')
          <div class="mb-3">
            <label class="form-label">@lang('User (username or email)')</label>
            <input type="text" name="user_identifier" class="form-control" value="{{ old('user_identifier', optional($user)->username ?? optional($user)->email) }}" required>
          </div>
          <div class="mb-3">
            <label class="form-label">@lang('Type')</label>
            <select name="type" class="form-select" required>
              @foreach($allowedTypes as $t)
                <option value="{{ $t }}" @selected(old('type',$override->type)===$t)>{{ $t }}</option>
              @endforeach
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">@lang('Value')</label>
            <input type="number" name="value" class="form-control" value="{{ old('value',$override->value) }}" step="0.01" required>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">@lang('Starts at')</label>
              <input type="date" name="starts_at" class="form-control" value="{{ old('starts_at', optional($override->starts_at)->toDateString()) }}">
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">@lang('Ends at')</label>
              <input type="date" name="ends_at" class="form-control" value="{{ old('ends_at', optional($override->ends_at)->toDateString()) }}">
            </div>
          </div>
          <div class="form-check mb-3">
            <input type="checkbox" class="form-check-input" id="is_active" name="is_active" value="1" {{ old('is_active', $override->is_active) ? 'checked' : '' }}>
            <label class="form-check-label" for="is_active">@lang('Active')</label>
          </div>
          <div class="mt-3">
            <button class="btn btn--primary">@lang('Update')</button>
            <a class="btn btn--secondary" href="{{ route('admin.benefit-overrides.index') }}">@lang('Cancel')</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
@endsection
