import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/repositories/GiraffeProfileRepository.dart';

class GiraffeProfileCubit extends Cubit<GiraffeProfileState> {
  GiraffeProfileCubit({required this.repository}) : super(GiraffeInitialState()) {
    getGiraffes(true);
  }

  final GiraffeProfileRepository repository;
  String? errorMessage;
  late NetworkExceptions? failureReason;
  GiraffeData? singleData;
  bool backing = false;
  int page = 1;

  Future<void> getGiraffes(bool home) async {
    if (state is GiraffeLoadingState) return;
    final currentState = state;
    var oldPosts = <GiraffeData>[];
    if (currentState is GiraffeLoadedState) {
      oldPosts = currentState.giraffeProfiles!;
    }
    emit(GiraffeLoadingState(oldPosts, isFirstFetch: page == 1));
    ApiResult<List<GiraffeData>> result = await repository.getGiraffeProfiles(page: home == true ? 1 : page);
    result.when(success: (newResult) async {
      if (home == false) {
        final giraffeData = (state as GiraffeLoadingState).oldGiraffeProfile;
        giraffeData.addAll(newResult!);
        page++;
        emit(GiraffeLoadedState(giraffeProfiles: giraffeData));
      } else {
        page++;
        emit(GiraffeLoadedState(giraffeProfiles: newResult));
      }
    }, failure: (NetworkExceptions? error) {
      failureReason = error!;
      error.maybeWhen(
        unProcessableEntity: (Map<String, dynamic> errors) {
          errorMessage = errors['message'];
          emit(GiraffeErrorState(
              errors: (errors['errors'] as Map).map(
            (key, value) => MapEntry(key, (value as List).map<String>((e) => e).toList()),
          )));
        },
        unauthenticatedRequest: () {
          GiraffeErrorState(error: error);
          locator!<AppRoute>().navigateAndRemoveUntil(Login());
        },
        orElse: () {
          errorMessage = 'Error occurred while submitting your request. Please try again.';
          GiraffeErrorState(error: error);
        },
      );
    });
  }

  Future<void> updateGiraffes() async {
    ApiResult<List<GiraffeData>> result = await repository.getGiraffeProfiles(page: page);
    result.when(success: (newResult) {
      final giraffeData = (state as GiraffeLoadedState).giraffeProfiles;
      giraffeData!.addAll(newResult!);
      print(giraffeData.length);
      page++;
      emit(GiraffeLoadedState(giraffeProfiles: giraffeData));
    }, failure: (NetworkExceptions? error) {
      failureReason = error!;
      error.maybeWhen(
        unProcessableEntity: (Map<String, dynamic> errors) {
          errorMessage = errors['message'];
          emit(GiraffeErrorState(
              errors: (errors['errors'] as Map).map(
            (key, value) => MapEntry(key, (value as List).map<String>((e) => e).toList()),
          )));
        },
        orElse: () {
          errorMessage = 'Error occurred while submitting your request. Please try again.';
          GiraffeErrorState(error: error);
        },
      );
    });
  }

  Future<void> setFilterData(List<GiraffeData>? data) async {
    emit(GiraffeLoadedState(giraffeProfiles: data));
  }

  Future<void> singleGiraffeData(String id) async {
    ApiResult<GiraffeData> result = await repository.singleGiraffe(id: id);
    result.when(success: (_){
      singleData = _;
      emit(GiraffeLoadedState(singleData: _));
    }, failure:(error){
      failureReason = error!;
      error.maybeWhen(
        unProcessableEntity: (Map<String, dynamic> errors) {
          errorMessage = errors['message'];
          emit(GiraffeErrorState(
              errors: (errors['errors'] as Map).map(
                    (key, value) => MapEntry(key, (value as List).map<String>((e) => e).toList()),
              )));
        },
        orElse: () {
          errorMessage = 'Error occurred while submitting your request. Please try again.';
          GiraffeErrorState(error: error);
        },
      );
    });
  }
}
