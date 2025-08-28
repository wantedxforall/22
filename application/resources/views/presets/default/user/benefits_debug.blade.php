@php
if(function_exists('auth') && auth()->check()){
    $activeBenefits = collect(\App\Support\LevelBenefits::getActive(auth()->user()))
        ->keyBy('type')
        ->map(fn($b) => $b['value'] ?? null);
} else {
    $activeBenefits = collect();
}
@endphp

@if(env('BENEFITS_DEBUG') && $activeBenefits->isNotEmpty())
<div class="dash-card p-3 my-3" style="background:#fcfcfc;border:1px dashed #ccc;">
  <strong>Benefits Debug</strong>
  <pre style="white-space:pre-wrap">{{ json_encode($activeBenefits, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) }}</pre>
</div>
@endif
