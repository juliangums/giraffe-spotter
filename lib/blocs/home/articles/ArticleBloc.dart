import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/repositories/FeedRepository.dart';

import 'Bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc(FeedRepository repository)
      : _repository = repository,
        super(ArticleState.idle());

  final FeedRepository _repository;

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is GetFeed) {
      yield* mapFetchFeedEventToState();
    }
  }

  Stream<ArticleState> mapFetchFeedEventToState() async* {
    yield ArticleState.loading();

    ApiResult<WelcomeJson> data = await _repository.getFeed();
    yield* data.when(success: (data) async* {
      yield ArticleState.getFeedDone(data!);
    }, failure: (error) async* {
      yield ArticleState.error(error!);
    });
  }
}
