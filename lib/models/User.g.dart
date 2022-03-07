// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String?,
    email: json['email'] as String?,
    fullname: json['fullname'] as String?,
    token: json['token'] as String?,
    uuid: json['uuid'] as String?,
    phone_number: json['phone_number'] as String?,
    name: json['name'] as String?,
    profile_image: json['profile_image'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  val['name'] = instance.name;
  writeNotNull('email', instance.email);
  writeNotNull('fullname', instance.fullname);
  writeNotNull('token', instance.token);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('phone_number', instance.phone_number);
  writeNotNull('profile_image', instance.profile_image);
  return val;
}
