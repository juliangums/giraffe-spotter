import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GeospatialInfo.g.dart';

@JsonSerializable()
class GeospatialInfo extends Equatable {
  final double? lat;
  final double? long;

  GeospatialInfo({this.lat, this.long});

  @override
  List<Object?> get props =>[lat, long];

  factory GeospatialInfo.fromJson(Map<String,dynamic> json) => _$GeospatialInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GeospatialInfoToJson(this);
}