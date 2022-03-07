// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LatLngModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLngModel _$LatLngModelFromJson(Map<String, dynamic> json) {
  return LatLngModel(
    longitude: (json['longitude'] as num?)?.toDouble(),
    latitude: (json['latitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$LatLngModelToJson(LatLngModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
