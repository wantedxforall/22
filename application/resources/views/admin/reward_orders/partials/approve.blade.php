<div id="approveModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">@lang('Approve Order')</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <i class="las la-times"></i>
                </button>
            </div>

            <form action="" method="POST">
                @csrf
                @method('PUT')
                <input type="hidden" name="action" value="approve">

                <div class="modal-body">
                    <p class="mb-3">@lang('Are you sure to approve this order?')</p>

                    {{-- الهدية التي سيرسلها الأدمن للمستخدم --}}
                    <div class="mb-3">
                        <label class="form-label">@lang('Gift')</label>
                        <input type="text"
                               name="gift"
                               class="form-control"
                               required
                               placeholder="@lang('Gift code / link / note')">
                    </div>

                    {{-- ملاحظات إدارية اختيارية --}}
                    <div class="mt-3">
                        <textarea name="notes" class="form-control" placeholder="@lang('Notes')"></textarea>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn--dark" data-bs-dismiss="modal">@lang('No')</button>
                    <button type="submit" class="btn btn--primary">@lang('Yes')</button>
                </div>
            </form>
        </div>
    </div>
</div>

@push('script')
<script>
(function($){
    "use strict";
    $('.approveBtn').on('click', function(){
        var modal = $('#approveModal');
        modal.find('form').attr('action', $(this).data('action'));
        modal.find('input[name="gift"]').val('');   // تفريغ الهدية
        modal.find('textarea[name="notes"]').val('');
        modal.modal('show');
    });
})(jQuery);
</script>
@endpush