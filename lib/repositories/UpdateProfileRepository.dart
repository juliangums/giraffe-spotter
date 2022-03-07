import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';
import 'package:giraffe_spotter/providers/UpdateProfileProvider.dart';
import 'dart:io';

class UpdateProfileRepository {
  BaseUpdateProfileProvider updateProfileProvider = UpdateProfileProvider();
  Future<ApiResult<User>> updateProfile({required String fullName, required String email}) => updateProfileProvider.updateProfile(fullName: fullName, email: email);
  Future<ApiResult> deleteProfile({required String uuid})=>updateProfileProvider.deleteProfile(uuid: uuid);
  Future<ApiResult<User>> updateImage({required File image})=>updateProfileProvider.updateImage(image: image);
}
