// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Annotations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Annotations _$AnnotationsFromJson(Map<String, dynamic> json) {
  return Annotations(
    (json['media'] as List<dynamic>)
        .map((e) => Media.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AnnotationsToJson(Annotations instance) =>
    <String, dynamic>{
      'media': instance.media,
    };
