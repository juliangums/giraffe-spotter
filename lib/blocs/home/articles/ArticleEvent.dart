import 'package:freezed_annotation/freezed_annotation.dart';

part  'ArticleEvent.freezed.dart';

@freezed
abstract class ArticleEvent  with _$ArticleEvent{

  const factory ArticleEvent.getFeed() = GetFeed;

}
