import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/videos/VideoState.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/repositories/YoutubeRepository.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(InitialState()) {
    getYoutubeVideos();
  }

  void getYoutubeVideos() async {
    try {
      emit(LoadingState());
      final youtubeVideos = await YoutubeVideosRepository().youtubeVideos;

      emit(LoadedState(videos: youtubeVideos));
    } catch (e) {
      emit(
        ErrorState(
          error: NetworkExceptions.getDioException(e),
        ),
      );
    }
  }
}
