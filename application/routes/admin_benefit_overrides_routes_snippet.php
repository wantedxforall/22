<?php
// Insert in routes/admin.php (or your admin routes file)
use App\Http\Controllers\Admin\BenefitOverrideController;

Route::prefix('benefit-overrides')->name('admin.benefit-overrides.')->group(function () {
    Route::get('/',           [BenefitOverrideController::class, 'index'])->name('index');
    Route::get('/create',     [BenefitOverrideController::class, 'create'])->name('create');
    Route::post('/',          [BenefitOverrideController::class, 'store'])->name('store');
    Route::get('/{id}/edit',  [BenefitOverrideController::class, 'edit'])->name('edit');
    Route::put('/{id}',       [BenefitOverrideController::class, 'update'])->name('update');
    Route::delete('/{id}',    [BenefitOverrideController::class, 'destroy'])->name('destroy');
});
