import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';

part 'ArticleState.freezed.dart';


@freezed
abstract class ArticleState with _$ArticleState {

  const factory ArticleState.idle() = Idle;

  const factory ArticleState.loading() = Loading;

  const factory ArticleState.getFeedDone(WelcomeJson data) = GetFeedDone;

  const factory ArticleState.error(NetworkExceptions error) = Error;
}
