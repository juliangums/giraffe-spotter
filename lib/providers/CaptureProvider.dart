import 'dart:io';

import 'package:dio/dio.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/LatLngModel.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/network/NetworkClient.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:giraffe_spotter/providers/BaseProvider.dart';

class CaptureProvider extends BaseCaptureProvider {
  @override
  void dispose() {}

  @override
  Future<ApiResult> captureData(
      {required String dateTime,
      required String country,
      required double longitude,
      required double latitude,
      required String location,
      required List<File> images}) async {
    try {
      final result = await locator!<NetworkClient>().authClient.post('/encounters',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: FormData.fromMap({
            'date': dateTime,
            'locality': location,
            'country': country,
            'images': images,
            'images.*': images,
            'longitude': longitude,
            'latitude': latitude,
          }));
      return ApiResult.success(data: result);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<LatLngModel>> checkLocation({required File image}) async {
    try {
      final fileName = image.path;

      final result = await locator!<NetworkClient>().authClient.post('/location',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: FormData.fromMap({
            'image': await MultipartFile.fromFile(
              fileName,
              filename: fileName.split('/').last,
              // contentType: MediaType("image", fileName.split('.').last),
            )
          }));

      return ApiResult.success(data: LatLngModel.fromJson(result));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
