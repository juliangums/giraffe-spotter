import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:giraffe_spotter/blocs/capture/map/search/Bloc.dart';
import 'package:giraffe_spotter/repositories/MapSearchRepository.dart';
import 'package:google_maps_webservice/places.dart';

class MapSearchBloc extends Bloc<MapSearchEvent, MapSearchState> {
  MapSearchBloc(MapSearchRepository repository)
      : _repository = repository,
        super(MapSearchState.idle());
  final MapSearchRepository _repository;
  @override
  Stream<MapSearchState> mapEventToState(MapSearchEvent event) async* {
    if (event is GetPlaces) {
      yield* mapFetchPlacesEventToState(event.keyword);
    }
    if(event is Resettings) {
      yield* mapResetPlaceEvent();
    }
  }

  Stream<MapSearchState> mapResetPlaceEvent() async*{
      yield MapSearchState.idle();
  }

  Stream<MapSearchState> mapFetchPlacesEventToState(event) async* {
    // call function for searching places
    try {
      yield MapSearchState.loading();
      List<PlacesSearchResult> places = await _repository.getPlaces(event);
      yield MapSearchState.getPlacesDone(places);
    } catch (e) {
      //TODO: remove the throw error;
      throw e;
    }
  }
}
