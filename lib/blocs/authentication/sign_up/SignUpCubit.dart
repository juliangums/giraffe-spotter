import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/inputs/authentication/AcceptTerms.dart';
import 'package:giraffe_spotter/inputs/authentication/Email.dart';
import 'package:giraffe_spotter/inputs/authentication/Name.dart';
import 'package:giraffe_spotter/inputs/authentication/Password.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

import 'SignUpState.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository)
      : emailError = null,
        passwordError = null,
        errorMessage = null,
        fullNameError = null,
        super(SignUpState());

  final AuthenticationRepository _authRepository;
  late String? errorMessage;
  late String? emailError;
  late String? passwordError;
  late String? fullNameError;
  late NetworkExceptions failureReason;

  void nameChanged(String value) {
    final fullName = Name.dirty(value);

    emit(state.copyWith(fullName: fullName, status: Formz.validate([state.email, fullName, state.password, state.acceptTerms])));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(state.copyWith(email: email, status: Formz.validate([email, state.fullName, state.password, state.acceptTerms])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(state.copyWith(password: password, status: Formz.validate([state.email, password, state.fullName, state.acceptTerms])));
  }

  void acceptTermsChanged(bool? value) {
    final acceptTerms = AcceptTerms.dirty(value ?? false);
    emit(state.copyWith(acceptTerms: acceptTerms, status: Formz.validate([state.email, state.password, state.fullName, acceptTerms])));
  }

  void validateBeforeSignUp() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final acceptTerms = AcceptTerms.dirty(state.acceptTerms.value);
    final fullName = Name.dirty(state.fullName.value);

    emit(state.copyWith(email: email, password: password, acceptTerms: acceptTerms, fullName: fullName));
  }

  Future<void> signUp() async {
    validateBeforeSignUp();
    emit(state.copyWith(status: Formz.validate([state.fullName, state.email, state.password, state.acceptTerms])));
    if (!state.status.isValidated) return;
    clearErrors();
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult<User> result = await _authRepository.signUp(
      fullName: state.fullName.value,
      email: state.email.value,
      acceptTerms: state.acceptTerms.value,
      password: state.password.value,
    );

    result.when(success: (User? user) async {
      await SharedObjects.prefs!.setString(Constants.accessToken, user!.token.toString());
      await SharedObjects.prefs!.setString(Constants.userEmail, user.email.toString());
      await SharedObjects.prefs!.setString(Constants.userImage, user.profile_image.toString());
      await SharedObjects.prefs!.setString(Constants.name, user.name.toString());
      await SharedObjects.prefs!.setString(Constants.userid, user.uuid.toString());
      await SharedObjects.prefs!.setBool(Constants.logged, true);
      Smartlook.setUserIdentifier(user.email.toString());
      emit(state.copyWith(status: FormzStatus.submissionSuccess, user: user));
    }, failure: (NetworkExceptions? error) {
      failureReason = error!;
      var rawError = NetworkExceptions.getErrorMessage(error);
      errorMessage = rawError;
      error.maybeWhen(
        unProcessableEntity: (Map<String, dynamic> errors) {
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

  void clearErrors() {
    emailError = null;
    passwordError = null;
  }
}
