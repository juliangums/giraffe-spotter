import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';

abstract class GiraffeProfileState extends Equatable {}

class GiraffeInitialState extends GiraffeProfileState {
  @override
  List<Object> get props => [];
}

class GiraffeLoadingState extends GiraffeProfileState {
  final List<GiraffeData> oldGiraffeProfile;
  final bool isFirstFetch;

  GiraffeLoadingState(this.oldGiraffeProfile, {this.isFirstFetch = false});

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GiraffeLoadedState extends GiraffeProfileState {
  final List<GiraffeData>? giraffeProfiles;
  final GiraffeData? singleData;

  GiraffeLoadedState({this.giraffeProfiles, this.singleData});

  @override
  List get props => [giraffeProfiles, singleData];
}

// ignore: must_be_immutable
class GiraffeErrorState extends GiraffeProfileState {
  final error;
  final errors;

  GiraffeErrorState({this.error, this.errors});

  @override
  get props => [errors, error];
}
