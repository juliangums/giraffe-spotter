// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThumbNail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
ThumbNail _$ThumbNailFromJson(Map<String, dynamic> json) {
  return ThumbNail(
    json['title'] as String,
    json['thumbnail_url'] as String,
  );
}

Map<String, dynamic> _$ThumbNailToJson(ThumbNail instance) => <String, dynamic>{
  'title': instance.title,
  'thumbnail_url': instance.thumbnailUrl,
};