// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocationID.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationID _$LocationIDFromJson(Map<String, dynamic> json) {
  return LocationID(
    name: json['name'] as String?,
    id: json['id'] as String?,
    description: json['description'] as String?,
    prefix: json['prefix'] as String?,
    prefixDigitPadding: json['prefixDigitPadding'] as int?,
    geospatialInfo: json['geospatialInfo'] == null
        ? null
        : GeospatialInfo.fromJson(
            json['geospatialInfo'] as Map<String, dynamic>),
    locationID: (json['locationID'] as List<dynamic>?)
        ?.map((e) => LocationID.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LocationIDToJson(LocationID instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'description': instance.description,
      'prefix': instance.prefix,
      'prefixDigitPadding': instance.prefixDigitPadding,
      'geospatialInfo': instance.geospatialInfo,
      'locationID': instance.locationID,
    };
