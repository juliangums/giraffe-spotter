import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/models/Annotations.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GiraffeProfile.g.dart';

@JsonSerializable()
class GiraffeProfile extends Equatable {
  const GiraffeProfile(
      this.day,
      this.genus,
      this.age,
      this.approved,
      this.hour,
      this.guid,
      this.livingStatus,
      this.locationId,
      this.modified,
      this.month,
      this.size,
      this.species,
      this.state,
      this.locality,
      this.sex,
      this.year,
      this.comments,
      this.groupRole,
      this.lifeStage,
      this.behavior,
      this.bodyCondition,
      this.catalogNo,
      this.distinguishingScar,
      this.annotations,
      this.longitude,
      this.latitude);

  final String catalogNo;
  final String age;
  final int day;
  final List<Annotations> annotations;
  final bool approved;
  final String genus;
  final String guid;
  final int hour;
  final String livingStatus;
  final String locationId;
  final String modified;
  final int month;
  final String size;
  final String species;
  final String state;
  final String locality;
  final int year;
  final String sex;
  final String behavior;
  final String bodyCondition;
  final String lifeStage;
  final String groupRole;
  final double? latitude;
  final double? longitude;
  final String distinguishingScar;
  final String comments;
  // static const empty = GiraffeProfile();

  @override
  List<Object?> get props => [
        day,
        genus,
        annotations,
        guid,
        livingStatus,
        locationId,
        modified,
        month,
        size,
        species,
        state,
        locality,
        year,
        sex,
        comments,
        distinguishingScar,
        bodyCondition,
        catalogNo,
        behavior,
        lifeStage,
        latitude,
        longitude,
      ];

  factory GiraffeProfile.fromJson(Map<String, dynamic> json) => _$GiraffeProfileFromJson(json);

  Map<String, dynamic> toJson() => _$GiraffeProfileToJson(this);
}
