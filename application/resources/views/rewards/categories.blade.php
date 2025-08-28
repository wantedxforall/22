@extends($activeTemplate.'layouts.master')
@php 
  $pageTitle = __('Rewards Store');
@endphp

@section('content')
<style>
  /* اضبط قيم عرض السايدبار حسب قالبك */
  :root{
    --sidebar-width: 260px;     /* السايدبار العادي */
    --sidebar-collapsed: 72px;  /* السايدبار المصغّر */
  }

  /* حاوية الصفحة */
  .page-shell{
    margin: 0 auto;
    max-width: 1280px;
    padding: 16px;
  }

  /* الإزاحة التلقائية حسب حالة السايدبار على الشاشات الكبيرة */
  @media (min-width: 992px){
    .page-shell{
      padding-left: var(--sidebar-width);
    }
    /* إذا كان السايدبار مصغّر: أضف class على body أو html */
    body.sidebar-collapsed .page-shell,
    html.sidebar-collapsed .page-shell{
      padding-left: var(--sidebar-collapsed);
    }
  }

  /* بطاقات متناسقة وصور بنسبة 16:9 */
  .card{ border: 0; box-shadow: 0 4px 12px rgba(0,0,0,.05); border-radius: 12px; overflow: hidden; }
  .card .ratio img{ width:100%; height:100%; object-fit:cover; display:block; }
</style>

<div class="page-shell">
  <div class="container-fluid p-0">
    <h5 class="mb-3">@lang('Reward Categories')</h5>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-3">
      @forelse($categories as $cat)
        @php
          // رابط الصورة عبر الراوت المخصص /reward_categories
          $file = $cat->image ? ltrim(str_replace('reward_categories/', '', $cat->image), '/') : null;
          $imgUrl = $file ? url('/reward_categories/'.$file) : null;
          $fallback = asset('assets/images/placeholder-16x9.png'); // ضع صورة افتراضية 16:9 هنا
        @endphp

        <div class="col">
          <!-- لفّ البطاقة بالرابط لتفادي أي تداخل مع السايدبار -->
          <a href="{{ route('rewards.category', $cat->slug) }}" class="text-decoration-none d-block h-100">
            <div class="card h-100 d-flex flex-column">
              <div class="ratio ratio-16x9 bg-light">
                @if($imgUrl)
                  <img 
                    src="{{ $imgUrl }}"
                    alt="{{ $cat->name }}"
                    loading="lazy"
                    decoding="async"
                    onerror="this.onerror=null;this.src='{{ $fallback }}';"
                  >
                @else
                  <img 
                    src="{{ $fallback }}"
                    alt="{{ $cat->name }}"
                    loading="lazy"
                    decoding="async"
                    style="opacity:.7"
                  >
                @endif
              </div>

              <div class="card-body d-flex flex-column">
                <h6 class="mb-1 text-truncate">{{ $cat->name }}</h6>
                <p class="text-muted small mb-0">{{ $cat->items_count }} @lang('items')</p>
              </div>
            </div>
          </a>
        </div>
      @empty
        <div class="col-12 text-center text-muted">@lang('No categories yet')</div>
      @endforelse
    </div>
  </div>
</div>
@endsection
