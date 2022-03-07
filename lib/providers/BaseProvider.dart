import 'dart:io';

import 'package:giraffe_spotter/models/FilterFile.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/models/LatLngModel.dart';
import 'package:giraffe_spotter/models/ThumbNail.dart';
import 'package:giraffe_spotter/models/User.dart';
import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:google_maps_webservice/places.dart';

abstract class BaseProvider {
  void dispose();
}

abstract class BaseFeedProvider extends BaseProvider {
  Future<ApiResult<WelcomeJson>> getFeed();
}

abstract class BaseThumbNailProvider extends BaseProvider {
  Future<ApiResult<ThumbNail>> getThumbNail(String youtubeUrl);
}

abstract class BaseFilterProvider extends BaseProvider {
  Future<ApiResult<FilterFile>> getConfig();
}

abstract class BaseMapPlaceSearchProvider extends BaseProvider {
  Future<List<PlacesSearchResult>> getPlaces(String keyword);
// Future<List<MapBoxPlace>> getExactPlaces(double latitude, double longitude);
}

abstract class BaseAuthenticationProvider extends BaseProvider {
  bool isSignedIn();

  Future<ApiResult<User>> user();

  Future<ApiResult<User>> login({required String email, required String password});

  Future<ApiResult> logout();

  Future<ApiResult<User>> signUp({required String fullName, required String email, required String password, required acceptTerms});

  Future<ApiResult> forgotPassword({required String email, required Uri? link});

  Future<ApiResult> resetPassword(
      {required String password, required String? token, required String confirmPassword, required String email});
}

abstract class BaseUpdateProfileProvider extends BaseProvider {
  Future<ApiResult<User>> updateProfile({required String fullName, required String email});

  Future<ApiResult> deleteProfile({required String uuid});

  Future<ApiResult<User>> updateImage({required File image});
}

abstract class BaseCaptureProvider extends BaseProvider {
  Future<ApiResult> captureData(
      {required String dateTime,
      required double longitude,
      required double latitude,
      required String location,
      required String country,
      required List<File> images});

  Future<ApiResult<LatLngModel>> checkLocation({required File image});
}

abstract class BaseFavouriteProvider extends BaseProvider {
  Future<ApiResult> favourites();

  Future<ApiResult> unFavourite(String id);

  Future<ApiResult> addFavourite(String id);
}

abstract class BaseGiraffeProfileProvider extends BaseProvider {
  Future<ApiResult<List<GiraffeData>>> getGiraffeProfile(int page);

  Future<ApiResult<List<GiraffeData>>> filterGiraffes(
      {required String ageStart, required String ageEnd, required String species, required String location, required String gender});

  Future<ApiResult<GiraffeData>> singleGiraffe({required String id});
}
