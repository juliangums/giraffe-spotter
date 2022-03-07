import 'package:giraffe_spotter/providers/BaseProvider.dart';
import 'package:giraffe_spotter/providers/MapPlaceSearchProvider.dart';
import 'package:giraffe_spotter/repositories/BaseRepository.dart';
import 'package:google_maps_webservice/places.dart';

class MapSearchRepository extends BaseRepository {
  final BaseMapPlaceSearchProvider _baseMapPlaceSearchProvider = MapSearchPlaceProvider();
  Future<List<PlacesSearchResult>> getPlaces(String keyword) => _baseMapPlaceSearchProvider.getPlaces(keyword);
  // Future<List<MapBoxPlace>> getExactPlaces(double latitude, double longitude) =>
  //     _baseMapPlaceSearchProvider.getExactPlaces(latitude, longitude);
  @override
  void dispose() {}
}
