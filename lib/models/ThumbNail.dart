import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'ThumbNail.g.dart';


@JsonSerializable()
class ThumbNail extends Equatable{
  @JsonKey(includeIfNull:  false)
  final String title;
  @JsonKey(includeIfNull:  false)
  final String thumbnailUrl;

  ThumbNail(this.title, this.thumbnailUrl);

  factory ThumbNail.fromJson(Map<String,dynamic> json)=>_$ThumbNailFromJson(json);

  Map<String, dynamic> toJson()=> _$ThumbNailToJson(this);


  @override
  List<Object?> get props => [title,thumbnailUrl];

}