import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/FilterFile.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';

import 'BaseProvider.dart';

class FilterProvider extends BaseFilterProvider {
  @override
  void dispose() {}

  @override
  Future<ApiResult<FilterFile>> getConfig() async{
    try {
      final results = await locator!<NetworkClient>().authClient.get('/config');
      return ApiResult.success( data: FilterFile.fromJson(results['data']));
    } catch(e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

}