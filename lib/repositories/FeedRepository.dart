import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';
import 'package:giraffe_spotter/providers/FeedProvider.dart';
import 'package:giraffe_spotter/repositories/BaseRepository.dart';

class FeedRepository extends BaseRepository{

  final BaseFeedProvider _baseFeedProvider = FeedProvider();

  Future<ApiResult<WelcomeJson>> getFeed() => _baseFeedProvider.getFeed();

  @override
  void dispose() {}
}