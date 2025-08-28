@extends($activeTemplate.'layouts.master')
@section('content')
<div class="container py-4">
    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">@lang('rewards.available')</h5>
        </div>
        <div class="card-body">
            @if(count($items))
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>@lang('rewards.item') <span class="ms-2" role="button" data-bs-toggle="tooltip" title="@lang('rewards.sort')">&#8597;</span></th>
                            <th>@lang('rewards.points')</th>
                            <th>@lang('rewards.action')</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($items as $item)
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="{{ $item['image'] }}" loading="lazy" alt="{{ $item['name'] }}" class="me-2 rounded" width="40" height="40">
                                    {{ $item['name'] }}
                                </div>
                            </td>
                            <td>{{ $item['points'] }}</td>
                            <td>
                                <form method="POST" action="#">
                                    @csrf
                                    <button type="submit" class="btn btn-sm btn-primary redeem-btn" aria-label="@lang('rewards.redeem')" data-bs-toggle="tooltip" title="@lang('rewards.redeem')">
                                        <span class="spinner-border spinner-border-sm me-1 d-none" role="status" aria-hidden="true"></span>
                                        @lang('rewards.redeem')
                                    </button>
                                </form>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
            @else
            <div class="text-center text-muted py-5">
                <img src="{{ route('placeholder.image', '200x200') }}" loading="lazy" alt="@lang('rewards.no_items_image')" class="mb-3">
                <p>@lang('rewards.no_items')</p>
            </div>
            @endif
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">@lang('rewards.orders')</h5>
        </div>
        <div class="card-body">
            @if(count($orders))
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>@lang('rewards.order') <span class="ms-2" role="button" data-bs-toggle="tooltip" title="@lang('rewards.sort')">&#8597;</span></th>
                            <th>@lang('rewards.status')</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($orders as $order)
                        <tr>
                            <td>{{ $order['name'] }}</td>
                            <td>{{ $order['status'] }}</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
            @else
            <div class="text-center text-muted py-5">
                <img src="{{ route('placeholder.image', '200x200') }}" loading="lazy" alt="@lang('rewards.no_orders_image')" class="mb-3">
                <p>@lang('rewards.no_orders')</p>
            </div>
            @endif
        </div>
    </div>
</div>
@endsection

@push('script')
<script>
    document.addEventListener('DOMContentLoaded', function(){
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        document.querySelectorAll('.redeem-btn').forEach(function(btn){
            btn.addEventListener('click', function(){
                var spinner = this.querySelector('.spinner-border');
                spinner.classList.remove('d-none');
                this.setAttribute('disabled', true);
            });
        });
    });
</script>
@endpush