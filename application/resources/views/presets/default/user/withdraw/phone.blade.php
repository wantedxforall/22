@extends($activeTemplate.'layouts.master')

@section('content')
<div class="body-wrapper">
    <div class="table-content">
        <div class="row gy-4">
            <div class="col-lg-6">
                <form action="{{ route('user.withdraw.store') }}" method="POST">
                    @csrf

                    <div class="mb-3">
                        <label for="phone" class="form-label">@lang('Phone')</label>
                        <input type="number" name="phone" id="phone" class="form-control" value="{{ old('phone') }}" placeholder="@lang('Enter phone number')" required>
                    </div>

                    <div class="mb-3">
                        <label for="credits" class="form-label">@lang('Credits')</label>
                        <input type="number" step="any" name="credits" id="credits" class="form-control" value="{{ old('credits') }}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">@lang('Exchange Rate')</label>
                        <div>{{ gs()->withdraw_rate_phone }}</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">@lang('Converted Amount')</label>
                        <div><span id="converted-amount">0</span></div>
                    </div>

                    <button type="submit" class="btn btn--base w-100">@lang('Request Withdraw')</button>
                </form>
            </div>
        </div>

        @include($activeTemplate.'user.withdraw.index')
    </div>
</div>
@endsection

@push('script')
<script>
(function () {
    const rate = parseFloat(@json(gs()->withdraw_rate_phone));
    const creditsInput = document.getElementById('credits');
    const convertedElement = document.getElementById('converted-amount');

    function updateConverted() {
        const credits = parseFloat(creditsInput.value) || 0;
        convertedElement.textContent = (credits * rate).toFixed(2);
    }

    creditsInput.addEventListener('input', updateConverted);
})();
</script>
@endpush