@extends('admin.layouts.app')
@section('panel')
<div class="row">
  <div class="col-xl-12">
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="card-title mb-0">{{ $pageTitle ?? 'Benefit Overrides' }}</h5>
        <a href="{{ route('admin.benefit-overrides.create') }}" class="btn btn--primary">@lang('Add Override')</a>
      </div>
      <div class="card-body">
        <form method="get" class="row gy-2 gx-2 mb-3">
          <div class="col-md-4">
            <input class="form-control" type="text" name="q" value="{{ request('q') }}" placeholder="@lang('Search by username/email')">
          </div>
          <div class="col-md-4">
            <select class="form-select" name="type">
              <option value="">@lang('All types')</option>
              @foreach($allowedTypes as $t)
                <option value="{{ $t }}" @selected(request('type')===$t)>{{ $t }}</option>
              @endforeach
            </select>
          </div>
          <div class="col-md-4">
            <button class="btn btn--primary" type="submit">@lang('Filter')</button>
          </div>
        </form>

        <div class="table-responsive">
          <table class="table table--light">
            <thead>
              <tr>
                <th>@lang('ID')</th>
                <th>@lang('User')</th>
                <th>@lang('Type')</th>
                <th>@lang('Value')</th>
                <th>@lang('Starts')</th>
                <th>@lang('Ends')</th>
                <th>@lang('Active')</th>
                <th class="text-end">@lang('Action')</th>
              </tr>
            </thead>
            <tbody>
              @forelse($overrides as $ovr)
                <tr>
                  <td>{{ $ovr->id }}</td>
                  <td>
                    @if($ovr->user)
                      <div>{{ $ovr->user->username }}</div>
                      <div class="text-muted small">{{ $ovr->user->email }}</div>
                    @else
                      <em class="text-muted">#{{ $ovr->user_id }}</em>
                    @endif
                  </td>
                  <td><code>{{ $ovr->type }}</code></td>
                  <td>{{ $ovr->value }}</td>
                  <td>{{ optional($ovr->starts_at)->toDateString() }}</td>
                  <td>{{ optional($ovr->ends_at)->toDateString() }}</td>
                  <td>
                    @if($ovr->is_active)
                      <span class="badge badge--success">@lang('Yes')</span>
                    @else
                      <span class="badge badge--dark">@lang('No')</span>
                    @endif
                  </td>
                  <td class="text-end">
                    <a href="{{ route('admin.benefit-overrides.edit', $ovr->id) }}" class="btn btn-sm btn--primary">@lang('Edit')</a>
                    <form action="{{ route('admin.benefit-overrides.destroy', $ovr->id) }}" method="post" class="d-inline">
                      @csrf
                      @method('DELETE')
                      <button class="btn btn-sm btn--danger" onclick="return confirm('@lang('Are you sure?')')">@lang('Delete')</button>
                    </form>
                  </td>
                </tr>
              @empty
                <tr><td colspan="8" class="text-center text-muted">@lang('No overrides found')</td></tr>
              @endforelse
            </tbody>
          </table>
        </div>

        <div class="mt-3">
          {{ $overrides->links() }}
        </div>
      </div>
    </div>
  </div>
</div>
@endsection
