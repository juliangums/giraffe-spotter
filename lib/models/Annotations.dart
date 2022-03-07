import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giraffe_spotter/models/Media.dart';

part 'Annotations.g.dart';

@JsonSerializable()
class Annotations extends Equatable {
  @JsonKey(includeIfNull: true)
  final List<Media> media;

  const Annotations(this.media);

  @override
  List<Object?> get props => [media];

  factory Annotations.fromJson(Map<String, dynamic>json) => _$AnnotationsFromJson(json);

  Map<String, dynamic> toJson() => _$AnnotationsToJson(this);

}