import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:giraffe_spotter/blocs/capture/map/location/LocationState.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({this.switched = false}) : super(InitialState());

  bool switched;

  void changeCameraPosition(place) {
    emit(PlaceState(place: place));
  }

  void initialState() {
    emit(InitialState());
  }

  void imageLocator(placemark, latitude, longitude) async {
    emit(ImageState(placemarks: placemark, latitude: latitude, longitude: longitude));
  }

  void markerPosition(latitude, longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
      emit(MarkerPosition(placemark: placemarks[0], latitude: latitude, longitude: longitude));
    } catch (e) {}
  }

  void mapChange(bool value) {
    switched = value;
    value == true ? emit(MapSatellite()) : emit(MapStreet());
  }
}
