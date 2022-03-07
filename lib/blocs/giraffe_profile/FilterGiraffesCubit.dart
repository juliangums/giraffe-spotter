import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/repositories/GiraffeProfileRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FliterGiraffesState.dart';

class FilterGiraffesCubit extends Cubit<FilterGiraffesState> {
  FilterGiraffesCubit(this.repository) : super(FilterGiraffesState());
  final GiraffeProfileRepository repository;
  String? errorMessage;
  late NetworkExceptions? failureReason;
  Map<String, dynamic> filterTempData = {};

  void onAgeChanged(ageStart, ageEnd) {
    emit(state.copyWith(ageEnd: ageEnd, ageStart: ageStart));
  }

  void onSpeciesChanged(String value) {
    final species = value;
    emit(state.copyWith(species: species));
  }

  void onLocationChanged(String value) {
    final location = value.trim();

    emit(state.copyWith(location: location));
  }

  void onSearchChanged(String value) {
    final search = value;
    emit(state.copyWith(search: search));
  }

  void onFemaleChanged(bool status) {
    emit(state.copyWith(
        gender: status ? 'f' : '',
        femaleStatus: status,
        maleStatus: false,
        unknownStatus: false));
  }

  void onMaleChanged(bool status) {
    emit(state.copyWith(
        gender: status ? 'm' : '',
        maleStatus: status,
        femaleStatus: false,
        unknownStatus: false));
  }

  void onUnknownChanged(bool status) {
    emit(state.copyWith(
        gender: status ? 'u' : '',
        unknownStatus: status,
        maleStatus: false,
        femaleStatus: false));
  }

  Future<void> filterGiraffes() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    tempStore(
        state.ageStart.toInt(),
        state.ageEnd.toInt(),
        state.location == 'Select All' ? 'Select All' : state.location,
        state.species == 'Select All' ? 'Select All' : state.species,
        state.gender);
    ApiResult<List<GiraffeData>> result = await repository.filteredGiraffes(
        ageStart: state.ageStart.toInt().toString(),
        ageEnd: state.ageEnd.toInt().toString(),
        species: state.species == 'Select All' ? '' : state.species,
        location: state.location == 'Select All' ? '' : state.location,
        gender: state.gender);
    result.when(success: (giraffes) {
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, filteredGiraffes: giraffes));
    }, failure: (NetworkExceptions? error) {
      error?.maybeWhen(
        unProcessableEntity: (Map<String, dynamic> errors) {
          errorMessage = errors['message'];
          emit(
            state.copyWith(
              status: FormzStatus.submissionFailure,
              formErrors: (errors['errors'] as Map).map(
                (key, value) => MapEntry(
                  key,
                  (value as List).map((e) => e as String).toList(),
                ),
              ),
            ),
          );
        },
        orElse: () {
          errorMessage =
              'Error occurred while submitting your request. Please try again.';
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        },
      );
    });
  }

  void filteredGiraffeResult(List<GiraffeData>? filteredResult) {
    emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        filteredGiraffes: filteredResult));
  }

  void returnDefault() async {
    clearStore();
    emit(state.copyWith(
        ageStart: 1,
        ageEnd: 100,
        location: 'Select All',
        species: 'Select All',
        unknownStatus: false,
        femaleStatus: false,
        maleStatus: false));
  }

  void refresh() async {
    emit(state.copyWith());
  }

  void tempStore(int ageStart, int ageEnd, String location, String species,
      String gender) async {
    await SharedObjects.prefs!.setInt(Constants.ageStart, ageStart);
    await SharedObjects.prefs!.setInt(Constants.ageEnd, ageEnd);
    await SharedObjects.prefs!.setString(Constants.location, location);
    await SharedObjects.prefs!.setString(Constants.species, species);
    await SharedObjects.prefs!.setString(Constants.gender, gender);

    filterTempData['ageStart'] = ageStart;
    filterTempData['ageEnd'] = ageEnd;
    filterTempData['location'] = location;
    filterTempData['species'] = species;
    filterTempData['gender'] = gender;
    print(filterTempData.toString());
  }

  void clearStore() {
    filterTempData.clear();
    print(filterTempData.toString());
  }

  void accesStore() async {
    print(filterTempData.toString());
    final String? location;
    final String? species;
    final String? gender;
    final int? ageStart;
    final int? ageEnd;

    location =  SharedObjects.prefs!.getString(Constants.location);
    species =  SharedObjects.prefs!.getString(Constants.species);
    gender =  SharedObjects.prefs!.getString(Constants.gender);
    ageEnd =  SharedObjects.prefs!.getInt(Constants.ageEnd);
    ageStart =  SharedObjects.prefs!.getInt(Constants.ageStart);

    print('location $location species $species gender $gender ageEnd $ageEnd ageStart $ageStart');
    emit(state.copyWith(gender: gender, species: species, location: location, ageEnd: ageEnd, ageStart: ageStart,maleStatus: gender == 'm'? true: false,femaleStatus: gender == 'f'? true: false,unknownStatus: gender == 'u'? true: false));
  }
}
