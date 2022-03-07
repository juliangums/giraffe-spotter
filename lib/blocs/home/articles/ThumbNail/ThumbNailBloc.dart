import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:giraffe_spotter/network/ApiResult.dart';
import 'package:giraffe_spotter/repositories/ThumbNailRepository.dart';

import 'Bloc.dart';


class ThumbNailBloc extends Bloc<ThumbNailEvent, ThumbNailState> {
  ThumbNailBloc(ThumbNailRepository thumbNailRepository) :
        _thumbNailRepository = thumbNailRepository,
        super(ThumbNailState.idle());

  final ThumbNailRepository _thumbNailRepository;

  @override
  Stream<ThumbNailState> mapEventToState(ThumbNailEvent event) async* {
    if(event is GetThumb){
      yield* mapYoutubeThumbNail(event);
    }
  }



  Stream<ThumbNailState> mapYoutubeThumbNail(ThumbNailEvent event) async*{
    yield ThumbNailState.loading();
    ApiResult data = await _thumbNailRepository.getThumbNail(event.youtubeUrl);
    yield* data.when(
        success: (data) async*{
          yield ThumbNailState.getThumbNail( data!);
        },
        failure: ( error) async* {
          yield ThumbNailState.error(error!);
        }
    );
  }


}
