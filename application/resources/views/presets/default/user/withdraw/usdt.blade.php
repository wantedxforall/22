@extends($activeTemplate.'layouts.master')

@section('content')
<div class="body-wrapper">
    <div class="table-content">
        <div class="row gy-4">
            <div class="col-lg-6">
                <form action="{{ route('user.withdraw.store') }}" method="POST">
                    @csrf
                    <input type="hidden" name="method" value="usdt">

                    <div class="mb-3">
                        <label for="binance_id" class="form-label">@lang('Binance ID')</label>
                        <input type="text" name="binance_id" id="binance_id" class="form-control"
                               value="{{ old('binance_id') }}" placeholder="@lang('Enter your Binance ID')" required>
                    </div>

                    <div class="mb-3">
                        <label for="credits" class="form-label">@lang('Credits')</label>
                        <input
                            type="number"
                            name="credits"
                            id="credits"
                            class="form-control"
                            step="0.01"
                            min="{{ number_format((float)($minUsdtCredits ?? 0), 2, '.', '') }}" {{-- الحد الأدنى بالنقاط --}}
                            required
                        >
                        <small class="text-muted d-block mt-1">
                            @lang('Minimum credits'):
                            {{ number_format((float)($minUsdtCredits ?? 0), 2, '.', '') }}
                        </small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">@lang('Exchange Rate')</label>
                        {{-- rate = نقاط لكل 1 عملة --}}
                        <div id="exchange-rate" data-rate="{{ (float)($rateUsdt ?? (gs()->withdraw_rate_usdt ?? gs()->withdraw_rate ?? 1)) }}">
                            {{ (float)($rateUsdt ?? (gs()->withdraw_rate_usdt ?? gs()->withdraw_rate ?? 1)) }}
                        </div>
                        <small class="text-muted">
                            @lang('This rate is points per 1 unit of currency')
                        </small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">@lang('Converted Amount (balance)')</label>
                        <div><span id="converted-amount">0.00</span></div>
                        <small class="text-muted">
                            @lang('Calculated as Credits ÷ Rate')
                        </small>
                    </div>

                    <div class="alert alert-info">
                        @lang('Minimum Withdraw - USDT (balance)'):
                        <strong>{{ number_format((float)($minUsdtBalance ?? 0), 2, '.', '') }}</strong>
                    </div>

                    <button type="submit" class="btn btn--base w-100">@lang('Request Withdraw')</button>
                </form>
            </div>
        </div>

        @includeWhen(isset($withdraws), $activeTemplate.'user.withdraw.index', ['withdraws' => $withdraws])
    </div>
</div>
@endsection

@push('script')
<script>
(function () {
    // rate = points per 1 currency
    var rateAttr = document.getElementById('exchange-rate')?.getAttribute('data-rate');
    var rate = parseFloat(rateAttr);
    if (!isNaN(rate) && rate <= 0) rate = NaN; // منع قسمة على صفر
    if (isNaN(rate)) rate = 1;

    var creditsInput = document.getElementById('credits');
    var convertedElement = document.getElementById('converted-amount');
    if (!creditsInput || !convertedElement) return;

    function updateConverted() {
        var credits = parseFloat(creditsInput.value);
        if (isNaN(credits) || credits < 0) credits = 0;

        // balance = credits ÷ rate
        var converted = rate > 0 ? (credits / rate) : 0;
        convertedElement.textContent = converted.toFixed(2);
    }

    updateConverted();
    creditsInput.addEventListener('input', updateConverted);
})();
</script>
@endpush
