import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/inputs/authentication/Email.dart';
import 'package:giraffe_spotter/inputs/authentication/Password.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

part 'ResetState.dart';

class ResetCubit extends Cubit<ResetState> {
  ResetCubit(this._authenticationRepository) : super(ResetState());

  final AuthenticationRepository _authenticationRepository;
  String? errorMessage;

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(password: password, status: Formz.validate([state.password, password])));
  }

  void confirmPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(confirmPassword: password, status: Formz.validate([state.confirmPassword, password])));
  }

  void emailChanged(value) {
    print("this is the email :: "+ value.toString());
    final email = Email.dirty(value);
    emit(state.copyWith(email: email, status: Formz.validate([state.email, email])));
  }

  void validateBeforeSubmit() {
    final password = Password.dirty(state.password.value);
    final confirmPassword = Password.dirty(state.confirmPassword.value);

    emit(state.copyWith(confirmPassword: confirmPassword, password: password));
  }

  Future<void> reset() async {
    validateBeforeSubmit();
    emit(state.copyWith(status: Formz.validate([state.confirmPassword, state.password])));
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult result = await _authenticationRepository.resetPassword(token: SharedObjects.prefs!.getString(Constants.reset), password: state.password.value, confirmPassword: state.confirmPassword.value, email: state.email.value);
    result.when(success: (_) async{
      await SharedObjects.prefs!.setString(Constants.reset, '');
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
        }, failure: (_) {
          _?.maybeWhen(unProcessableEntity: (Map<String, dynamic> e) {
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
}
