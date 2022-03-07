import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/inputs/authentication/Email.dart';
import 'package:giraffe_spotter/inputs/authentication/Name.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/repositories/UpdateProfileRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.repository) : super(UpdateProfileState());
  final UpdateProfileRepository repository;
  String? errorMessage;
  late NetworkExceptions? failureReason;

  void nameChanged(String value, bool show) {
    final name = Name.dirty(value);
    emit(state.copyWith(fullName: name, show: show, status: Formz.validate([state.email, name])));
  }

  void emailChanged(String value, bool show) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email, show: show, status: Formz.validate([state.fullName, email])));
  }

  void validateBeforeUpdateProfile() {
    final email = Email.dirty(state.email.value);
    final name = Name.dirty(state.fullName.value);
    emit(state.copyWith(email: email, fullName: name));
  }

  Future<void> updateProfile() async {
    emit(state.copyWith(status: Formz.validate([state.fullName, state.email])));
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult<User> result = await repository.updateProfile(
      fullName: state.fullName.value,
      email: state.email.value,
    );

    result.when(success: (User? user) async {
      await SharedObjects.prefs!.setString(Constants.userEmail, user!.email.toString());
      await SharedObjects.prefs!.setString(Constants.name, user.name.toString());
      emit(state.copyWith(status: FormzStatus.submissionSuccess, user: user));
    }, failure: (NetworkExceptions? error) {
      failureReason = error!;
      error.maybeWhen(
        unProcessableEntity: (Map<String, dynamic> errors) {
          errorMessage = errors['message'];
          emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              error: error,
              errors: (errors['errors'] as Map).map((key, value) => MapEntry(key, (value as List).map<String>((e) => e).toList()))));
        },
        unauthenticatedRequest: () {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
          locator!<AppRoute>().navigateAndRemoveUntil(Login());
        },
        orElse: () {
          errorMessage = 'Error occurred while submitting your request. Please try again.';
          emit(state.copyWith(status: FormzStatus.submissionFailure, error: error));
        },
      );
    });
  }

  Future<void> deleteProfile(String uuid) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult result = await repository.deleteProfile(uuid: uuid);
    result.when(success: (_) async {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      await SharedObjects.prefs!.clearAll();
    }, failure: (NetworkExceptions? e) {
      e!.maybeWhen(
        unProcessableEntity: (Map<String, dynamic> errors) {
          errorMessage = errors['message'];
          emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              error: e,
              errors: (errors['errors'] as Map).map((key, value) => MapEntry(key, (value as List).map<String>((e) => e).toList()))));
        },
        unauthenticatedRequest: () {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
          locator!<AppRoute>().navigateAndRemoveUntil(Login());
        },
        orElse: () {
          debugPrint(e.toString());
          errorMessage = 'Error occurred while submitting your request. Please try again.';
          emit(state.copyWith(status: FormzStatus.submissionFailure, error: e));
        },
      );
    });
  }

  Future<void> updateImage(File image) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress, image: true));
    ApiResult result = await repository.updateImage(image: image);
    result.when(success: (user) async {
      await SharedObjects.prefs!.setString(Constants.userEmail, user!.email.toString());
      await SharedObjects.prefs!.setString(Constants.name, user.name.toString());
      await SharedObjects.prefs!.setString(Constants.userImage, user.profile_image.toString());
      Smartlook.setUserIdentifier(user.email.toString());
      emit(state.copyWith(status: FormzStatus.submissionSuccess, user: user, image: false));
    }, failure: (error) {
      error!.maybeWhen(
        unProcessableEntity: (Map<String, dynamic> errors) {
          errorMessage = errors['message'];
          emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              error: error,
              image: false,
              errors: (errors['errors'] as Map).map((key, value) => MapEntry(key, (value as List).map<String>((e) => e).toList()))));
        },
        orElse: () {
          debugPrint(error.toString());
          errorMessage = 'Error occurred while submitting your request. Please try again.';
          emit(state.copyWith(status: FormzStatus.submissionFailure, error: error, image: false));
        },
      );
    });
  }
}
