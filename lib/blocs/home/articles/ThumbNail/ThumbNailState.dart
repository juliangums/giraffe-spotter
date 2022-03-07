import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giraffe_spotter/models/ThumbNail.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';


part  'ThumbNailState.freezed.dart';


@freezed
abstract class ThumbNailState with _$ThumbNailState {

  const factory ThumbNailState.idle() = Idle;

  const factory ThumbNailState.loading() = Loading;

  const factory ThumbNailState.getThumbNail(ThumbNail data) = GetFeedDone;

  const factory ThumbNailState.error(NetworkExceptions error) = Error;
}