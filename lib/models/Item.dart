import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'DecodeJson.dart';
import 'Description.dart';



part 'Item.g.dart';

@JsonSerializable()
class Item  extends Equatable{
  const Item({
    required this.title,
    required this.link,
    required  this.creator,
    required   this.pubDate,
    required   this.category,
    required  this.guid,
    required  this.description,
    required  this.encoded,
  });

  final Description title;
  final Description link;
  @JsonKey(includeIfNull: false)
  final DecodedJson creator;
  final Description pubDate;
  @JsonKey(includeIfNull: false)
  final DecodedJson category;
  @JsonKey(includeIfNull: false)
  final Description guid;
  final DecodedJson description;
  @JsonKey(includeIfNull: false)
  final DecodedJson encoded;




  factory Item.fromJson(Map<String,dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson()=> _$ItemToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [title,link,creator,pubDate,category,guid,description,encoded];
}