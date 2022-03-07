// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GeospatialInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeospatialInfo _$GeospatialInfoFromJson(Map<String, dynamic> json) {
  return GeospatialInfo(
    lat: (json['lat'] as num?)?.toDouble(),
    long: (json['long'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$GeospatialInfoToJson(GeospatialInfo instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };
