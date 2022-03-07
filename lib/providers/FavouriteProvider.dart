import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';

import 'BaseProvider.dart';

class FavouriteProvider extends BaseFavouriteProvider
{

  Future<ApiResult> addFavourite(String id) async
  {
    try {
      final results = await locator!<NetworkClient>().authClient.post('/favorite/$id');
      return ApiResult.success(data: results);
    }catch(e){
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult> unFavourite(String id) async
  {
      try {
        final result = await locator!<NetworkClient>().authClient.post('/unfavorite/$id');
        return ApiResult.success(data: result);
      } catch(e) {
        return ApiResult.failure(error: NetworkExceptions.getDioException(e));
      }
  }

  Future<ApiResult<List<GiraffeData>>> favourites() async
  {
    try {
      final result = await locator!<NetworkClient>().authClient.post('/favourites');
      return ApiResult.success(data: (result['data'] as List).map((e) => GiraffeData.fromJson(e)).toList());
    } catch(e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  void dispose() {}
}