@extends($activeTemplate.'layouts.master')

@section('content')
<meta name="csrf-token" content="{{ csrf_token() }}"/>

<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-8">

      <form action="{{ route('user.deposit.insert') }}" method="post" id="depositForm">
        @csrf
        <input type="hidden" name="method_code">
        <input type="hidden" name="currency">
        <input type="hidden" id="inline_username" value="{{ auth()->user()->username ?? '' }}">

        <div class="body-area">

          <h5 class="mb-3">@lang('Deposit')</h5>

          {{-- اختيار البوابة --}}
          <div class="form-group mb-3">
            <label class="form--label">@lang('Select Gateway')</label>
            <select class="form-select select" name="gateway" required>
              <option value="">@lang('Select One')</option>
              @foreach($gatewayCurrency as $data)
                <option value="{{ $data->method_code }}"
                        @selected(old('gateway')==$data->method_code)
                        data-gateway="{{ $data }}">
                  {{ $data->name }}
                </option>
              @endforeach
            </select>
          </div>

          {{-- حقول الإيداع العادية (لغير ليبيانا/مدار) --}}
          <div id="classic-amount-group">
            <div class="form-group">
              <label class="form--label">@lang('Amount')</label>
              <div class="input-group">
                <input type="number" step="any" name="amount" class="form-control form--control"
                       value="{{ old('amount') }}" autocomplete="off" required>
                <span class="input-group-text">{{ $general->cur_text }}</span>
              </div>
            </div>

            <div class="mt-3 preview-details d-none">
              <span>@lang('Limit')</span>
              <span><span class="min fw-bold">0</span> {{ __($general->cur_text) }} - <span class="max fw-bold">0</span> {{ __($general->cur_text) }}, </span>
              <span>@lang('Charge')</span>
              <span><span class="charge fw-bold">0</span> {{ __($general->cur_text) }}, </span>
              <span>@lang('Payable')</span>
              <span><span class="payable fw-bold">0</span> {{ __($general->cur_text) }}</span>
            </div>
          </div>

          {{-- صندوق التحويل الفوري لليبيانا/مدار --}}
          <div id="mobile-inline-box" class="card mt-3 d-none">
  <div class="card-body">
    <div class="alert alert-info small mb-3">
      سيتم جلب <b>رقم التحويل</b> و<b>سعر الصرف</b> تلقائيًا. الرجاء التأكد من بياناتك قبل التأكيد.
    </div>

    <div class="row g-3">
      {{-- أرقام التحويل (قد تكون متعددة) --}}
      <div class="col-12">
        <label class="form-label">أرقام التحويل (المستلم)</label>
        <div id="numberList" class="list-group" style="max-height:180px; overflow:auto;">
          <div class="text-muted p-2" id="loadingNumbers">جاري جلب الأرقام...</div>
        </div>
        <div class="form-text">اختر رقمًا للتحويل إليه، ثم انسخه من الزر المجاور.</div>
      </div>

      {{-- صف 1: سعر الصرف + قيمة المزوّد (USD)  --}}
      <div class="col-md-6">
        <label class="form-label">سعر الصرف</label>
        <input type="text" class="form-control" id="exchange_rate" readonly value="جاري التحميل...">
        <div class="form-text">الصيغة: 1 USD = X LYD</div>
      </div>
      <div class="col-md-6">
        <label class="form-label">قيمة المزوّد (USD)</label>
        <input type="text" class="form-control" id="provider_amount" value="—" readonly>
        <div class="form-text">يُحسب تلقائيًا = (LYD ÷ سعر الصرف)</div>
      </div>

      {{-- صف 2: القيمة LYD + رقم هاتفك (مبادلة الأماكن) --}}
      <div class="col-md-6">
        <label class="form-label">القيمة (LYD)</label>
        <input type="number" step="0.01" min="0.01" class="form-control" id="user_amount" placeholder="0.00">
      </div>
      <div class="col-md-6">
        <label class="form-label">رقم هاتفك</label>
        <input type="text" class="form-control" id="user_phone" placeholder="ليبيانا: 92/94 — المدار: 218xxxxxxxxx">
        <div id="phone_hint" class="form-text"></div>
      </div>
    </div>

    <div class="d-grid mt-3 gap-2">
      <button type="button" id="btn-mobile-confirm" class="btn btn-success">
        تأكيد التحويل
      </button>
      <a href="{{ route('user.deposit.history') }}" class="btn btn-outline-secondary">
        عرض سجل الإيداعات
      </a>
    </div>

    <div id="mobile-inline-msg" class="mt-3"></div>
  </div>
</div>

          </div>

          {{-- زر الإرسال الكلاسيكي --}}
          <button type="submit" class="btn btn--base mt-3" id="classic-submit">@lang('Submit')</button>
        </div>
      </form>

    </div>
  </div>
</div>
@endsection

@push('style')
<style>
  #numberList .list-group-item { display:flex; align-items:center; justify-content:space-between; }
  .copy-btn { border:0; background:#f1f5f9; padding:.35rem .6rem; border-radius:.5rem; }
  .copy-btn:active { transform: scale(.98); }
</style>
@endpush

@push('script')
<script>
(function ($) {
  "use strict";

  const METHOD_LIBYANA = 115;
  const METHOD_ALMADAR = 116;

  const gatewaySelect = document.querySelector('select[name="gateway"]');
  const amountInput   = document.querySelector('input[name=amount]');
  const classicBox    = document.getElementById('classic-amount-group');
  const classicSubmit = document.getElementById('classic-submit');
  const inlineBox     = document.getElementById('mobile-inline-box');

  const numberList    = document.getElementById('numberList');
  const loadingNums   = document.getElementById('loadingNumbers');
  const rateEl        = document.getElementById('exchange_rate');
  const phoneInput    = document.getElementById('user_phone');
  const phoneHint     = document.getElementById('phone_hint');
  const userAmtInput  = document.getElementById('user_amount');
  const providerAmtEl = document.getElementById('provider_amount');
  const confirmBtn    = document.getElementById('btn-mobile-confirm');
  const msgBox        = document.getElementById('mobile-inline-msg');

  let currentRate = 0; // USD->LYD
  let currentProvider = null; // 'libyana' | 'almadar'

  function isInlineProvider(code) {
    code = Number(code || gatewaySelect?.value || 0);
    return code === METHOD_LIBYANA || code === METHOD_ALMADAR;
  }

  function providerNameFromCode(code) {
    code = Number(code);
    return (code === METHOD_LIBYANA) ? 'libyana'
         : (code === METHOD_ALMADAR) ? 'almadar'
         : null;
  }

  function toast(text, type='info') {
    msgBox.className = 'mt-3 alert alert-' + (type==='error' ? 'danger' : type);
    msgBox.innerHTML = text;
  }

  function updatePhoneHint() {
    if (currentProvider === 'libyana') {
      phoneHint.innerText = 'ليبيانا: يبدأ بـ 92 أو 94 ويتكون من 9 أرقام (مثال: 92xxxxxxx).';
      phoneInput.placeholder = 'مثال: 92xxxxxxx';
    } else if (currentProvider === 'almadar') {
      phoneHint.innerText = 'المدار: يبدأ بـ 218 ويتكون من 12 رقمًا (مثال: 21891xxxxxxx).';
      phoneInput.placeholder = 'مثال: 218xxxxxxxxx';
    } else {
      phoneHint.innerText = '';
      phoneInput.placeholder = '';
    }
  }

  function liveComputeProviderAmount() {
    const lyd = Number(userAmtInput.value || 0);
    if (currentRate > 0 && lyd > 0) {
      const usd = Math.round((lyd / currentRate) * 100) / 100;
      providerAmtEl.value = usd.toFixed(2);
    } else {
      providerAmtEl.value = '—';
    }
  }

  async function bootstrap(provider) {
    msgBox.innerHTML = '';
    numberList.innerHTML = '';
    loadingNums?.classList.remove('d-none');
    rateEl.value = 'جاري التحميل...';
    currentRate = 0;

    try {
      const res = await fetch(`/payment/bootstrap/${provider}`, {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
      });
      const data = await res.json();

      loadingNums?.classList.add('d-none');

      if (!data.ok) {
        numberList.innerHTML = `<div class="text-danger p-2">تعذر جلب البيانات من المزود.</div>`;
        rateEl.value = '—';
        return;
      }

      // أرقام التحويل: مصفوفة أو مفرد
      const phones = Array.isArray(data.dest_phone) ? data.dest_phone : (data.dest_phone ? [data.dest_phone] : []);
      if (phones.length === 0) {
        numberList.innerHTML = `<div class="text-warning p-2">لا يوجد رقم تحويل متاح حاليًا.</div>`;
      } else {
        phones.forEach((ph, idx) => {
          const id = 'dest_'+idx;
          const li = document.createElement('label');
          li.className = 'list-group-item';
          li.innerHTML = `
            <div class="form-check">
              <input class="form-check-input" type="radio" name="dest_phone_radio" id="${id}" value="${ph}" ${idx===0?'checked':''}>
              <span class="ms-2 fw-semibold">${ph}</span>
            </div>
            <button type="button" class="copy-btn" data-copy="${ph}">نسخ</button>
          `;
          numberList.appendChild(li);
        });
      }

      // سعر الصرف
      const rate = Number(data.rate || 0);
      currentRate = rate > 0 ? rate : 0;
      rateEl.value = currentRate ? `1 USD = ${currentRate} LYD` : '—';

      // تفعيل حساب فوري
      liveComputeProviderAmount();

      // أزرار النسخ
      numberList.addEventListener('click', (ev) => {
        const btn = ev.target.closest('.copy-btn');
        if (!btn) return;
        const val = btn.getAttribute('data-copy') || '';
        navigator.clipboard.writeText(val);
        btn.innerText = 'تم النسخ!';
        setTimeout(()=> btn.innerText='نسخ', 1200);
      }, { once:true });

    } catch (e) {
      loadingNums?.classList.add('d-none');
      numberList.innerHTML = `<div class="text-danger p-2">تعذر جلب البيانات من المزود.</div>`;
      rateEl.value = '—';
    }
  }

  function toggleInlineUI() {
    const code = Number(gatewaySelect?.value || 0);
    const inline = isInlineProvider(code);
    classicBox.style.display = inline ? 'none' : '';
    classicSubmit.style.display = inline ? 'none' : '';
    inlineBox.classList.toggle('d-none', !inline);

    if (inline) {
      currentProvider = providerNameFromCode(code);
      updatePhoneHint();
      bootstrap(currentProvider);
    } else {
      currentProvider = null;
    }
  }

  // امنع الإرسال الكلاسيكي للبوابتين
  document.getElementById('depositForm')?.addEventListener('submit', function (e) {
    if (isInlineProvider()) {
      e.preventDefault();
      toast('بالنسبة لليبيانا والمدار، استخدم زر "تأكيد التحويل" داخل الصندوق.', 'warning');
      return false;
    }
  });

  // أحداث تفاعلية
  gatewaySelect?.addEventListener('change', toggleInlineUI);
  userAmtInput?.addEventListener('input', liveComputeProviderAmount);

  // بدء
  toggleInlineUI();

  // حسابات وارسال
  function csrf() {
    return (document.querySelector('meta[name="csrf-token"]') || {}).content
        || (document.querySelector('input[name="_token"]') || {}).value
        || '';
  }

  function selectedDestPhone() {
    const sel = document.querySelector('input[name="dest_phone_radio"]:checked');
    return sel ? sel.value : '';
  }

  function phoneValid(provider, phone) {
    if (provider === 'libyana') {
      return /^(92|94)\d{7}$/.test(phone);
    }
    if (provider === 'almadar') {
      return /^218\d{9}$/.test(phone);
    }
    return false;
  }

  confirmBtn?.addEventListener('click', async function() {
    const provider = currentProvider;
    if (!provider) return toast('اختر بوابة صحيحة.', 'error');

    const phone  = (phoneInput.value || '').trim();
    const amount = Number(userAmtInput.value || 0);
    const dest   = selectedDestPhone();
    const uname  = (document.getElementById('inline_username')?.value || '').trim();

    if (!phoneValid(provider, phone)) {
      return toast('رقم الهاتف غير صالح لهذا المزود.', 'error');
    }
    if (!(amount > 0)) {
      return toast('أدخل قيمة صحيحة بالـ LYD.', 'error');
    }
    if (!dest) {
      return toast('اختر رقم التحويل (المستلم).', 'error');
    }
    if (!uname) {
      return toast('اسم المستخدم غير متوفر. الرجاء إعادة تسجيل الدخول.', 'error');
    }

    confirmBtn.disabled = true;
    toast('جارِ التأكيد...', 'info');

    try {
      const res = await fetch(`/payment/inline-confirm/${provider}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN': csrf()
        },
        body: JSON.stringify({
          user_phone:  phone,
          dest_phone:  dest,
          user_amount: amount,
          username:    uname
          // بإمكانك إرسال rate لو دالتك تتطلبه:
          // rate: currentRate
        })
      });

      const ct = res.headers.get('content-type') || '';
      if (!ct.includes('application/json')) {
        const text = await res.text();
        return toast('الرد غير متوقع من الخادم.<br><pre>'+text+'</pre>', 'error');
      }
      const data = await res.json();

      if (!res.ok || !data.ok) {
        return toast(data.message || 'فشل في التأكيد.', 'error');
      }

      // نجاح
      toast('✅ تمت المطابقة وتسجيل الإيداع بنجاح.', 'success');

      // تحديث القيم الظاهرة (اختياري)
      if (typeof data.amount_usd !== 'undefined') {
        providerAmtEl.value = Number(data.amount_usd).toFixed(2);
      }
    } catch (e) {
      toast('خطأ أثناء التأكيد: ' + e.message, 'error');
    } finally {
      confirmBtn.disabled = false;
    }
  });

  // المنطق القديم لحساب الرسوم/المعاينة للبوابات الأخرى (يبقى كما هو)
  $('select[name=gateway]').on('change', function () {
    if (!$('select[name=gateway]').val()) {
      $('.preview-details').addClass('d-none');
      return false;
    }
    const resource = $('select[name=gateway] option:selected').data('gateway');
    const fixed_charge   = parseFloat(resource.fixed_charge);
    const percent_charge = parseFloat(resource.percent_charge);
    const rate           = parseFloat(resource.rate);

    const toFixedDigit = resource.method.crypto == 1 ? 8 : 2;
    $('.crypto_currency').toggleClass('d-none', !(resource.method.crypto == 1));
    $('.min').text(parseFloat(resource.min_amount).toFixed(2));
    $('.max').text(parseFloat(resource.max_amount).toFixed(2));

    let amount = parseFloat($('input[name=amount]').val());
    if (!amount || amount <= 0 || isInlineProvider(resource.method_code)) {
      $('.preview-details').addClass('d-none');
    } else {
      $('.preview-details').removeClass('d-none');
      const charge   = parseFloat(fixed_charge + (amount * percent_charge / 100)).toFixed(2);
      const payable  = parseFloat((parseFloat(amount) + parseFloat(charge))).toFixed(2);
      const final_amo = (parseFloat(payable) * rate).toFixed(toFixedDigit);
      $('.charge').text(charge);
      $('.payable').text(payable);
      $('.final_amo').text(final_amo);
    }

    if (resource.currency != '{{ $general->cur_text }}') {
      const rateElement = `<span class="fw-bold">@lang('Conversion Rate')</span>
        <span><span class="fw-bold">1 {{__($general->cur_text)}} = <span class="rate">${rate}</span>
        <span class="base-currency">${resource.currency}</span></span></span>`;
      $('.rate-element').html(rateElement).removeClass('d-none d-flex').addClass('d-flex');
      $('.in-site-cur').removeClass('d-none d-flex').addClass('d-flex');
    } else {
      $('.rate-element').html('').addClass('d-none').removeClass('d-flex');
      $('.in-site-cur').addClass('d-none').removeClass('d-flex');
    }

    $('.base-currency').text(resource.currency);
    $('.method_currency').text(resource.currency);
    $('input[name=currency]').val(resource.currency);
    $('input[name=method_code]').val(resource.method_code);
    $('input[name=amount]').trigger('input');
  });

  $('input[name=amount]').on('input', function () {
    $('select[name=gateway]').change();
    $('.amount').text(parseFloat($(this).val() || 0).toFixed(2));
  });

})(jQuery);
</script>
@endpush
