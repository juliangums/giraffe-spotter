import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/home/profile/GiraffeFavState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/providers/FavouriteProvider.dart';

class GiraffeFavCubit extends Cubit<GiraffeFavState> {
  final int initialValue;
  final FavouriteProvider favouriteProvider;
  bool backRefresh;
  String? errorMessage;
  GiraffeFavCubit({required this.initialValue,this.backRefresh = false,required this.favouriteProvider}) : super(GiraffeFavState(initialValue: initialValue));

  void addFavourite(String id) async
  {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult results = await  favouriteProvider.addFavourite(id);
    results.when(
        success: (_){
          backRefresh = true;
          emit(state.copyWith(status: FormzStatus.submissionSuccess,initialValue: 1));
        },
        failure: (error){
          error?.maybeWhen(unProcessableEntity: (Map<String, dynamic> e){
            errorMessage = e['message'];
            emit(state.copyWith(
                status: FormzStatus.submissionFailure,
                formErrors: (e['errors'] as Map).map((key, value) => MapEntry(key, (value as List).map((e) => e as String).toList()))));
          },unauthenticatedRequest: () {
            emit(state.copyWith(status: FormzStatus.submissionFailure));
            locator!<AppRoute>().navigateAndRemoveUntil(Login());
          },orElse: () {
            errorMessage = 'Error occurred while submitting your request. Please try again.';
            emit(state.copyWith(status: FormzStatus.submissionFailure));
          });
        });
  }

  void unFavourite(String id) async
  {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult results = await  favouriteProvider.unFavourite(id);
    results.when(
        success: (_){
          backRefresh = true;
          emit(state.copyWith(status: FormzStatus.submissionSuccess,initialValue: 0));
        },
        failure: (error){
          error?.maybeWhen(unProcessableEntity: (Map<String, dynamic> e){
            errorMessage = e['message'];
            emit(state.copyWith(
                status: FormzStatus.submissionFailure,
                formErrors: (e['errors'] as Map).map((key, value) => MapEntry(key, (value as List).map((e) => e as String).toList()))));
          },unauthenticatedRequest: (){
            emit(state.copyWith(status: FormzStatus.submissionFailure));
            locator!<AppRoute>().navigateAndRemoveUntil(Login());
          },orElse: () {
            errorMessage = 'Error occurred while submitting your request. Please try again.';
            emit(state.copyWith(status: FormzStatus.submissionFailure));
          });
        });
  }

  favourites() async
  {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult<List<GiraffeData>> results = await  favouriteProvider.favourites();
    results.when(
        success: (_) {
          List<GiraffeData> newData = [];
          _!.forEach((element) {
            if(newData.contains(element) == false) {
              newData.add(element);
            }
          });
          emit(state.copyWith(status: FormzStatus.submissionSuccess,initialValue: 1, favouritesGiraffes: newData));
        },
        failure: (error){
          error?.maybeWhen(unProcessableEntity: (Map<String, dynamic> e){
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


