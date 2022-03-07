import 'package:freezed_annotation/freezed_annotation.dart';

part  'ThumbNailEvent.freezed.dart';

@freezed
abstract class ThumbNailEvent with _$ThumbNailEvent {

  const factory ThumbNailEvent.getThumbNail(String youtubeUrl) = GetThumb;
}

