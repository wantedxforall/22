@extends('admin.layouts.app')

@section('panel')
    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif
    @if(session('error'))
        <div class="alert alert-danger">{{ session('error') }}</div>
    @endif

    <div class="card-header p-3">
        <form method="GET" class="row g-2 align-items-end">
            <div class="col-md-2">
                <label class="form-label">@lang('Status')</label>
                <select name="status" class="form-select">
                    <option value="">@lang('All')</option>
                    <option value="pending" {{ request('status')=='pending'?'selected':'' }}>@lang('Pending')</option>
                    <option value="approved" {{ request('status')=='approved'?'selected':'' }}>@lang('Approved')</option>
                    <option value="rejected" {{ request('status')=='rejected'?'selected':'' }}>@lang('Rejected')</option>
                    <option value="cancelled" {{ request('status')=='cancelled'?'selected':'' }}>@lang('Cancelled')</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">@lang('Search')</label>
                <input type="text" name="q" value="{{ request('q') }}" class="form-control" placeholder="@lang('Search by user or reward')">
            </div>
            <div class="col-md-2 d-flex gap-2">
                <button class="btn btn--base" type="submit">@lang('Filter')</button>
                {{-- الراوت الصحيح بدون admin. --}}
                <a href="{{ route('admin.reward-orders.index') }}" class="btn btn--secondary">@lang('Reset')</a>
            </div>
        </form>
    </div>

    <div class="row gy-4">
        <div class="col-md-12">
            <div class="card b-radius--10">
                <div class="card-body p-0">
                    <div class="table-responsive--sm table-responsive">
                        <table class="table table--light style--two">
                            <thead>
                                <tr>
                                    <th>@lang('ID')</th>
                                    <th>@lang('User')</th>
                                    <th>@lang('Reward')</th>
                                    <th>@lang('Points')</th>
                                    <th>@lang('Status')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($orders as $order)
                                    <tr>
                                        <td>{{ $order->id }}</td>
                                        <td>{{ optional($order->user)->fullname ?? '—' }}</td>
                                        <td>{{ $order->item->name ?? '—' }}</td>
                                        <td>{{ showAmount($order->price_points ?? 0) }}</td>
                                        <td>
    @if($order->status === \App\Models\RewardOrder::STATUS_APPROVED)
        <span class="badge badge--success">@lang('Approved')</span>
    @elseif($order->status === \App\Models\RewardOrder::STATUS_REJECTED)
        <span class="badge badge--danger">@lang('Rejected')</span>
    @elseif($order->status === \App\Models\RewardOrder::STATUS_CANCELLED)
        <span class="badge badge--warning">@lang('Cancelled')</span>
    @else
        <span class="badge badge--warning">@lang('Pending')</span>
    @endif
</td>

                                        <td>
                                            @if($order->status === \App\Models\RewardOrder::STATUS_PENDING)
  <button class="btn btn-sm btn--success approveBtn"
          type="button"
          data-action="{{ route('admin.reward-orders.update', $order) }}">
      @lang('Approve')
  </button>

  <button class="btn btn-sm btn--danger rejectBtn"
          type="button"
          data-action="{{ route('admin.reward-orders.update', $order) }}">
      @lang('Reject')
  </button>

  <button class="btn btn-sm btn--warning cancelBtn"
          type="button"
          data-action="{{ route('admin.reward-orders.update', $order) }}">
      @lang('Cancel')
  </button>
@else
  <span class="text-muted">—</span>
@endif

                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td class="text-muted text-center" colspan="6">{{ __($emptyMessage ?? 'No data found') }}</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
                @if(method_exists($orders,'hasPages') && $orders->hasPages())
                    <div class="card-footer py-4">
                        @php echo paginateLinks($orders) @endphp
                    </div>
                @endif
            </div>
        </div>
    </div>

    @include('admin.reward_orders.partials.approve')
    @include('admin.reward_orders.partials.reject')
    @include('admin.reward_orders.partials.cancel')
@endsection

@push('script')
<script>
document.addEventListener('DOMContentLoaded', function () {
    const wireModal = (btnSelector, modalSelector, actionValue) => {
        document.querySelectorAll(btnSelector).forEach(btn => {
            btn.addEventListener('click', () => {
                const actionUrl = btn.getAttribute('data-action');
                const modal = document.querySelector(modalSelector);
                if (!modal) return;

                const form = modal.querySelector('form');
                if (!form) return;

                form.setAttribute('action', actionUrl);

                // hidden _method=PUT إن لزم
                let methodInput = form.querySelector('input[name="_method"]');
                if (!methodInput) {
                    methodInput = document.createElement('input');
                    methodInput.type = 'hidden';
                    methodInput.name = '_method';
                    methodInput.value = 'PUT';
                    form.appendChild(methodInput);
                }

                // hidden action
                let actionInput = form.querySelector('input[name="action"]');
                if (!actionInput) {
                    actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    form.appendChild(actionInput);
                }
                actionInput.value = actionValue;

                // افتح المودال
                if (typeof bootstrap !== 'undefined') {
                    bootstrap.Modal.getOrCreateInstance(modal).show();
                } else {
                    modal.style.display = 'block';
                }
            });
        });
    };

    wireModal('.approveBtn', '#approveModal', 'approve');
    wireModal('.rejectBtn',  '#rejectModal',  'reject');
    wireModal('.cancelBtn',  '#cancelModal',  'cancel');
});
</script>
@endpush

