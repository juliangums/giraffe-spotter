// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GiraffeProfile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiraffeProfile _$GiraffeProfileFromJson(Map<String, dynamic> json) {
  return GiraffeProfile(
    json['day'] as int,
    json['genus'] as String,
    json['age'] as String,
    json['approved'] as bool,
    json['hour'] as int,
    json['guid'] as String,
    json['livingStatus'] as String,
    json['locationId'] as String,
    json['modified'] as String,
    json['month'] as int,
    json['size'] as String,
    json['species'] as String,
    json['state'] as String,
    json['locality'] as String,
    json['sex'] as String,
    json['year'] as int,
    json['comments'] as String,
    json['groupRole'] as String,
    json['lifeStage'] as String,
    json['behavior'] as String,
    json['bodyCondition'] as String,
    json['catalogNo'] as String,
    json['distinguishingScar'] as String,
    (json['annotations'] as List<dynamic>)
        .map((e) => Annotations.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['longitude'] as num?)?.toDouble(),
    (json['latitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$GiraffeProfileToJson(GiraffeProfile instance) =>
    <String, dynamic>{
      'catalogNo': instance.catalogNo,
      'age': instance.age,
      'day': instance.day,
      'annotations': instance.annotations,
      'approved': instance.approved,
      'genus': instance.genus,
      'guid': instance.guid,
      'hour': instance.hour,
      'livingStatus': instance.livingStatus,
      'locationId': instance.locationId,
      'modified': instance.modified,
      'month': instance.month,
      'size': instance.size,
      'species': instance.species,
      'state': instance.state,
      'locality': instance.locality,
      'year': instance.year,
      'sex': instance.sex,
      'behavior': instance.behavior,
      'bodyCondition': instance.bodyCondition,
      'lifeStage': instance.lifeStage,
      'groupRole': instance.groupRole,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distinguishingScar': instance.distinguishingScar,
      'comments': instance.comments,
    };
