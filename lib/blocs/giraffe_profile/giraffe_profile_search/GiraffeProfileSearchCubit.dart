import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/repositories/GiraffeProfileRepository.dart';

import 'GiraffeProfileSearchState.dart';

class GiraffeProfileSearchCubit extends Cubit<GiraffeProfileSearchState> {
  GiraffeProfileSearchCubit({this.keyword = '', this.dataItems}) : super(InitialSearchState()) {
    searchGiraffeProfile(dataItems, keyword);
  }

  List? dataItems, dataList;
  String? keyword;
  GiraffeProfileRepository? repository;
  String? errorMessage;
  late NetworkExceptions? failureReason;

  void searchGiraffeProfile(List? dataList, String? keyword) {
    try {
      if (dataList == null) {
        print("step 1");
        emit(InitialSearchState());
      } else {
        List finalList = [];
        emit(LoadingSearchState());
        dataList.forEach((element) {
          if (element['catalogNo'].toLowerCase().contains(keyword!.toLowerCase())) {
            finalList.add(element);
          }
        });
        print("the list is hapa " + finalList.toString());
        emit(LoadedSearchState(dataItems: finalList));
      }
    } catch (e) {
      emit(ErrorSearchState(error: e));
    }
  }

  //

}
