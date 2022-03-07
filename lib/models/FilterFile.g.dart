// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FilterFile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterFile _$FilterFileFromJson(Map<String, dynamic> json) {
  return FilterFile(
    description: json['description'] as String?,
    locationID: (json['locationID'] as List<dynamic>?)
        ?.map((e) => LocationID.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FilterFileToJson(FilterFile instance) =>
    <String, dynamic>{
      'description': instance.description,
      'locationID': instance.locationID,
    };
