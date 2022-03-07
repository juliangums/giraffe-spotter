import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'Description.dart';
import 'Item.dart';

part 'Channel.g.dart';

@JsonSerializable()
class Channel  extends Equatable{
  const Channel({
    required this.item,
  });

  @JsonKey( includeIfNull: false)
  final List<Item> item;

  factory Channel.fromJson(Map<String,dynamic> json)=> _$ChannelFromJson(json);

  Map<String,dynamic> toJson() => _$ChannelToJson(this);

  @override
  List<Object> get props => [item];
}