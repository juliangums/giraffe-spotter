import 'package:dio/dio.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/network/DioClient.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

class NetworkClient {
  NetworkClient(this.appUrl);

  final String? appUrl;
  final Dio _dio = Dio();
  final Dio _authenticatedDio = Dio();

  DioClient get client => DioClient(appUrl, _dio);
  DioClient get authClient {
    _authenticatedDio..options.headers.addAll({'Authorization': 'Bearer ${SharedObjects.prefs!.getString(Constants.accessToken)}'});
    return DioClient(appUrl, _authenticatedDio);
  }

  DioClient get youtubeChannel => DioClient('https://youtube.googleapis.com', _dio);
  DioClient get youtubeVideos => DioClient('https://youtube.googleapis.com', _dio);
  DioClient get articlesFeed => DioClient('https://giraffeconservation.org/', _dio);
  DioClient get youtubeThumbNail => DioClient('https://www.youtube.com/oembed?url=', _dio);
  DioClient get guestClient => DioClient(appUrl,_dio);
  static String baseUrl(NetworkClient networkClient) => networkClient.appUrl!;
}
