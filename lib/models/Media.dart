import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'Media.g.dart';

@JsonSerializable()
class Media extends Equatable {

  @JsonKey(includeIfNull: true)
  final String image_url;

  const Media(this.image_url);

  @override
  List<Object?> get props => [image_url];

  factory Media.fromJson(Map<String, dynamic>json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);

}