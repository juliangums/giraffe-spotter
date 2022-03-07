// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  try{
    final data = Item(
      title: Description.fromJson(json['title'] as Map<String, dynamic>),
      link: Description.fromJson(json['link'] as Map<String, dynamic>),
      creator: DecodedJson.fromJson(json['dc\u0024creator'] as Map<String, dynamic>),
      pubDate: Description.fromJson(json['pubDate'] as Map<String, dynamic>),
      category: DecodedJson.fromJson(json['category'] as Map<String, dynamic>),
      guid: Description.fromJson(json['guid'] as Map<String, dynamic>),
      description: DecodedJson.fromJson(json['description'] as Map<String, dynamic>),
      encoded: DecodedJson.fromJson(json['content\u0024encoded'] as Map<String, dynamic>),
    );
    return data;
  } catch(_){
    final data = Item(
      title: Description.fromJson(json['title'] as Map<String, dynamic>),
      link: Description.fromJson(json['link'] as Map<String, dynamic>),
      creator: DecodedJson.fromJson(json['dc\u0024creator'] as Map<String, dynamic>),
      pubDate: Description.fromJson(json['pubDate'] as Map<String, dynamic>),
      category: DecodedJson.fromJson(json['category'][0] as Map<String, dynamic>),
      guid: Description.fromJson(json['guid'] as Map<String, dynamic>),
      description:
      DecodedJson.fromJson(json['description'] as Map<String, dynamic>),
      encoded: DecodedJson.fromJson(json['content\u0024encoded'] as Map<String, dynamic>),
    );
    return data;
  }
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'title': instance.title,
  'link': instance.link,
  'dc\u0024creator': instance.creator,
  'pubDate': instance.pubDate,
  'category': instance.category,
  'guid': instance.guid,
  'description': instance.description,
  'content\u0024encoded': instance.encoded,
};