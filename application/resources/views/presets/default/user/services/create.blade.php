@extends($activeTemplate.'layouts.master')
@section('content')

<div class="body-wrapper">
    <div class="table-content">
        @include('includes.credits_alert')
        <div class="row justify-content-end mb-3">
            <div class="col-lg-4 col-md-8 col-12 text-end">
                <a class="btn btn--base btn--sm" href="{{route('user.service.index')}}"> <i class="fas fa-backward"></i>
                    @lang('Back') </a>
            </div>
        </div>
				
<label class="form--label d-flex justify-content-between align-items-center">
    <span>@lang('Credits') <span class="text-danger">*</span></span>
    <span class="badge bg-primary">@lang(' Credits  '): {{ number_format(auth()->user()->credits) }}</span>
</label>

        <div class="body-area">
            <div class="form-body">
                <form role="form" method="POST" action="{{route('user.service.store')}}" enctype="multipart/form-data">
                    @csrf

                    <div class="row gy-4">

                        <div class="form-group col-md-6 col-lg-6 col-xl-4">
                            <label class="form--label">@lang('Name') <span class="text-danger">*</span></label>
                            <input type="text" name="name" id="name" value="{{old('name')}}" class="form--control"
                                placeholder="@lang('Name')" required>
                        </div>

                        <div class="form-group col-md-6 col-lg-6 col-xl-4">
                            <label class="form--label">@lang('Category') <span class="text-danger">*</span></label>
                            <select class="form--control" name="category" id="categorySelect" required>
                                @foreach ($categories as $category)
                                <option value="{{$category->id}}" data-min="{{$category->min_points}}">{{__($category->name)}} @if($category->actor) ({{ $category->actor->name }}) @endif</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="form-group col-md-6 col-lg-6 col-xl-4">
                            <label class="form--label">@lang('Link') <span class="text-danger">*</span></label>
                            <input type="text" name="link" id="link" value="{{old('link')}}" class="form--control"
                                placeholder="@lang('Link')" required>
                        </div>

                        <div class="form-group col-md-6 col-lg-6 col-xl-4">
                            <label class="form--label">@lang('Credits') <span class="text-danger">*</span></label>
                            <input type="number" min="1" name="allocated_credits" id="allocatedCredits" value="{{ old('allocated_credits') }}" class="form--control" required>
                            <small id="minPointsMessage" class="text-muted d-block mb-1"></small>
							<small id="followersCalc" class="text-muted d-block"></small>

                            @error('allocated_credits')
                                <span class="text-danger">{{ $message }}</span>
                            @enderror
                        </div>

                        {{--<div class="form-group col-md-12">
                            <label class="form--label">@lang('Link') <span class="text-danger">*</span></label>
                            <textarea class="trumEdit" name="link_description" cols="30" rows="10"
                                placeholder="@lang('Enter your link description')"></textarea>
                        </div>--}}
                    </div>

                    <div class="form-group col-md-12 mt-3 text-end">
                        <button type="submit" class="btn btn--base">@lang('Create')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

@endsection

@push('script')
<script>
document.addEventListener('DOMContentLoaded', function () {
    const categorySelect = document.getElementById('categorySelect');
    const creditsInput   = document.getElementById('allocatedCredits');
    const minMsg         = document.getElementById('minPointsMessage');
    const calcMsg        = document.getElementById('followersCalc');

    // رصيد المستخدم الحالي من السيرفر (إجمالي الرصيد)
    const userCredits    = Number('{{ auth()->user()->credits ?? 0 }}') || 0;

    function getMin() {
        const opt = categorySelect?.selectedOptions?.[0];
        const min = Number(opt?.dataset?.min || 0);
        return (isFinite(min) && min > 0) ? min : 1;
    }

    function fmt(n) {
        try { return new Intl.NumberFormat().format(n); } catch(e) { return String(n); }
    }

    function recalc() {
        const min      = getMin();
        const perPoint = Number(creditsInput?.value || 0); // النقاط التي سيدخلها المستخدم في Credits
        // الحسبة المطلوبة: عدد المتابعين = رصيد المستخدم ÷ النقاط المُدخلة
        const followers = (perPoint > 0) ? Math.floor(userCredits / perPoint) : 0;

        if (minMsg) {
            // معلومة فقط: الحد الأدنى للنقاط لكل متابع حسب التصنيف
            minMsg.textContent = `{{ __('Minimum credits required per follower:') }} ${fmt(min)}`;
        }

        if (calcMsg) {
            calcMsg.textContent =
                `{{ __('Estimated followers') }}: ${fmt(followers)}`;
            // مثال توضيحي (اختياري): 100 ÷ 20 = 5
            // calcMsg.textContent += ` — {{ __('Example') }}: 100 ÷ 20 = 5`;
        }

        // تأكيد الحد الأدنى في الـ input (يواكب قواعد السيرفر)
        if (creditsInput) {
            creditsInput.min = Math.max(1, min);
        }
    }

    if (categorySelect) categorySelect.addEventListener('change', recalc);
    if (creditsInput)   creditsInput.addEventListener('input', recalc);

    recalc();
});
</script>
@endpush
