@extends('admin.layouts.app')

@section('panel')
<div class="row mb-3">
    <div class="col-md-8">
        <form method="GET" id="filtersForm" class="d-flex flex-wrap gap-2 align-items-center">

            {{-- البحث مع أيقونة + زر مسح --}}
            <div class="input-group" style="max-width: 360px;">
                <span class="input-group-text">
                    <i class="las la-search"></i>
                </span>
                <input
                    type="text"
                    name="search"
                    value="{{ request('search') }}"
                    class="form-control"
                    placeholder="@lang('Search by name or anything…')"
                    id="searchInput"
                    autocomplete="off">
                <button type="button"
                        class="btn btn-outline-secondary"
                        id="clearSearch"
                        title="@lang('Clear')"
                        @if(!request('search')) style="display:none" @endif>
                    <i class="las la-times"></i>
                </button>
            </div>

            {{-- الحالة --}}
            <select name="status" class="form-select w-auto" id="statusSelect">
                <option value="">@lang('All')</option>
                <option value="1" {{ request('status')==='1' ? 'selected' : '' }}>@lang('Active')</option>
                <option value="0" {{ request('status')==='0' ? 'selected' : '' }}>@lang('Inactive')</option>
            </select>

            {{-- الفئة --}}
            <select name="category_id" class="form-select w-auto" id="categorySelect">
                <option value="">@lang('All categories')</option>
                @foreach($categories as $cat)
                    <option value="{{ $cat->id }}" @selected(request('category_id')==$cat->id)>{{ $cat->name }}</option>
                @endforeach
            </select>

            {{-- تطبيق يدوي (احتياطي) --}}
            <button class="btn btn--primary" type="submit">
                <i class="las la-filter"></i> @lang('Filter')
            </button>

            {{-- زر إعادة الضبط --}}
            @php $hasFilters = request('search') || strlen(request('status') ?? '') || request('category_id'); @endphp
            <a href="{{ route('admin.reward-items.index') }}"
               class="btn btn--dark"
               @if(!$hasFilters) style="display:none" @endif
               id="resetBtn">
                <i class="las la-undo"></i> @lang('Reset')
            </a>

            {{-- شارات الفلاتر المفعّلة --}}
            <div class="w-100"></div>
            <div class="d-flex flex-wrap gap-2 mt-1">
                @if(request('search'))
                    <span class="badge bg-primary">
                        <i class="las la-search me-1"></i>{{ request('search') }}
                    </span>
                @endif
                @if(request('status') !== null && request('status') !== '')
                    <span class="badge bg-info">
                        <i class="las la-toggle-on me-1"></i>
                        {{ request('status')==='1' ? __('Active') : __('Inactive') }}
                    </span>
                @endif
                @if(request('category_id'))
                    @php
                        $activeCat = $categories->firstWhere('id', (int) request('category_id'));
                    @endphp
                    @if($activeCat)
                        <span class="badge bg-secondary">
                            <i class="las la-folder me-1"></i>{{ $activeCat->name }}
                        </span>
                    @endif
                @endif
            </div>
        </form>
    </div>

    <div class="col-md-4 text-end">
        <a href="{{ route('admin.reward-items.create') }}" class="btn btn--primary">
            <i class="las la-plus"></i> @lang('Add Item')
        </a>
    </div>
</div>

<div class="card b-radius--10">
    <div class="card-body p-0">
        <div class="table-responsive--sm table-responsive">
  <table class="table table--light">
    <thead>
      <tr>
        
        <th>@lang('Name')</th>
        <th>@lang('Points')</th>
        <th>@lang('Status')</th>
        <th>@lang('Category')</th>
		<th>@lang('Image')</th> {{-- جديد --}}
        <th>@lang('Action')</th>
      </tr>
    </thead>
    <tbody>
      @forelse($rewardItems as $item)
        <tr>
          

          <td>{{ $item->name }}</td>
          <td>{{ $item->price_points }}</td>
          <td>@php echo $item->statusBadge(); @endphp</td>
          <td>{{ optional($item->category)->name ?? '-' }}</td>
		  {{-- صورة مصغّرة --}}
          <td>
  @php
    $file = $item->image ? ltrim(str_replace('reward_items/', '', $item->image), '/') : null;
    $url  = $file ? url('/reward_items/'.$file) : null;
  @endphp

  @if($url)
    <a href="{{ $url }}" target="_blank" rel="noopener" onclick="event.stopPropagation();">
      <img src="{{ $url }}" alt="{{ $item->name }}"
           style="height:40px;width:40px;object-fit:cover;border-radius:6px;border:1px solid #ddd;background:#fff;">
    </a>
  @else
    <span class="text-muted">-</span>
  @endif
</td>


          <td>
            <a href="{{ route('admin.reward-items.edit',$item->id) }}" class="btn btn-sm btn--primary">
              <i class="las la-edit"></i>
            </a>

            <form action="{{ route('admin.reward-items.destroy',$item->id) }}" method="POST" class="d-inline">
              @csrf @method('DELETE')
              <button type="submit" class="btn btn-sm btn--danger confirm-delete">
                <i class="las la-trash"></i>
              </button>
            </form>

            <form action="{{ route('admin.reward-items.toggle',$item->id) }}" method="POST" class="d-inline">
              @csrf
              <button type="submit" class="btn btn-sm btn--warning">
                @if($item->is_active)
                  <i class="las la-ban"></i>
                @else
                  <i class="las la-check"></i>
                @endif
              </button>
            </form>
          </td>
        </tr>
      @empty
        <tr>
          <td colspan="100%" class="text-center text-muted">@lang('No reward items found')</td>
        </tr>
      @endforelse
    </tbody>
  </table>
</div>

    </div>

    @if($rewardItems->hasPages())
        <div class="card-footer">
            {{ paginateLinks($rewardItems) }}
        </div>
    @endif
</div>
@endsection

@push('script')
<script>
(function($){
  'use strict';

  const form           = document.getElementById('filtersForm');
  const searchInput    = document.getElementById('searchInput');
  const clearSearchBtn = document.getElementById('clearSearch');
  const statusSelect   = document.getElementById('statusSelect');
  const categorySelect = document.getElementById('categorySelect');
  const resetBtn       = document.getElementById('resetBtn');

  // Debounce: إرسال بعد التوقف عن الكتابة
  let t;
  function debounceSubmit(){
    clearTimeout(t);
    t = setTimeout(() => form.requestSubmit(), 400);
  }

  // إظهار/إخفاء زر مسح البحث
  function toggleClear(){
    if (searchInput.value.trim().length) {
      clearSearchBtn.style.display = '';
      if (resetBtn) resetBtn.style.display = '';
    } else {
      clearSearchBtn.style.display = 'none';
    }
  }
  toggleClear();

  // كتابة في البحث → إرسال مؤجّل
  searchInput.addEventListener('input', function(){
    toggleClear();
    debounceSubmit();
  });

  // Enter يرسل فوراً + Esc يمسح
  searchInput.addEventListener('keydown', function(e){
    if (e.key === 'Enter') {
      e.preventDefault();
      form.requestSubmit();
    }
    if (e.key === 'Escape') {
      searchInput.value = '';
      toggleClear();
      form.requestSubmit();
    }
  });

  // زر مسح البحث
  clearSearchBtn.addEventListener('click', function(){
    searchInput.value = '';
    toggleClear();
    form.requestSubmit();
  });

  // تغيير أي Select يرسل مباشرة
  statusSelect.addEventListener('change', () => form.requestSubmit());
  categorySelect.addEventListener('change', () => form.requestSubmit());

  // تأكيد حذف
  $('.confirm-delete').on('click', function(e){
    e.preventDefault();
    if(confirm("@lang('Are you sure to delete this item?')")){
      $(this).closest('form').submit();
    }
  });

})(jQuery);
</script>
@endpush
