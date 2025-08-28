@extends($activeTemplate.'layouts.master')

@section('content')

@php
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

// ============= مزامنة user_levels =============
$user = auth()->user();

// عدد الإكمالات الفعلي
$actualCompleted = (int) DB::table('service_views')
    ->where('user_id', $user->id)
    ->count();

// مساعد لإيجاد المستوى المناسب للنقاط الحالية
$findLevel = function (int $points) {
    return \App\Models\Level::where('is_active', 1)
        ->where('min_points_spent', '<=', $points)
        ->orderBy('min_points_spent', 'desc')
        ->orderBy('priority', 'desc')
        ->first();
};

// صف المستخدم في user_levels
$ul = DB::table('user_levels')->where('user_id', $user->id)->first();

// إنشاء أولي عند عدم وجود صف
if (!$ul) {
    $curLvl = $findLevel($actualCompleted);
    DB::table('user_levels')->insert([
        'user_id'      => $user->id,
        'level_id'     => $curLvl?->id,
        'points_spent' => $actualCompleted,
        'achieved_at'  => $curLvl ? now() : null,
        'created_at'   => now(),
        'updated_at'   => now(),
    ]);
    $ul = DB::table('user_levels')->where('user_id', $user->id)->first();
}

// تحضير التحديثات المطلوبة
$updates = [];

// تحدّيث النقاط لو تغيّرت عن الواقع
if ((int) $ul->points_spent !== $actualCompleted) {
    $updates['points_spent'] = $actualCompleted;
}

// إعادة حساب المستوى بعد أي تغيير
$curLvl = $findLevel((int) ($updates['points_spent'] ?? $ul->points_spent));

// لو تغيّر المستوى (ترقية/تخفيض) → حدّث level_id و achieved_at
if (($curLvl?->id ?? null) !== ($ul->level_id ?? null)) {
    $updates['level_id']    = $curLvl?->id;
    $updates['achieved_at'] = $curLvl ? now() : null;
} else {
    // نفس المستوى؛ لكن قد يكون تم تعديل تعريفه أو achieved_at فارغ
    if ($curLvl) {
        $lvlUpdatedAt = $curLvl->updated_at ? \Carbon\Carbon::parse($curLvl->updated_at) : null;
        $achievedAt   = $ul->achieved_at ? \Carbon\Carbon::parse($ul->achieved_at) : null;

        // لو achieved_at فارغ، أو تعريف المستوى أحدث
        if (!$achievedAt || ($lvlUpdatedAt && $achievedAt < $lvlUpdatedAt)) {
            $updates['achieved_at'] = now();
        }
    }
}

// تنفيذ التحديثات إن وجدت
if (!empty($updates)) {
    $updates['updated_at'] = now();
    DB::table('user_levels')->where('user_id', $user->id)->update($updates);
    $ul = (object) array_merge((array) $ul, $updates);
}

// القراءة للعرض: Orders Complete من user_levels
$spent = (int) $ul->points_spent;

// المستوى الحالي + التالي
$currentLevel = \App\Models\Level::where('is_active', 1)
    ->where('min_points_spent', '<=', $spent)
    ->orderBy('min_points_spent', 'desc')
    ->orderBy('priority', 'desc')
    ->with(['benefits' => function ($q) { $q->where('is_active', 1); }])
    ->first();

$nextLevel = \App\Models\Level::where('is_active', 1)
    ->where('min_points_spent', '>', $spent)
    ->orderBy('min_points_spent', 'asc')
    ->orderBy('priority', 'desc')
    ->first();

// جميع المستويات للشارات
$levels = \App\Models\Level::where('is_active', 1)
    ->orderBy('min_points_spent', 'asc')
    ->orderBy('priority', 'desc')
    ->get();

// تقدّم المقطع
$from = (int) ($currentLevel->min_points_spent ?? 0);
$to   = $nextLevel->min_points_spent ?? null;

if (is_null($to) || $to <= $from) {
    $progress     = 100;
    $pointsToNext = 0;
    $segmentTotal = max(1, $spent - $from);
    $segmentNow   = $segmentTotal;
} else {
    $progress     = (int) round((($spent - $from) / max(1, $to - $from)) * 100);
    $progress     = max(0, min(100, $progress));
    $pointsToNext = max(0, $to - $spent);
    $segmentTotal = max(1, $to - $from);
    $segmentNow   = max(0, $spent - $from);
}

// ============= تجميع المزايا (مستوى + Overrides) =============
$benefits = [];
if ($currentLevel) {
    foreach ($currentLevel->benefits as $b) {
        $benefits[$b->type] = (float) $b->value;
    }
}

// دعم كلا الاسمين للعمود: type أو benefit_type
$overrideTypes = [];
$now = now();
if (Schema::hasTable('user_benefit_overrides')) {
    $typeCol = Schema::hasColumn('user_benefit_overrides', 'type')
        ? 'type'
        : (Schema::hasColumn('user_benefit_overrides', 'benefit_type') ? 'benefit_type' : null);

    if ($typeCol) {
        $ovrs = DB::table('user_benefit_overrides')
            ->where('user_id', $user->id)
            ->where('is_active', true)
            ->where(function ($q) use ($now) {
                $q->whereNull('starts_at')->orWhere('starts_at', '<=', $now);
            })
            ->where(function ($q) use ($now) {
                $q->whereNull('ends_at')->orWhere('ends_at', '>=', $now);
            })
            ->select([$typeCol . ' as type', 'value'])
            ->get();

        foreach ($ovrs as $ov) {
            // override يغلب قيمة المستوى لنفس النوع
            $benefits[$ov->type] = (float) $ov->value;
        }
        $overrideTypes = $ovrs->pluck('type')->toArray();
    }
}

// فورماتر
$fmtPct = function($v){ $vv = rtrim(rtrim(number_format((float)$v, 2), '0'), '.'); return $vv.(is_numeric($vv)?'%':''); };
$fmtNum = function($v){ return rtrim(rtrim(number_format((float)$v, 2), '0'), '.'); };

// قراءة القيم
$buyPointsDiscountPercent             = (float) Arr::get($benefits,'buy_points_discount_percent', 0);
$bonusPointsPercent                   = (float) Arr::get($benefits,'bonus_points_percent', 0);
$servicesDiscountPercent              = (float) Arr::get($benefits,'services_discount_percent', 0);
$withdrawFeeDiscountPercent           = (float) Arr::get($benefits,'withdraw_fee_discount_percent', 0);
$withdrawMinReductionFixed            = (float) Arr::get($benefits,'withdraw_min_reduction_fixed', 0);
$rewardMultiplier                     = (float) max(1, Arr::get($benefits,'reward_multiplier', 1));
$postCompletionBonusPoints            = (int)   Arr::get($benefits,'post_completion_bonus_points', 0);
$postCreationCostReductionPercent     = (float) Arr::get($benefits,'post_creation_cost_reduction_percent', 0);
$withdrawMinUsdtReductionFixed        = (float) Arr::get($benefits,'withdraw_min_usdt_reduction_fixed', 0);
$withdrawMinPhoneReductionFixed       = (float) Arr::get($benefits,'withdraw_min_phone_reduction_fixed', 0);

// حدود السحب الفعلية (عرض)
$baseMinPhone = (float) (optional(gs())->withdraw_min_phone ?? 0);
$baseMinUsdt  = (float) (optional(gs())->withdraw_min_usdt ?? 0);

$effMinPhone = max(0, $baseMinPhone - $withdrawMinPhoneReductionFixed - $withdrawMinReductionFixed);
$effMinUsdt  = max(0, $baseMinUsdt  - $withdrawMinUsdtReductionFixed  - $withdrawMinReductionFixed);

// تجهيز عناصر العرض + وسم الـ Admin grant
$benefitsDisplay = [];
$pushRow = function($type, $text) use (&$benefitsDisplay) {
    $benefitsDisplay[] = ['type' => $type, 'text' => $text];
};

if ($buyPointsDiscountPercent > 0)          $pushRow('buy_points_discount_percent',         __('Buy credits discount').': -'.$fmtPct($buyPointsDiscountPercent));
if ($bonusPointsPercent > 0)                $pushRow('bonus_points_percent',                 __('Bonus points on purchase').': +'.$fmtPct($bonusPointsPercent));
if ($servicesDiscountPercent > 0)           $pushRow('services_discount_percent',            __('Services discount').': -'.$fmtPct($servicesDiscountPercent));
if ($rewardMultiplier > 1)                  $pushRow('reward_multiplier',                    __('Reward multiplier').': x'.$fmtNum($rewardMultiplier));
if ($postCompletionBonusPoints > 0)         $pushRow('post_completion_bonus_points',         __('Post completion bonus points').': +'.$fmtNum($postCompletionBonusPoints));
if ($postCreationCostReductionPercent > 0)  $pushRow('post_creation_cost_reduction_percent', __('Post creation cost reduction').': -'.$fmtPct($postCreationCostReductionPercent));
if ($withdrawFeeDiscountPercent > 0)        $pushRow('withdraw_fee_discount_percent',        __('Withdraw fee discount').': -'.$fmtPct($withdrawFeeDiscountPercent));
if ($withdrawMinReductionFixed > 0)         $pushRow('withdraw_min_reduction_fixed',         __('Global withdraw min reduction').': -'.$fmtNum($withdrawMinReductionFixed));
if ($withdrawMinPhoneReductionFixed > 0)    $pushRow('withdraw_min_phone_reduction_fixed',   __('Phone withdraw min reduction').': -'.$fmtNum($withdrawMinPhoneReductionFixed).' → '.__('Effective min').': '.$fmtNum($effMinPhone));
if ($withdrawMinUsdtReductionFixed > 0)     $pushRow('withdraw_min_usdt_reduction_fixed',    __('USDT withdraw min reduction').': -'.$fmtNum($withdrawMinUsdtReductionFixed).' → '.__('Effective min').': '.$fmtNum($effMinUsdt));
@endphp


<div class="body-wrapper">
    <div class="table-content">

        {{-- بطاقات الإحصائيات --}}
        <div class="row gy-4 mb-4">
            @include('includes.credits_alert')

            <div class="col-xl-3 col-lg-4 col-md-4 col-12">
                <div class="dash-card">
                    <a href="javascript:void(0)" class="d-flex justify-content-between">
                        <div>
                            <div><p>@lang('Total Balance')</p></div>
                            <div class="content">
                                <span class="text-uppercase">{{$general->cur_sym}}{{showAmount(auth()->user()->balance)}}</span>
                            </div>
                        </div>
                        <div class="icon my-auto"><i class="fas fa-money-check-alt"></i></div>
                    </a>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-4 col-12">
                <div class="dash-card" data-widget-points-spent>
                    <div class="d-flex justify-content-between">
                        <div>
                            <div><p>@lang('Orders Complete')</p></div>
                            <div class="content">
                                {{-- الآن من user_levels.points_spent --}}
                                <span class="text-uppercase">{{ number_format($spent) }}</span>
                            </div>
                        </div>
                        <div class="icon my-auto"><i class="fa-solid fa-fire"></i></div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-4 col-12">
                <div class="dash-card">
                    <a href="{{route('user.plan')}}" class="d-flex justify-content-between">
                        <div>
                            <div><p>@lang('Total Credits')</p></div>
                            <div class="content">
                                <span class="text-uppercase">{{auth()->user()->credits}}</span>
                            </div>
                        </div>
                        <div class="icon my-auto"><i class="fa-regular fa-credit-card"></i></div>
                    </a>
                </div>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-4 col-12">
                <div class="dash-card">
                    <a href="{{route('user.service.index')}}" class="d-flex justify-content-between">
                        <div>
                            <div><p>@lang('Total Posts')</p></div>
                            <div class="content"><span class="text-uppercase">{{$widget['total_services']}}</span></div>
                        </div>
                        <div class="icon my-auto"><i class="fa-solid fa-newspaper"></i></div>
                    </a>
                </div>
            </div>
        </div>

        {{-- كرت تقدّم المستوى --}}
        <div class="row mb-4">
            <div class="col-lg-12">
                <div class="dash-card p-4">
                    <div class="d-flex align-items-center gap-4 flex-wrap">
                        <div id="level-progress" style="min-width:200px;width:200px;"></div>

                        <div class="flex-grow-1">
                            <h5 class="mb-1">@lang('Level Progress')</h5>

                            <div class="small text-muted mb-3">
                                @lang('Current'):
                                <strong>{{ $currentLevel->name ?? __('No level yet') }}</strong>
                                @if($nextLevel)
                                    &nbsp;•&nbsp; @lang('Next'):
                                    <strong>{{ $nextLevel->name }}</strong>
                                @else
                                    &nbsp;•&nbsp; <strong>@lang('Max level reached')</strong>
                                @endif
                            </div>

                            <div class="mt-2">
                                <div class="small text-muted mb-1">@lang('Active Level Benefits')</div>
                                @if(!empty($benefitsDisplay))
                                    <ul id="level-benefits-list" class="mb-0" style="list-style:disc;padding-{{app()->getLocale()=='ar'?'right':'left'}}:18px;">
                                        @foreach($benefitsDisplay as $row)
                                            <li>
                                                {!! $row['text'] !!}
                                                @if(in_array($row['type'], $overrideTypes))
                                                    <span class="badge badge--warning ms-1">@lang('Admin grant')</span>
                                                @endif
                                            </li>
                                        @endforeach
                                    </ul>
                                @else
                                    <div class="text-muted">@lang('No active benefits')</div>
                                @endif
                            </div>

                            <div class="d-flex flex-wrap gap-4 mt-3">
                                <div>
                                    <span class="text-muted d-block">@lang('Orders Complete')</span>
                                    <strong>{{ number_format($spent) }}</strong>
                                </div>
                                <div>
                                    <span class="text-muted d-block">@lang('This level segment')</span>
                                    <strong>{{ number_format($segmentNow) }} / {{ number_format($segmentTotal) }}</strong>
                                </div>
                                <div>
                                    <span class="text-muted d-block">@lang('To next level')</span>
                                    <strong>{{ number_format($pointsToNext) }}</strong>
                                </div>
                            </div>

                            @if($levels->count())
                                <div class="mt-3">
                                    @foreach($levels as $lvl)
                                        @php $achieved = $spent >= $lvl->min_points_spent; @endphp
                                        <span class="badge {{ $achieved ? 'badge--success' : 'badge--dark' }} me-1 mb-1">
                                            {{ $lvl->name }} ({{ $lvl->min_points_spent }})
                                        </span>
                                    @endforeach
                                </div>
                            @endif
                        </div>

                        @if(!empty($currentLevel?->badge))
                            <div class="ms-auto">
                                <img src="{{ $currentLevel->badge }}" alt="badge" style="height:64px;">
                            </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>

        {{-- مخطط الإيداعات الشهري --}}
        <div class="row mb-4">
            <div class="col-lg-12">
                <div class="chart">
                    <div class="chart-bg">
                        <h4>@lang('Monthly Deposits Reports')</h4>
                        <div id="account-chart"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
@endsection


@push('script')
<script src="{{ asset('assets/admin/js/apexcharts.min.js') }}"></script>
<script>
(function () {
  'use strict';

  // دائرة تقدّم المستوى
  var radial = new ApexCharts(document.querySelector("#level-progress"), {
    chart: { type: 'radialBar', height: 240 },
    series: [{{ $progress }}],
    plotOptions: {
      radialBar: {
        hollow: { size: '60%' },
        track: { background: '#f2f2f2', strokeWidth: '100%' },
        dataLabels: {
          showOn: 'always',
          value: {
            show: true,
            fontSize: '32px',
            fontWeight: 800,
            offsetY: -8,
            formatter: function (val) { return Math.round(val) + '%'; }
          },
          name: {
            show: true,
            fontSize: '12px',
            offsetY: 28,
            formatter: function () {
              return "{{ $currentLevel?->name ? __('Level').' '.$currentLevel->name : __('No level yet') }}";
            }
          }
        }
      }
    },
    stroke: { lineCap: 'round' },
    fill: {
      type: 'gradient',
      gradient: { shade: 'light', shadeIntensity: 0.3, type: 'horizontal', gradientToColors: ['#28c76f'], stops: [0, 100] }
    },
    colors: ['#7367f0']
  });
  radial.render();

  // مخطط الإيداعات الشهري
  var options = {
    chart: { type: 'area', stacked: false, height: '310px' },
    stroke: { width: [0, 3], curve: 'smooth' },
    plotOptions: { bar: { columnWidth: '50%' } },
    colors: ['#4430b5', '#ee6f11'],
    series: [{
      name: '@lang("Deposits")',
      type: 'column',
      data: @json($depositsChart['values'])
    }],
    fill: { opacity: [0.85, 1] },
    markers: { size: 0 },
    xaxis: { type: 'text' },
    yaxis: { min: 0 },
    tooltip: {
      shared: true,
      intersect: false,
      y: { formatter: function (y) { if (typeof y !== "undefined") { return "$ " + y.toFixed(0); } return y; } }
    },
    legend: {
      labels: { useSeriesColors: true },
      markers: { customHTML: [function(){return ''}, function(){return ''}] }
    }
  };

  var chart = new ApexCharts(document.querySelector("#account-chart"), options);
  chart.render();
})();
</script>
@endpush
