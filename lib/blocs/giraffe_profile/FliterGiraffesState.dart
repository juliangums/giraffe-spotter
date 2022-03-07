import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';

class FilterGiraffesState extends Equatable {
  FilterGiraffesState(
      {this.gender = '',
      this.ageStart = 1,
      this.ageEnd = 100,
      this.location = 'Select All',
      this.species = 'Select All',
      this.search = '',
      this.formErrors,
      this.filteredGiraffes,
      this.status = FormzStatus.pure,
      this.femaleStatus = false,
      this.unknownStatus = false,
      this.maleStatus = false});

  final String gender, location, species, search;
  final int ageStart;
  final int ageEnd;
  final Map<String, List<String>>? formErrors;
  final List<GiraffeData>? filteredGiraffes;
  final bool femaleStatus, maleStatus, unknownStatus;
  final FormzStatus status;

  @override
  List<Object?> get props =>
      [gender, ageStart, ageEnd, formErrors, location, filteredGiraffes, femaleStatus, species, maleStatus, search, status, unknownStatus];

  FilterGiraffesState copyWith({
    String? gender,
    RangeValues? age,
    int? ageStart,
    int? ageEnd,
    FormzStatus? status,
    String? search,
    Map<String, List<String>>? formErrors,
    String? species,
    String? location,
    List<GiraffeData>? filteredGiraffes,
    bool? femaleStatus,
    bool? maleStatus,
    bool? unknownStatus,
  }) =>
      FilterGiraffesState(
          gender: gender ?? this.gender,
          formErrors: formErrors,
          species: species ?? this.species,
          location: location ?? this.location,
          search: search ?? this.search,
          status: status ?? this.status,
          filteredGiraffes: filteredGiraffes,
          femaleStatus: femaleStatus ?? this.femaleStatus,
          ageEnd: ageEnd ?? this.ageEnd,
          ageStart: ageStart ?? this.ageStart,
          unknownStatus: unknownStatus ?? this.unknownStatus,
          maleStatus: maleStatus ?? this.maleStatus);
}
