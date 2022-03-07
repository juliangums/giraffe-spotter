import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';

class GiraffeProfileProvider extends BaseGiraffeProfileProvider {
  @override
  void dispose() {}

  @override
  Future<ApiResult<List<GiraffeData>>> getGiraffeProfile(int page) async {
    try {
      final result = await locator!<NetworkClient>().authClient.get('/encounters', queryParameters: {'page': page});
      return ApiResult.success(data: (result['data'] as List).map((e) => GiraffeData.fromJson(e)).toList());
        } catch (e) {
          return ApiResult.failure(error: NetworkExceptions.getDioException(e));
      }
  }

  @override
  Future<ApiResult<List<GiraffeData>>> filterGiraffes({required String ageStart, required String ageEnd, required String species, required String location, required String gender}) async {
    try {
      final result = await locator!<NetworkClient>().authClient.get(
        '/encounters',
        queryParameters: {'gender': gender, 'location': location, 'max_age': ageEnd,
          // 'min_age': ageStart,
          'species': species}
      );
      return ApiResult.success(data: (result['data'] as List).map((e) => GiraffeData.fromJson(e)).toList());
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<GiraffeData>> singleGiraffe({required String id}) async {
    try{
      final result = await locator!<NetworkClient>().authClient.get('/encounters/$id');
      return ApiResult.success(data: GiraffeData.fromJson(result['data']));
    }catch(e){
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
