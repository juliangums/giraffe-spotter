import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LatLngModel.g.dart';

@JsonSerializable()
class LatLngModel extends Equatable {

  final double? latitude;
  final double? longitude;

  LatLngModel({ this.longitude, this.latitude});

  @override
  List<Object?> get props => [longitude,latitude];

  factory LatLngModel.fromJson(Map<String, dynamic> json) => _$LatLngModelFromJson(json);

  Map<String, dynamic> toJson() => _$LatLngModelToJson(this);

}