import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';

part 'ApiResult.freezed.dart';

@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({T? data}) = Success<T>;

  const factory ApiResult.failure({NetworkExceptions? error}) = Failure<T>;
}
