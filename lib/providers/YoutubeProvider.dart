import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/YoutubeVideo.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';

class YoutubeProvider {
  Future<List<Video>> fetchChannel() async {
    try {
      final response = await locator!<NetworkClient>().youtubeChannel.get(
        '/youtube/v3/channels',
        queryParameters: {'part': 'contentDetails', 'id': 'UCqGc3ZMF079yv4PXVWDkBXQ', 'key': 'AIzaSyAgCnr6L56hWCSao8l8gZyuLFsz90oA_4k'},
      );
      final uploadPlayListId = response['items'][0]['contentDetails']['relatedPlaylists']['uploads'];

      final allVideos = await fetchVideos(uploadPlayListId);
      return allVideos;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Video>> fetchVideos(String? playlistId) async {
    try {
      final response = await locator!<NetworkClient>().youtubeVideos.get(
        '/youtube/v3/playlistItems',
        queryParameters: {
          'part': 'snippet,contentDetails,status',
          'playlistId': '${playlistId!}',
          'key': 'AIzaSyAgCnr6L56hWCSao8l8gZyuLFsz90oA_4k',
          'maxResults': 70
        },
      );
      return (response['items'] as List).map((e) => Video.fromMap(e)).toList();
    } catch (e) {
      throw e;
    }
  }
}
