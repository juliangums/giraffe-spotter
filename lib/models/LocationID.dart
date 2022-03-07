import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'GeospatialInfo.dart';

part 'LocationID.g.dart';

@JsonSerializable()
class LocationID extends Equatable {

  final String? name;
  final String? id;
  final String? description;
  final String? prefix;
  final int? prefixDigitPadding;
  final GeospatialInfo? geospatialInfo;
  final List<LocationID>? locationID;

  LocationID(
      {this.name,
        this.id,
        this.description,
        this.prefix,
        this.prefixDigitPadding,
        this.geospatialInfo,
        this.locationID});

  factory LocationID.fromJson(Map<String, dynamic> json) => _$LocationIDFromJson(json);

  Map<String, dynamic> toJson() => _$LocationIDToJson(this);

  @override
  List<Object?> get props => [name, id, description, prefix, prefixDigitPadding, geospatialInfo, locationID];

}