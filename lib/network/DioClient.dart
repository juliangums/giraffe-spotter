import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  final String? baseUrl;
  final List<Interceptor>? interceptors;
  late Dio _dio;

  DioClient(this.baseUrl, Dio dio, {this.interceptors}) {
    _dio = dio;

    _dio
      ..options.baseUrl = baseUrl!
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers.addAll({'Accept': 'application/json'})
      ..interceptors.addAll([]);

    if (interceptors != null && interceptors!.isNotEmpty) {
      _dio.interceptors.addAll(interceptors!);
    }
   //
   // if (kDebugMode) {
   //    _dio.interceptors.add(PrettyDioLogger(
   //        requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90));
   //  }
  }

  Future<dynamic> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool refresh = false,
      Duration? duration}) async {
    try {
      if (options != null)
        options.headers!.addAll({
          'content-type': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json; charset=UTF-8',
        });
      var response = await _dio.get(uri,
          queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException('Unable to process data.');
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool hasFile = false}) async {
    try {
      if (!hasFile && options != null) {
        options.headers!.addAll({
          'content-type': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json; charset=UTF-8',
        });
      }
      var response = await _dio.post(uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      if (uri.contains('LoginUser')) {
        sessionIdPicker(response.headers['set-cookie']);
      }

      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data.");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> request(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      bool hasFile = false,
      ProgressCallback? onReceiveProgress}) async {
    try {
      if (!hasFile && options != null) {
        options.headers!.addAll({
          'content-type': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json; charset=UTF-8',
        });
      }

      var response = await _dio.request(uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data.");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> put(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      bool hasFile = false,
      ProgressCallback? onReceiveProgress}) async {
    try {
      if (!hasFile && options != null) {
        options.headers!.addAll({
          'content-type': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json; charset=UTF-8',
        });
      }

      var response = await _dio.put(uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);

      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data.");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> delete(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      dynamic data,
      CancelToken? cancelToken}) async {
          try {
            if (options != null) {
              options.headers!.addAll({
                'content-type': 'application/json; charset=UTF-8',
                'Content-Type': 'application/json; charset=UTF-8',
              });
            }

            var response = await _dio.delete(uri,
                queryParameters: queryParameters,
                options: options,
                data: data,
                cancelToken: cancelToken);

            return response.data;
          } on FormatException catch (_) {
            throw FormatException("Unable to process the data.");
          } catch (e) {
            throw e;
          }
      }

  //Pick sessionID
  void sessionIdPicker(List<String>? cookies) {
    for (var cookie in cookies!) {
      if (cookie.contains('JSESSIONID')) {
        var theCookie = (cookie + ';').split(';');
        for (var cook in theCookie) {
          if (cook.contains('JSESSIONID')) {
            var results = cook.split('=');
            // the sessionID;
            SharedObjects.prefs!.setString('sessionID', results[1]);
          }
        }
      }
    }
  }
}
