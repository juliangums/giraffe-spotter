import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User extends Equatable {

  const User({this.username,this.email,this.fullname,this.token,this.uuid,this.phone_number,this.name,this.profile_image});

  @JsonKey(includeIfNull: false)
  final String? username;
  @JsonKey(includeIfNull: true)
  final String? name;
  @JsonKey(includeIfNull: false)
  final String? email;
  @JsonKey(includeIfNull: false)
  final String? fullname;
  @JsonKey(includeIfNull: false)
  final String? token;
  @JsonKey(includeIfNull: false)
  final String? uuid;
  @JsonKey(includeIfNull: false)
  final String? phone_number;
  @JsonKey(includeIfNull: false)
  final String? profile_image;
  static const empty = User();
  @override
  List<Object?> get props => [
    username,
    fullname,
    email,
    profile_image,
    phone_number,
    uuid,
    token,
    name,
  ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
