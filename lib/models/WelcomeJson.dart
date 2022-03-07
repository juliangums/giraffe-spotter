import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Rss.dart';

part 'WelcomeJson.g.dart';

@JsonSerializable()
class WelcomeJson extends Equatable{

@JsonKey(includeIfNull:  false)
  final Rss rss;

  const WelcomeJson(this.rss);

  factory WelcomeJson.fromJson(Map<String, dynamic> json)=>_$WelcomeJsonFromJson(json);
  Map<String,dynamic> toJson()=> _$WelcomeJsonToJson(this);

  @override
  List<Object?> get props => [rss];

}