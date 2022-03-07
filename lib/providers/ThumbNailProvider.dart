import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/ThumbNail.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';

import 'BaseProvider.dart';

class ThumbNailProvider extends BaseThumbNailProvider{

  @override
  void dispose(){}

  //fetch youtube thumbnails for articles page
  @override
  Future<ApiResult<ThumbNail>> getThumbNail(String youtubeUrl) async{

    try {
      final response  = await ServiceLocator.getInstance()!<NetworkClient>().youtubeThumbNail.get('https://www.youtube.com/oembed?url='+youtubeUrl);

     return ApiResult.success(data: ThumbNail.fromJson(response) );
    }
    catch(e){
      throw e;
    }
}

}