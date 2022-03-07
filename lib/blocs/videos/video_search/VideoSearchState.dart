import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/blocs/videos/video_search/VideoSearchCubit.dart';
import 'package:giraffe_spotter/models/YoutubeVideo.dart';

abstract class VideoSearchState extends Equatable {}

class InitialSearchState extends VideoSearchState {
  @override
  List<Object> get props => [];
}

class LoadingSearchState extends VideoSearchState {
  @override
  List<Object> get props => [];
}

class LoadedSearchState extends VideoSearchState {
  final List<Video> videoItems;
  LoadedSearchState({required this.videoItems});
  @override
  List get props => [videoItems];
}

// ignore: must_be_immutable
class ErrorSearchState extends VideoSearchState {
  ErrorSearchState({required error});
  String? error;
  @override
  List get props => [];
}
