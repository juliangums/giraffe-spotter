import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:giraffe_spotter/network/NetworkExceptions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mapbox_search/mapbox_search.dart';

part 'MapSearchState.freezed.dart';

@freezed
abstract class MapSearchState with _$MapSearchState {
  const factory MapSearchState.idle() = Idle;

  const factory MapSearchState.loading() = Loading;

  const factory MapSearchState.getPlacesDone(List<PlacesSearchResult> data) = GetPlacesDone;

  const factory MapSearchState.getExactPlacesDone(List<MapBoxPlace>? data) = GetExactPlacesDone;

  const factory MapSearchState.error(NetworkExceptions error) = Error;

}
