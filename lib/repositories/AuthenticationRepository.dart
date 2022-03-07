import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/providers/AuthenticationProvider.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';

class AuthenticationRepository {
  BaseAuthenticationProvider authenticationProvider = AuthenticationProvider();

  bool get isSignedIn => authenticationProvider.isSignedIn();

  Future<ApiResult<User>> get user => authenticationProvider.user();

  Future<ApiResult<User>> login({required String email, required String password}) =>
      authenticationProvider.login(email: email, password: password);

  Future<ApiResult> logout() => authenticationProvider.logout();

  Future<ApiResult<User>> signUp({required String fullName, required String email, required String password, required acceptTerms}) =>
      authenticationProvider.signUp(fullName: fullName, email: email, password: password, acceptTerms: acceptTerms);

  Future<ApiResult> forgotPassword({required String email, required Uri? link}) =>
      authenticationProvider.forgotPassword(email: email, link: link);

  Future<ApiResult> resetPassword({required String password, required String? token, required String confirmPassword, required String email}) =>
      authenticationProvider.resetPassword(password: password, confirmPassword: confirmPassword, token: token, email: email);
}
