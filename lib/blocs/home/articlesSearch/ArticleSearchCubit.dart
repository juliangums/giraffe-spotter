import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/models/Item.dart';

part 'ArticleSearchState.dart';

class ArticleSearchCubit extends Cubit<ArticleSearchState> {
  List<Item> dataItems ;
  String searchText;

  ArticleSearchCubit({ required this.dataItems  ,this.searchText = ''}) : super(InitialSearchState()){
    retrieveTitle(dataItems, searchText);
  }

  //method to check letter || word in item.title
  void retrieveTitle(List<Item>? dataItems, String? searchText) {
    try {
      // Loading state ===> searching ...
      emit(LoadingSearchState());
      // empty list to add the Item data
      List<Item> finalList = [];
      if(dataItems !=null ){
          if(searchText == null){
            emit(InitialSearchState());}
          else{
            //check each title if it contains the letter || word
            dataItems.forEach((element) {
              //turned to lowercase  to find all
              if (element.title.t!.toLowerCase().contains(searchText.toLowerCase())){
                finalList.add(element);
              }});
            emit(LoadedSearchState(finalList));
          }
      }else if(searchText == null){
        emit(InitialSearchState());
      }
    } catch (e) {
      emit(ErrorSearchState());
    }
  }

}
