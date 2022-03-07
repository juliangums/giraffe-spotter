# giraffe_spotter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

##Beware

-Beware of 2 model classes after running this flutter command:

```flutter
 flutter pub build_runner
```

Files affected are item.g.dart and thumbnail.g.dart, so replace them with the code below :).

##item.g should be:

```
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
      comments: Description.fromJson(json['comments'] as Map<String, dynamic>),
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
      comments: Description.fromJson(json['comments'] as Map<String, dynamic>),
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
  'comments': instance.comments,
  'dc\u0024creator': instance.creator,
  'pubDate': instance.pubDate,
  'category': instance.category,
  'guid': instance.guid,
  'description': instance.description,
  'content\u0024encoded': instance.encoded,
};
```

##thumbnail.g.dart

```
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThumbNail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
ThumbNail _$ThumbNailFromJson(Map<String, dynamic> json) {
  return ThumbNail(
    json['title'] as String,
    json['thumbnail_url'] as String,
  );
}

Map<String, dynamic> _$ThumbNailToJson(ThumbNail instance) => <String, dynamic>{
  'title': instance.title,
  'thumbnail_url': instance.thumbnailUrl,
};
```

#Addational files
Add this files in your vim .zshrc

```
machine api.mapbox.com
login mapbox
password sk.eyJ1Ijoic3ludGF4bHRkIiwiYSI6ImNrcjY2ZWZ0bTBiMGMyd2xwN2duajdodXQifQ.4JRUCSgvaTK2lssnMvRzRA
```
