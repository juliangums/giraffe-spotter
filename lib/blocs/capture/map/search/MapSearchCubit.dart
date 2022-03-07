import 'package:bloc/bloc.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:mapbox_search/mapbox_search.dart';

class MapSearchCubit extends Cubit<bool> {
  final String key = Constants.mapBoxToken;
  final String keyword ='';
  MapSearchCubit() : super(true);

 //Places Search
  Future placesSearch(key,keyword) async {
    var placesService = PlacesSearch(
      apiKey: key,
      limit: 5,
    );

    var places = await placesService.getPlaces(
      key,
    );

    print(places);
  }
}
