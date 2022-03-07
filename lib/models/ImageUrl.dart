import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ImageUrl.g.dart';

@JsonSerializable()
class ImageUrl extends Equatable {

  @JsonKey(includeIfNull: true)
  final String? image_url;

  const ImageUrl(this.image_url);


  @override
  List<Object?> get props => [image_url];

  factory ImageUrl.fromJson(Map<String, dynamic>json) => _$ImageUrlFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUrlToJson(this);
}