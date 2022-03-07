import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

part 'LogoutState.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._authenticationRepository) : super(LogoutState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> logout() async{
    emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
    ApiResult result =  await _authenticationRepository.logout();
    result.when(success: (_){
      emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
      SharedObjects.prefs!.clearSession();
      SharedObjects.prefs!.clearAll();
    }, failure: (error){
      error?.maybeWhen(unProcessableEntity: (Map<String, dynamic> e){
        emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
      },unauthenticatedRequest: (){
        emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
        locator!<AppRoute>().navigateAndRemoveUntil(Login());
      },orElse: () {
        emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
      });
    });
  }
}
