@extends($activeTemplate.'layouts.master')
@php $pageTitle = __('My Reward Orders'); @endphp

@section('content')
<div class="body-wrapper">
    <div class="table-content">

        @if(session()->has('error'))
            <div class="alert alert--danger mb-3">{{ session('error') }}</div>
        @endif

        {{-- رأس الصفحة --}}
        <div class="row gy-3 align-items-stretch mb-3">
            <div class="col-lg-6">
                <div class="card b-radius--10 h-100">
                    <div class="card-body">
                        <h5 class="mb-1">{{ __('My Reward Orders') }}</h5>
                        <p class="text-muted mb-0">{{ __('Below is a list of your recent reward redemptions.') }}</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 d-flex">
                <a href="{{ route('rewards.index') }}"
                   class="btn btn--base w-100 d-flex align-items-center justify-content-center b-radius--10">
                    {{ __('Browse Rewards Store') }}
                </a>
            </div>
        </div>

        {{-- خريطة الحالات (تدعم رقم/نص) --}}
        @php
            use Illuminate\Contracts\Pagination\Paginator as Pagi;

            $statusMap = [
                // نصية
                'pending'   => ['label' => __('Pending'),   'class' => 'warning'],
                'approved'  => ['label' => __('Completed'), 'class' => 'success'], // نعرضها Completed
                'completed' => ['label' => __('Completed'), 'class' => 'success'],
                'rejected'  => ['label' => __('Rejected'),  'class' => 'danger'],
                'failed'    => ['label' => __('Failed'),    'class' => 'danger'],
                'cancelled' => ['label' => __('Cancelled'), 'class' => 'secondary'],
                'canceled'  => ['label' => __('Cancelled'), 'class' => 'secondary'],

                // رقمية (غالب/متعارف): 0=pending,1=approved,2=rejected,3=failed,4=cancelled
                0 => ['label' => __('Pending'),   'class' => 'warning'],
                1 => ['label' => __('Completed'), 'class' => 'success'],
                2 => ['label' => __('Rejected'),  'class' => 'danger'],
                3 => ['label' => __('Failed'),    'class' => 'danger'],
                4 => ['label' => __('Cancelled'), 'class' => 'secondary'],
            ];

            $normalize = function ($s) {
                if (is_numeric($s)) {
                    $n = (int) $s;
                    return [ $n, $n ]; // key, displayKey
                }
                $k = strtolower((string) $s);
                // وحّد 'canceled' إلى 'cancelled'
                if ($k === 'canceled') $k = 'cancelled';
                // اعتبر 'completed' = 'approved' إحصائياً
                $display = $k === 'completed' ? 'approved' : $k;
                return [ $k, $display ];
            };

            $items = ($orders instanceof Pagi) ? collect($orders->items()) : collect($orders);

            // احصاءات
            $stat = [
                'total'     => $items->count(),
                'approved'  => 0,
                'rejected'  => 0,
                'pending'   => 0,
                'failed'    => 0,
                'cancelled' => 0,
            ];

            foreach ($items as $o) {
                [$key, $display] = $normalize($o->status ?? null);
                if (in_array($display, ['approved','rejected','pending','failed','cancelled'], true)) {
                    $stat[$display]++;
                }
            }

            // بطاقة "Completed" تُساوي Approved
            $stat['completed'] = $stat['approved'];
        @endphp

        {{-- احصاءات سريعة --}}
        <div class="row gy-3 mb-3">
            <div class="col-6 col-md-4 col-lg">
                <div class="card b-radius--10 h-100">
                    <div class="card-body py-3">
                        <div class="text-muted small">{{ __('Total') }}</div>
                        <div class="fs-5 fw-semibold">{{ $stat['total'] }}</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg">
                <div class="card b-radius--10 h-100">
                    <div class="card-body py-3">
                        <div class="text-muted small">{{ __('Completed') }}</div>
                        <div class="fs-5 fw-semibold">{{ $stat['completed'] }}</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg">
                <div class="card b-radius--10 h-100">
                    <div class="card-body py-3">
                        <div class="text-muted small">{{ __('Approved') }}</div>
                        <div class="fs-5 fw-semibold">{{ $stat['approved'] }}</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg">
                <div class="card b-radius--10 h-100">
                    <div class="card-body py-3">
                        <div class="text-muted small">{{ __('Rejected') }}</div>
                        <div class="fs-5 fw-semibold">{{ $stat['rejected'] }}</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg">
                <div class="card b-radius--10 h-100">
                    <div class="card-body py-3">
                        <div class="text-muted small">{{ __('Pending') }}</div>
                        <div class="fs-5 fw-semibold">{{ $stat['pending'] }}</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg">
                <div class="card b-radius--10 h-100">
                    <div class="card-body py-3">
                        <div class="text-muted small">{{ __('Cancelled') }}</div>
                        <div class="fs-5 fw-semibold">{{ $stat['cancelled'] }}</div>
                    </div>
                </div>
            </div>
        </div>

        {{-- قائمة الطلبات --}}
        @forelse($orders as $order)
            @php
                $st        = $order->status ?? null;
                [$statusKey, $statusDisplayKey] = $normalize($st);
                $statusMeta = $statusMap[$statusKey] ?? $statusMap[$statusDisplayKey] ?? ['label'=>__('Unknown'),'class'=>'secondary'];

                $itemName  = optional($order->item)->name ?? '—';
                $points    = function_exists('showAmount') ? showAmount($order->price_points ?? 0) : ($order->price_points ?? 0);

                $adminNote = $order->admin_note;
                $hasNote   = filled($adminNote) && (is_string($adminNote) ? trim($adminNote) !== '' : true);

                $gift      = $order->gift ?? null;
                $hasGift   = filled($gift) && is_string($gift) && trim($gift) !== '';

                $createdAt = !empty($order->created_at)
                            ? (is_object($order->created_at) && method_exists($order->created_at,'format')
                                ? $order->created_at->format('Y-m-d H:i') : $order->created_at)
                            : null;

                $giftTrim  = is_string($gift) ? trim($gift) : $gift;
            @endphp

            <div class="card b-radius--10 mb-3">
                <div class="card-body">
                    <div class="d-flex flex-column flex-lg-row gap-3 align-items-start align-items-lg-center">

                        <div class="flex-grow-1">
                            <div class="fw-semibold fs-6 mb-1">{{ $itemName }}</div>

                            {{-- Admin Note تظهر فقط إن وُجدت --}}
                            @if($hasNote)
                                <div class="text-muted small mb-1">@lang('Admin Note'): {{ $adminNote }}</div>
                            @endif

                            {{-- Gift: النسخ يتم بالضغط على النص نفسه --}}
                            @if(in_array($statusDisplayKey, ['approved','completed'], true) && $hasGift)
                                <div class="mb-1">
                                    <div class="text-muted small mb-1">@lang('Gift')</div>
                                    <span class="gift-copy link--base text-primary fw-semibold text-break"
                                          style="cursor:pointer"
                                          title="@lang('Click to copy')"
                                          role="button" tabindex="0"
                                          data-copy="{{ $giftTrim }}">
                                        {{ $giftTrim }}
                                    </span>
                                </div>
                            @endif

                            @if($createdAt)
                                <div class="text-muted small">@lang('Created at'): {{ $createdAt }}</div>
                            @endif
                        </div>

                        <div class="ms-lg-3 text-lg-center">
                            <div class="fw-semibold">{{ $points }} {{ __('pts') }}</div>
                        </div>

                        <div class="ms-lg-3">
                            <span class="badge bg-{{ $statusMeta['class'] }}">
                                {{ $statusMeta['label'] }}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        @empty
            <div class="bg--section b-radius--10 p-4 text-center text-muted">
                {{ __('No orders yet.') }}
            </div>
        @endforelse

        @if(method_exists($orders,'links'))
            <div class="mt-3">
                {{ $orders->links() }}
            </div>
        @endif

    </div>
</div>
@endsection

@push('script')
<script>
(function () {
    function copyText(text, onDone) {
        if (!text) return;
        var done = function(){ if (typeof onDone === 'function') onDone(); };
        if (navigator.clipboard && window.isSecureContext) {
            navigator.clipboard.writeText(text).then(done).catch(fallback);
        } else { fallback(); }
        function fallback(){
            var t = document.createElement('textarea');
            t.value = text; document.body.appendChild(t); t.select();
            try { document.execCommand('copy'); } catch(e) {}
            document.body.removeChild(t); done();
        }
    }

    function handleCopy(el){
        var text = el.getAttribute('data-copy') || (el.textContent || '').trim();
        var originalText  = el.textContent;
        var originalClass = el.className;

        copyText(text, function(){
            el.classList.remove('text-primary');
            el.classList.add('text-success');

            el.textContent = '{{ __("Copied") }}';
            setTimeout(function(){
                el.textContent = originalText;
                el.className   = originalClass;
            }, 1200);
        });
    }

    document.addEventListener('click', function (e) {
        var el = e.target.closest('.gift-copy');
        if (!el) return;
        e.preventDefault();
        handleCopy(el);
    });

    document.addEventListener('keydown', function (e) {
        if (e.key !== 'Enter') return;
        var el = e.target.closest('.gift-copy');
        if (!el) return;
        e.preventDefault();
        handleCopy(el);
    });
})();
</script>
@endpush
