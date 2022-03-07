part of 'CaptureCubit.dart';

class CaptureState extends Equatable {
  final String dateTime;
  final String location;
  final double longitude;
  final double latitude;
  final String country;
  final FormzStatus status;
  final Map<String, List<String>>? formErrors;

  const CaptureState({
    this.formErrors,
    this.country = '',
    this.longitude = 0.0,
    this.latitude = 0.0,
    this.dateTime = '',
    this.location = '',
    this.status = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [formErrors, country, longitude, latitude, dateTime, location, status];

  CaptureState copyWith(
          {double? longitude,
          double? latitude,
          String? dateTime,
          String? location,
          FormzStatus? status,
          Map<String, List<String>>? formErrors,
          String? country}) =>
      CaptureState(
          latitude: latitude ?? this.latitude,
          longitude: longitude ?? this.longitude,
          dateTime: dateTime ?? this.dateTime,
          location: location ?? this.location,
          formErrors: formErrors,
          status: status ?? this.status,
          country: country ?? this.country);
}
