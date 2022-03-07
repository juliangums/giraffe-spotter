import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/providers/CaptureProvider.dart';

part 'CaptureState.dart';

class CaptureCubit extends Cubit<CaptureState> {
  CaptureCubit(this._captureProvider) : super(CaptureState());
  final CaptureProvider _captureProvider;
  String? errorMessage;
  double? latitude;
  double? longitude;

  void locationChanged(String? value, double? longitude, double? latitude) {
    var parts = value!.split(',');
    String? location = parts[0];
    String? country = parts.last;
    emit(state.copyWith(location: location, longitude: longitude, latitude: latitude, country: country.isNotEmpty ? country : location));
  }

  void dateTimeChanged(DateTime? dateTime, TimeOfDay? timeOfDays) {
    emit(state.copyWith(dateTime: DateTime(dateTime!.year, dateTime.month, dateTime.hour, timeOfDays!.hour, timeOfDays.minute).toString()));
  }

  Future<void> captureData(String? uuid, List<File> images) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult result = await _captureProvider.captureData(
        dateTime: state.dateTime,
        country: state.country,
        location: state.location,
        longitude: state.longitude,
        latitude: state.latitude,
        images: images);
    result.when(success: (_) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }, failure: (error) {
      error?.maybeWhen(unProcessableEntity: (Map<String, dynamic> e) {
        errorMessage = e['message'];
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            formErrors: (e['errors'] as Map).map((key, value) => MapEntry(key, (value as List).map((e) => e as String).toList()))));
      }, unauthenticatedRequest: () {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        locator!<AppRoute>().navigateAndRemoveUntil(Login());
      }, orElse: () {
        errorMessage = 'Error occurred while submitting your request. Please try again.';
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      });
    });
  }

  //Todo:: use this to send image to backend to fetch latlng
  // Future<void> checkLocation(File image) async {
  //   ApiResult<LatLngModel> result = await _captureProvider.checkLocation(image: image);
  //   result.when(success: (_) async {
  //     latitude = _!.latitude;
  //     longitude = _.longitude;
  //   }, failure: (error) {
  //   });
  // }
}
