import 'package:giraffe_spotter/config/Constants.dart';
import 'package:google_maps_webservice/places.dart';

import 'BaseProvider.dart';

class MapSearchPlaceProvider extends BaseMapPlaceSearchProvider {
  @override
  void dispose() {}

  final places = new GoogleMapsPlaces(apiKey: Constants.googleMapsKey);

  @override
  Future<List<PlacesSearchResult>> getPlaces(String keyword) async {
    PlacesSearchResponse response = await places.searchByText(keyword);
    return response.results;
  }
}
