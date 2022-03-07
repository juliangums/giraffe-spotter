import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String? id, title, thumbnailUrl, channelTitle,publishedAt;
  const Video({this.channelTitle, this.id, this.thumbnailUrl, this.title, this.publishedAt});
  @override
  List get props => [id, title, channelTitle, thumbnailUrl,publishedAt];
  static Video fromMap(Map<dynamic, dynamic> json) {
    return Video(
      id: json['snippet']['resourceId']['videoId'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
      channelTitle: json['channelTitle'],
      publishedAt:json['snippet']['publishedAt']
    );
  }

  @override
  String toString() => '$runtimeType($title)';
}
