import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/models/Species.dart';


class FilterState extends Equatable{

   FilterState({
    this.status = FormzStatus.pure,
     this.filterFile
  });

  final FormzStatus status;
  final List<Map<bool, Species>>? filterFile;

  @override
  List<Object?> get props => [status, filterFile];

  FilterState copyWith({FormzStatus? status, List<Map<bool, Species>>? filterFile}) =>
      FilterState(status: status ?? this.status, filterFile: filterFile);
}
