import 'package:freezed_annotation/freezed_annotation.dart';

part 'MapSearchEvent.freezed.dart';

@freezed
abstract class MapSearchEvent with _$MapSearchEvent {
  const factory MapSearchEvent.getPlaces(String keyword) = GetPlaces;
  const factory MapSearchEvent.getExactPlaces(double latitude, double longitude) = GetExactPlaces;
  const factory MapSearchEvent.reset() = Resettings;
}
