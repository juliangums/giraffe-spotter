import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/filterGiraffes/FilterState.dart';
import 'package:giraffe_spotter/models/FilterFile.dart';
import 'package:giraffe_spotter/models/Species.dart' as Spec;
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/providers/FilterProvider.dart';


class FilterCubit extends Cubit<FilterState> {
  FilterCubit(this.filterProvider) : super(FilterState());

  FilterProvider filterProvider =  FilterProvider();

  Future<void> getFilterData() async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    ApiResult<FilterFile> result = await filterProvider.getConfig();
    result.when(success: (_) {
      retrieveData(_);
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    });
  }

  retrieveData(FilterFile? filterFile)
  {
    List<Map<bool, Spec.Species>>? data = [];
    data.add({true: Spec.Species(name: 'Select All', value: 'Select All')});
    filterFile!.locationID!.map((e) {
      var name = e.name;
      var id = e.id;
      data.add({true: Spec.Species(name: name.toString(), value: id.toString())});
      if(e.locationID != null) {
          e.locationID!.map((e) {
            data.add({false : Spec.Species(name: e.name.toString(), value: e.id.toString())});
          }).toList();
      }
    }).toList();
    emit(state.copyWith(status: FormzStatus.submissionSuccess, filterFile: data));
  }
}
