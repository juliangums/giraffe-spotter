// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GiraffeData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiraffeData _$GiraffeDataFromJson(Map<String, dynamic> json) {
  return GiraffeData(
    json['id'] as String,
    json['created_at'] as String,
    json['comments'] as String,
    json['favourite'] as bool,
    json['sex'] as String,
    (json['encounters'] as List<dynamic>)
        .map((e) => GiraffeProfile.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['first_identified_at'] as String,
    json['genus'] as String,
    json['last_seen_at'] as String,
    json['nickname'] as String,
    json['nicknamer'] as String,
    json['number_of_encounters'] as int,
    json['thumbnail_url'] as String,
  );
}

Map<String, dynamic> _$GiraffeDataToJson(GiraffeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comments': instance.comments,
      'first_identified_at': instance.first_identified_at,
      'last_seen_at': instance.last_seen_at,
      'genus': instance.genus,
      'nickname': instance.nickname,
      'nicknamer': instance.nicknamer,
      'number_of_encounters': instance.number_of_encounters,
      'sex': instance.sex,
      'thumbnail_url': instance.thumbnail_url,
      'encounters': instance.encounters,
      'favourite': instance.favourite,
      'created_at': instance.created_at,
    };
