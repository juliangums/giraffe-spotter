import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/models/YoutubeVideo.dart';

import 'VideoSearchState.dart';

class VideoSearchCubit extends Cubit<VideoSearchState> {
  VideoSearchCubit({this.keyword = '', this.videoItems}) : super(InitialSearchState()) {
    searchVideo(videoItems, keyword);
  }

  List<Video>? videoItems, videoList;
  String? keyword;

  void searchVideo(List<Video>? videoList, String? keyword) {
    try {
      List<Video> finalList = [];
      emit(LoadingSearchState());

      videoList!.forEach((element) {
        if (element.title!.toLowerCase().contains(keyword!.toLowerCase())) {
          finalList.add(element);
        }
      });
      print(finalList);
      emit(LoadedSearchState(videoItems: finalList));

      // _finalList = videoItems!.where((element) => element.title.toLowerCase().contains(keyword.toLowerCase())).toList();

    } catch (e) {
      emit(ErrorSearchState(error: e));
    }
  }
}
