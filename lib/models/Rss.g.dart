// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Rss.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rss _$RssFromJson(Map<String, dynamic> json) {
  return Rss(
    channel: Channel.fromJson(json['channel'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RssToJson(Rss instance) => <String, dynamic>{
      'channel': instance.channel,
    };
