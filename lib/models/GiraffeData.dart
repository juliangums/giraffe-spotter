import 'package:equatable/equatable.dart';
import 'package:giraffe_spotter/models/GiraffeProfile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GiraffeData.g.dart';

@JsonSerializable()
class GiraffeData extends Equatable {

  @JsonKey(includeIfNull: false)
  final String id;
  @JsonKey(includeIfNull: false)
  final String comments;
  @JsonKey(includeIfNull: false)
  final String first_identified_at;
  @JsonKey(includeIfNull: false)
  final String last_seen_at;
  @JsonKey(includeIfNull: false)
  final String genus;
  @JsonKey(includeIfNull: false)
  final String nickname;
  @JsonKey(includeIfNull: false)
  final String nicknamer;
  @JsonKey(includeIfNull: false)
  final int number_of_encounters;
  @JsonKey(includeIfNull: false)
  final String sex;
  @JsonKey(includeIfNull: false)
  final String thumbnail_url;
  @JsonKey(includeIfNull: true)
  final List<GiraffeProfile> encounters;
  @JsonKey(includeIfNull: true)
  final bool favourite;
  @JsonKey(includeIfNull: true)
  final String created_at;

  const GiraffeData(
  this.id,
  this.created_at,
  this.comments,
  this.favourite,
  this.sex,
  this.encounters,
  this.first_identified_at,
  this.genus,
  this.last_seen_at,
  this.nickname,
  this.nicknamer,
  this.number_of_encounters,
  this.thumbnail_url,
  );

  @override
  List<Object> get props => [
    id,
    created_at,
    number_of_encounters,
    nicknamer,
    nickname,
    sex,
    thumbnail_url,
    encounters,
    comments,
    genus,
    last_seen_at,
    first_identified_at,
    favourite,
  ];

  factory GiraffeData.fromJson(Map<String, dynamic>json) => _$GiraffeDataFromJson(json);

  Map<String, dynamic> toJson() => _$GiraffeDataToJson(this);
}