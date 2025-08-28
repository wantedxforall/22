<?php

use Illuminate\Support\Facades\Route;

Route::namespace('Api')->name('adminapi.')->group(function(){
    Route::post('add-payment', 'AdminApiController@addPayment')->name('add_payment');
    Route::post('users/{user}/points-spent', 'AdminApiController@setPointsSpentTotal')->name('users.points_spent_total');
});