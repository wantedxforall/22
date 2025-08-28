@extends('admin.layouts.app')
@section('panel')
<div class="row mb-none-30">
    <div class="col-lg-12 mb-30">
        <div class="card">
            <div class="card-body">
                <form action="{{ route('admin.level.reward.store',$level->id) }}" method="POST">
                    @csrf
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label for="reward" class="font-weight-bold">@lang('Reward')</label>
                                <input type="text" name="reward" id="reward" class="form-control" value="{{ $level->reward }}" required>
                            </div>
                        </div>
                    </div>
                    <div class="row text-end">
                        <div class="col-lg-12">
                            <button type="submit" class="btn btn--primary btn-block btn-lg">@lang('Assign')</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection

@push('breadcrumb-plugins')
<a href="{{ route('admin.level.index') }}" class="btn btn-sm btn--primary box--shadow1 text--small"><i class="las la-angle-double-left"></i>@lang('Go Back')</a>
@endpush