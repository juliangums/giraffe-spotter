import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/models/GiraffeProfile.dart';

class GiraffeFavState  extends Equatable{


  final int? initialValue;
  final FormzStatus status;
  bool favRefresh;
  final List<GiraffeData>? favouritesGiraffes;
  final Map<String, List<String>>? formErrors;

  GiraffeFavState({
    this.formErrors,
    this.favRefresh = false,
    this.favouritesGiraffes,
    this.initialValue,
    this.status = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [formErrors,favouritesGiraffes,initialValue,status];

  GiraffeFavState copyWith({List<GiraffeData>? favouritesGiraffes, int? initialValue,FormzStatus? status,Map<String, List<String>>? formErrors, bool? favRefresh }) => GiraffeFavState
    (initialValue: initialValue , status: status?? this.status,formErrors: formErrors, favRefresh: favRefresh ?? this.favRefresh, favouritesGiraffes :favouritesGiraffes);

}