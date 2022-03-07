import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/inputs/authentication/Email.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';


part 'ForgotState.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit(this._authenticationRepository) : super(const ForgotState());

  final AuthenticationRepository _authenticationRepository;
  String? errorMessage;

  void emailChange(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email, status: Formz.validate([email])));
  }

  void validateEmail() {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(email: email));
  }

  void urlLink(Uri? link) {
    emit(state.copyWith(link: link));
  }

  void changePage(bool page) {
    emit(state.copyWith(page: page));
  }

  void sendMail(Uri? link,Email email,bool page) async {
    validateEmail();
    emit(state.copyWith(status: Formz.validate([state.email])));
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult result =  await _authenticationRepository.forgotPassword(email: state.email.value,link: link);
    result.when(success: (_) async {
      await SharedObjects.prefs!.setString(Constants.reset, _['token']);
      await SharedObjects.prefs!.setString(Constants.userEmail, email.toString());
      emit(state.copyWith(status: FormzStatus.submissionSuccess, page: page));
      }, failure: (error) {
        error!.maybeWhen(unProcessableEntity: (Map<String, dynamic> e) {
          emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              formErrors: (e['errors'] as Map).map((key, value) => MapEntry(key, (value as List).map((e) => e as String).toList()))));
        }, unauthenticatedRequest: () {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
          locator!<AppRoute>().navigateAndRemoveUntil(Login());
        }, orElse: () {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        });
        var rawError = NetworkExceptions.getErrorMessage(error);
        errorMessage = rawError;
      });
  }
}
