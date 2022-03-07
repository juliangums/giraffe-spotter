import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/models/YoutubeVideo.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';

abstract class VideoState extends Equatable {}

class InitialState extends VideoState {
  @override
  List<Object> get props => [];
}

class LoadingState extends VideoState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LoadedState extends VideoState {
  final List<Video> videos;
  LoadedState({required this.videos});
  @override
  List get props => [videos];
}

// ignore: must_be_immutable
class ErrorState extends VideoState {
  NetworkExceptions? error;
  ErrorState({this.error});
  @override
  List get props => [error];
}
