import 'package:equatable/equatable.dart';

abstract class GiraffeProfileSearchState extends Equatable {
  const GiraffeProfileSearchState();
}

class InitialSearchState extends GiraffeProfileSearchState {
  @override
  List<Object> get props => [];
}

class LoadingSearchState extends GiraffeProfileSearchState {
  @override
  List<Object> get props => [];
}

class ErrorSearchState extends GiraffeProfileSearchState {
  final error;
  final errors;

  ErrorSearchState({this.error, this.errors});

  @override
  get props => [errors, error];
}

class LoadedSearchState extends GiraffeProfileSearchState {
  final List dataItems;
  LoadedSearchState({required this.dataItems});
  @override
  List get props => [dataItems];
}
