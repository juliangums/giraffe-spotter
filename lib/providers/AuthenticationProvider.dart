import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

import 'BaseProvider.dart';

class AuthenticationProvider extends BaseAuthenticationProvider {
  @override
  void dispose() {}

  bool isSignedIn() {
    return SharedObjects.prefs!.getString(Constants.accessToken) != null;
  }

  Future<ApiResult<User>> login({required String email, required String password}) async {
    try {
      final result = await locator!<NetworkClient>().guestClient.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      User user = User.fromJson(result['data']);
      return ApiResult.success(data: user);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult> logout() async {
    try {
      final result = await locator!<NetworkClient>().authClient.post('/logout');
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<User>> signUp({required String fullName, required String email, required String password, required acceptTerms}) async {
    try {
      final result = await locator!<NetworkClient>().client.post(
        '/register',
        data: {'fullName': fullName, 'email': email, 'password': password, 'termsOfAgreement': acceptTerms},
      );
      User user = User.fromJson(result['user']);
      return ApiResult.success(data: user);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult> forgotPassword({required String email, required Uri? link}) async {
    try {
      final results = await locator!<NetworkClient>().guestClient.post('/mail', queryParameters: {'email': email, 'link': link});

      return ApiResult.success(data: results);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult> resetPassword({required String password,required String? token, required String confirmPassword, required String email}) async {
    try {
      final results = await locator!<NetworkClient>()
          .guestClient
          .post('/password/reset', queryParameters: {'password': password, 'confirmPassword': confirmPassword, 'email': email, 'token': token});

      return ApiResult.success(data: results);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<User>> user() async {
    try {
      final results = await locator!<NetworkClient>().authClient.get('/user');
      User user = User.fromJson(results['data']);
      return ApiResult.success(data: user);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
