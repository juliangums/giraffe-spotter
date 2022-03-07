import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'LocationID.dart';

part 'FilterFile.g.dart';

@JsonSerializable()
class FilterFile extends Equatable {
  final String? description;
  final List<LocationID>? locationID;

  FilterFile({this.description, this.locationID});

  @override
  List<Object?> get props => [description, locationID];

  factory FilterFile.fromJson(Map<String, dynamic> json) => _$FilterFileFromJson(json);

  Map<String, dynamic> toJson() => _$FilterFileToJson(this);
}