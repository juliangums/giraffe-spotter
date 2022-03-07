import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Channel.dart';

part 'Rss.g.dart';

@JsonSerializable()
class Rss  extends Equatable{
  const Rss({
    required  this.channel,
  });
  @JsonKey(includeIfNull: false)
  final Channel channel;

  factory Rss.fromJson(Map<String, dynamic> json ) => _$RssFromJson(json);

  Map<String, dynamic> toJson() => _$RssToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [channel];
}