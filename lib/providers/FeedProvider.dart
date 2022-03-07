import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';
import 'package:giraffe_spotter/utils/XmlHandler.dart';
import 'BaseProvider.dart';

class FeedProvider extends BaseFeedProvider{

  @override
  void dispose(){}

  @override
  Future<ApiResult<WelcomeJson>> getFeed() async{
    try{

      //xml response
      final response  = await ServiceLocator.getInstance()!<NetworkClient>().articlesFeed.get('feed/');
      //handle the xml response before passing it to the bloc.
      final xmlResponse = await XmlHandler.xmlToJsonConverter(response);
     return ApiResult.success(data: xmlResponse);
    }
    catch(e){
      throw e;
        // return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}