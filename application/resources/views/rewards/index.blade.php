@extends($activeTemplate.'layouts.master')
@php 
  $pageTitle   = __('Rewards Store'); 
  $userCredits = optional($user)->credits ?? optional(auth()->user())->credits ?? 0;

  $backUrl = url()->previous();
  if (!$backUrl || $backUrl === url()->current()) {
      $backUrl = route('rewards.index');
  }
@endphp

@section('content')
<div class="content-with-sidebar">
  <div class="container py-3">

    {{-- رسائل --}}
    @if(session('error'))
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        {{ session('error') }}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="@lang('Close')"></button>
      </div>
    @endif
    @if(session('success'))
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        {{ session('success') }}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="@lang('Close')"></button>
      </div>
    @endif

    {{-- هيدر: زر رجوع يسار + نقاط يمين --}}
    <div class="d-flex justify-content-between align-items-center mb-3">
      <a href="{{ $backUrl }}" class="btn btn--base d-flex align-items-center justify-content-center b-radius--10">
        <i class="las la-arrow-left me-1"></i> @lang('Back')
      </a>

      <div class="points-pill">
        <i class="las la-coins me-2"></i>
        <div class="text-end">
          <div class="points-label">@lang('Available Points')</div>
          <div class="points-value">{{ showAmount($userCredits) }} <span class="text-muted">pts</span></div>
        </div>
      </div>
    </div>

    {{-- الشبكة --}}
    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 g-3" id="itemsGrid">
      @forelse($items as $item)
        @php
          $pricePoints = max(0, (int)($item->price_points ?? 0));
          $enough  = $userCredits >= $pricePoints || $pricePoints === 0;
          $shortBy = max(0, $pricePoints - $userCredits);
          $imgFile = $item->image ? basename($item->image) : null;
          $imgUrl  = $imgFile ? url('reward_items/'.$imgFile) : null;
          $fallback = asset('images/placeholder.webp');

          $percent = $pricePoints > 0 ? min(100, (int) floor(($userCredits / $pricePoints) * 100)) : 100;
          $barClass = $enough ? 'bg-success' : ($percent >= 60 ? 'bg-warning' : 'bg-danger');
          $progressLabel = $enough 
              ? __('Ready') 
              : __('Need').' '.showAmount($shortBy).' '.__('pts');
        @endphp

        <div class="col reward-card" data-price="{{ $pricePoints }}">
          <div class="card h-100 shadow-sm border-0 rounded-3 overflow-hidden">
            <div class="ratio ratio-16x9 bg-light">
              <img
                src="{{ $imgUrl }}"
                alt="{{ $item->name }}"
                class="w-100 h-100"
                style="object-fit:cover"
                loading="lazy"
                onerror="this.onerror=null;this.src='{{ $fallback }}'">
            </div>

            <div class="card-body d-flex flex-column">
              <h6 class="fw-semibold mb-1 text-truncate" title="{{ $item->name }}">{{ $item->name }}</h6>
              <p class="text-muted small mb-3 line-clamp-2">{{ $item->description }}</p>

              {{-- السعر + شريط التقدم --}}
              <div class="mb-2">
                <div class="d-flex justify-content-between align-items-center mb-1">
                  <span class="fw-semibold">
                    {{ showAmount($pricePoints) }} <span class="text-muted">pts</span>
                  </span>
                  <small class="text-muted">{{ $percent }}%</small>
                </div>
                <div class="progress" style="height: 8px;">
                  <div class="progress-bar {{ $barClass }}" role="progressbar" style="width: {{ $percent }}%;" aria-valuenow="{{ $percent }}" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <div class="small mt-1 {{ $enough ? 'text-success' : 'text-muted' }}">{{ $progressLabel }}</div>
              </div>

              <div class="mt-auto">
                <div class="d-flex flex-wrap justify-content-end">
                  <form method="POST" action="{{ route('rewards.store', $item) }}" class="redeem-form">
                    @csrf
                    <input type="hidden" name="token" value="{{ $item->idempotency_token }}">
                    <button type="submit" class="btn btn--base">@lang('Redeem')</button>
                  </form>
                </div>

                <div class="small text-muted mt-2 d-sm-none">
                  @lang('Your points:') {{ showAmount($userCredits) }}
                </div>
              </div>
            </div>
          </div>
        </div>
      @empty
        <div class="col-12">
          <div class="alert alert-info text-center m-0">
            @lang('No items available.')
          </div>
        </div>
      @endforelse
    </div>

    {{-- Pagination --}}
    @if(method_exists($items,'hasPages') && $items->hasPages())
      <div class="mt-4 d-flex justify-content-center">
        {!! paginateLinks($items->withQueryString()) !!}
      </div>
    @endif

  </div>
</div>

{{-- CSS مضمّن --}}
<style>
  :root{ --sidebar-w:260px; --sidebar-w-min:84px; }
  @media (min-width: 992px){
    .content-with-sidebar{ margin-left: var(--sidebar-w); }
    .sidebar-collapsed .content-with-sidebar{ margin-left: var(--sidebar-w-min); }
  }
  .content-with-sidebar{ position:relative; z-index:1; }

  .points-pill{
    display:flex; align-items:center; gap:.75rem;
    background:#ffffff; color:#0d6efd; border:1px solid rgba(13,110,253,.2);
    border-radius: 999px; padding: .5rem .9rem .5rem .6rem;
    box-shadow: 0 6px 16px rgba(13,110,253,.12);
    min-width: 190px;
  }
  .points-pill .las{ font-size:1.25rem; }
  .points-label{ font-size:.75rem; line-height:1; opacity:.75; }
  .points-value{ font-weight:700; line-height:1.2; }

  .line-clamp-2{
    display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden;
  }

  .card{ transition: transform .12s ease, box-shadow .12s ease; }
  .card:hover{ transform: translateY(-2px); box-shadow: 0 10px 24px rgba(0,0,0,.08); }
</style>

{{-- JS مضمّن --}}
<script>
(function(){
  // سبينر ومنع تكرار النقر على زر Redeem
  document.querySelectorAll('.redeem-form').forEach(function(formEl){
    formEl.addEventListener('submit', function(){
      const btn = formEl.querySelector('button[type="submit"]');
      if (!btn) return;
      btn.disabled = true;
      btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1" role="status" aria-hidden="true"></span>{{ __('Redeem') }}';
    });
  });
})();
</script>
@endsection
