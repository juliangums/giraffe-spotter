import 'dart:io';

import 'package:giraffe_spotter/models/LatLngModel.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';
import 'package:giraffe_spotter/providers/CaptureProvider.dart';

class CaptureRepository {
  BaseCaptureProvider captureProvider = CaptureProvider();

  Future<ApiResult> captureData(
          {required String location,
          required double latitude,
          required double longitude,
          required String country,
          required String uuid,
          required List<File> images,
          required String dateTime}) =>
      captureProvider.captureData(
          dateTime: dateTime, location: location, country: country, latitude: latitude, longitude: longitude, images: images);

  Future<ApiResult<LatLngModel>> checkLocation({required File image}) => captureProvider.checkLocation(image: image);
}
