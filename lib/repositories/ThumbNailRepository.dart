import 'package:giraffe_spotter/models/ThumbNail.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';
import 'package:giraffe_spotter/providers/ThumbNailProvider.dart';
import 'package:giraffe_spotter/repositories/BaseRepository.dart';

class ThumbNailRepository extends BaseRepository{

  @override
  void dispose() {}

  final BaseThumbNailProvider _baseThumbNailProvider = ThumbNailProvider();

  Future<ApiResult<ThumbNail>> getThumbNail(String youtubeUrl) => _baseThumbNailProvider.getThumbNail(youtubeUrl);

}