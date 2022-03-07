import 'package:giraffe_spotter/models/YoutubeVideo.dart';
import 'package:giraffe_spotter/providers/YoutubeProvider.dart';

class YoutubeVideosRepository {
  Future<List<Video>> get youtubeVideos => YoutubeProvider().fetchChannel();
}
