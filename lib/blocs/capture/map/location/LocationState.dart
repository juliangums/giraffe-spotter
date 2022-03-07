import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

abstract class LocationState extends Equatable {}

class PlaceState extends LocationState {
  PlaceState({required this.place});
  final PlacesSearchResult? place;
  @override
  List get props => [place];
}

class InitialState extends LocationState {
  @override
  List get props => [];
}

class ImageState extends LocationState {
  ImageState({required this.placemarks, required this.longitude, required this.latitude});

  final Placemark? placemarks;
  final double? latitude;
  final double? longitude;

  @override
  List get props => [placemarks, longitude, latitude];
}

class MarkerPosition extends LocationState {
  MarkerPosition({required this.placemark, this.latitude, this.longitude});
  final Placemark? placemark;
  final double? longitude;
  final double? latitude;

  @override
  List<Object?> get props => [placemark, longitude, latitude];
}

class MapSatellite extends LocationState {
  final String satellite = 'mapbox://styles/mapbox/satellite-streets-v11';

  @override
  List<Object?> get props => [satellite];
}

class MapStreet extends LocationState {
  final String satellite = 'mapbox://styles/mapbox/streets-v11';

  @override
  List<Object?> get props => [satellite];
}
