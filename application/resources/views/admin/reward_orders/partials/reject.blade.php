<div id="rejectModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">@lang('Reject Order')</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <i class="las la-times"></i>
                </button>
            </div>
            <form method="POST" action="#">
    @csrf
    @method('PUT')
    {{-- سيتم حقن action عبر السكربت كـ hidden --}}
    {{-- refund: 0 إذا لم يُحدد، 1 إذا حُدِّد --}}
    <input type="hidden" name="refund" value="0">

    <div class="form-check">
        <input class="form-check-input" type="checkbox" name="refund" value="1" id="refundCheck">
        <label class="form-check-label" for="refundCheck">@lang('Refund points to user')</label>
    </div>

    <div class="mt-3">
        <label class="form-label">@lang('Admin note')</label>
        <textarea name="notes" class="form-control" rows="3"></textarea>
    </div>

    <div class="mt-3 text-end">
        <button type="submit" class="btn btn--danger">@lang('Confirm')</button>
    </div>
</form>

        </div>
    </div>
</div>

@push('script')
<script>
(function($){
    "use strict";
    $('.rejectBtn').on('click', function(){
        var modal = $('#rejectModal');
        modal.find('form').attr('action', $(this).data('action'));
		modal.find('input[name=refund]').prop('checked', false);
        modal.find('textarea[name=notes]').val('');
        modal.modal('show');
    });
})(jQuery);
</script>
@endpush