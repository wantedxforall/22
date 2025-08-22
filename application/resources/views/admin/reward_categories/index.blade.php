@extends('admin.layouts.app')

@section('panel')
<div class="d-flex justify-content-between align-items-center mb-3">
  <h5 class="mb-0">{{ __($pageTitle ?? 'Reward Categories') }}</h5>
  <a href="{{ route('admin.reward-categories.create') }}" class="btn btn--primary">@lang('Add Category')</a>
</div>

<div class="card">
  <div class="card-body p-0">
    <div class="table-responsive">
      <table class="table table--light style--two">
        <thead>
          <tr>
            <th>@lang('ID')</th>
            <th>@lang('Name')</th>
            <th>@lang('Slug')</th>
            <th>@lang('Status')</th>
            <th>@lang('Sort')</th>
            <th>@lang('Image')</th>
            <th>@lang('Action')</th>
          </tr>
        </thead>
        <tbody>
        @forelse($categories as $cat)
          <tr>
            <td>{{ $cat->id }}</td>
            <td>{{ $cat->name }}</td>
            <td>{{ $cat->slug }}</td>
            <td>
              @if($cat->status)
                <span class="badge badge--success">@lang('Active')</span>
              @else
                <span class="badge badge--danger">@lang('Inactive')</span>
              @endif
            </td>
            <td>{{ $cat->sort_order }}</td>
<td>
  @php
    $placeholder = asset('assets/images/placeholder.png'); // ضع هنا مسار صورة افتراضية
    $file = $cat->image ? ltrim(str_replace('reward_categories/', '', $cat->image), '/') : null;
    $url  = $file ? url('/reward_categories/'.$file) : null;
  @endphp

  @if($url && file_exists(storage_path('app/public/reward_categories/'.$file)))
    <a href="{{ $url }}" target="_blank" rel="noopener" onclick="event.stopPropagation();">
      <img src="{{ $url }}" 
           alt="{{ $cat->name }}" 
           style="height:60px; border-radius:6px; display:inline-block;">
    </a>
  @else
    <img src="{{ $placeholder }}" 
         alt="No Image" 
         style="height:60px; border-radius:6px; display:inline-block; opacity:0.6;">
  @endif
</td>






            <td>
              <a href="{{ route('admin.reward-categories.edit',$cat) }}" class="btn btn-sm btn--primary">@lang('Edit')</a>
              <form action="{{ route('admin.reward-categories.destroy',$cat) }}" method="POST" class="d-inline" onsubmit="return confirm('@lang('Delete?')')">
                @csrf @method('DELETE')
                <button class="btn btn-sm btn--danger">@lang('Delete')</button>
              </form>
            </td>
          </tr>
        @empty
          <tr><td colspan="7" class="text-center">@lang('No data found')</td></tr>
        @endforelse
        </tbody>
      </table>
    </div>
  </div>
  <div class="card-footer">
    {{ $categories->links() }}
  </div>
</div>
@endsection
