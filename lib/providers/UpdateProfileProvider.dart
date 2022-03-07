import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UpdateProfileProvider extends BaseUpdateProfileProvider {
  @override
  void dispose() {}

  @override
  Future<ApiResult<User>> updateProfile({required String fullName, required String email}) async {
    try {
      final result = await locator!<NetworkClient>().authClient.put(
        '/user',
        data: {'name': fullName, 'email': email},
      );

      User user = User.fromJson(result['user']);

      return ApiResult.success(data: user);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult> deleteProfile({required String uuid}) async {
    try {
      final result = await locator!<NetworkClient>().authClient.delete('/user', queryParameters: {'uuid': uuid});
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
  
  Future<ApiResult<User>> updateImage({required File image}) async {
    try{
      final fileName = image.path;
      final results =  await locator!<NetworkClient>().authClient.post('/user/image',
          data: FormData.fromMap({'image':
      await MultipartFile.fromFile(fileName, filename: fileName.split('/').last,contentType: MediaType("image", fileName.split('.').last),)}
      )
      );
      User user = User.fromJson(results['data']);
      return ApiResult.success( data: user );
    }catch(e){
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
