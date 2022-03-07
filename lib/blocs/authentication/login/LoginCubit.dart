import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/login/LoginState.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/inputs/authentication/Email.dart';
import 'package:giraffe_spotter/inputs/authentication/Password.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());
  late NetworkExceptions? failureReason;
  String? errorMessage;
  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(password: password, status: Formz.validate([state.email, password])));
  }

  void validateBeforeSubmit() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(email: email, password: password));
  }

  Future<void> signIn() async {
    validateBeforeSubmit();
    emit(state.copyWith(status: Formz.validate([state.email, state.password])));
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult<User> result = await _authenticationRepository.login(email: state.email.value, password: state.password.value);
    result.when(success: (User? user) async {
      print(user);
      await SharedObjects.prefs!.setString(Constants.accessToken, user!.token.toString());
      await SharedObjects.prefs!.setString(Constants.userEmail, user.email.toString());
      await SharedObjects.prefs!.setString(Constants.userImage, user.profile_image.toString());
      await SharedObjects.prefs!.setString(Constants.name, user.name.toString());
      await SharedObjects.prefs!.setString(Constants.userid, user.uuid.toString());
      await SharedObjects.prefs!.setBool(Constants.logged, true);
      emit(state.copyWith(status: FormzStatus.submissionSuccess, user: user));
    }, failure: (NetworkExceptions? error) {
      var rawError = NetworkExceptions.getErrorMessage(error!);
      errorMessage = rawError;
      error.maybeWhen(unProcessableEntity: (Map<String, dynamic> e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            formErrors: (e['errors'] as Map).map((key, value) => MapEntry(key, (value as List).map((e) => e as String).toList()))));
      }, orElse: () {
        errorMessage = 'Error occurred while submitting your request. Please try again.';
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      });
    });
  }
}
