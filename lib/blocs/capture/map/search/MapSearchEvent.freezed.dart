// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'MapSearchEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MapSearchEventTearOff {
  const _$MapSearchEventTearOff();

  GetPlaces getPlaces(String keyword) {
    return GetPlaces(
      keyword,
    );
  }

  GetExactPlaces getExactPlaces(double latitude, double longitude) {
    return GetExactPlaces(
      latitude,
      longitude,
    );
  }

  Resettings reset() {
    return const Resettings();
  }
}

/// @nodoc
const $MapSearchEvent = _$MapSearchEventTearOff();

/// @nodoc
mixin _$MapSearchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String keyword) getPlaces,
    required TResult Function(double latitude, double longitude) getExactPlaces,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String keyword)? getPlaces,
    TResult Function(double latitude, double longitude)? getExactPlaces,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetPlaces value) getPlaces,
    required TResult Function(GetExactPlaces value) getExactPlaces,
    required TResult Function(Resettings value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetPlaces value)? getPlaces,
    TResult Function(GetExactPlaces value)? getExactPlaces,
    TResult Function(Resettings value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapSearchEventCopyWith<$Res> {
  factory $MapSearchEventCopyWith(
          MapSearchEvent value, $Res Function(MapSearchEvent) then) =
      _$MapSearchEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$MapSearchEventCopyWithImpl<$Res>
    implements $MapSearchEventCopyWith<$Res> {
  _$MapSearchEventCopyWithImpl(this._value, this._then);

  final MapSearchEvent _value;
  // ignore: unused_field
  final $Res Function(MapSearchEvent) _then;
}

/// @nodoc
abstract class $GetPlacesCopyWith<$Res> {
  factory $GetPlacesCopyWith(GetPlaces value, $Res Function(GetPlaces) then) =
      _$GetPlacesCopyWithImpl<$Res>;
  $Res call({String keyword});
}

/// @nodoc
class _$GetPlacesCopyWithImpl<$Res> extends _$MapSearchEventCopyWithImpl<$Res>
    implements $GetPlacesCopyWith<$Res> {
  _$GetPlacesCopyWithImpl(GetPlaces _value, $Res Function(GetPlaces) _then)
      : super(_value, (v) => _then(v as GetPlaces));

  @override
  GetPlaces get _value => super._value as GetPlaces;

  @override
  $Res call({
    Object? keyword = freezed,
  }) {
    return _then(GetPlaces(
      keyword == freezed
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$GetPlaces implements GetPlaces {
  const _$GetPlaces(this.keyword);

  @override
  final String keyword;

  @override
  String toString() {
    return 'MapSearchEvent.getPlaces(keyword: $keyword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetPlaces &&
            (identical(other.keyword, keyword) ||
                const DeepCollectionEquality().equals(other.keyword, keyword)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(keyword);

  @JsonKey(ignore: true)
  @override
  $GetPlacesCopyWith<GetPlaces> get copyWith =>
      _$GetPlacesCopyWithImpl<GetPlaces>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String keyword) getPlaces,
    required TResult Function(double latitude, double longitude) getExactPlaces,
    required TResult Function() reset,
  }) {
    return getPlaces(keyword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String keyword)? getPlaces,
    TResult Function(double latitude, double longitude)? getExactPlaces,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (getPlaces != null) {
      return getPlaces(keyword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetPlaces value) getPlaces,
    required TResult Function(GetExactPlaces value) getExactPlaces,
    required TResult Function(Resettings value) reset,
  }) {
    return getPlaces(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetPlaces value)? getPlaces,
    TResult Function(GetExactPlaces value)? getExactPlaces,
    TResult Function(Resettings value)? reset,
    required TResult orElse(),
  }) {
    if (getPlaces != null) {
      return getPlaces(this);
    }
    return orElse();
  }
}

abstract class GetPlaces implements MapSearchEvent {
  const factory GetPlaces(String keyword) = _$GetPlaces;

  String get keyword => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPlacesCopyWith<GetPlaces> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetExactPlacesCopyWith<$Res> {
  factory $GetExactPlacesCopyWith(
          GetExactPlaces value, $Res Function(GetExactPlaces) then) =
      _$GetExactPlacesCopyWithImpl<$Res>;
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$GetExactPlacesCopyWithImpl<$Res>
    extends _$MapSearchEventCopyWithImpl<$Res>
    implements $GetExactPlacesCopyWith<$Res> {
  _$GetExactPlacesCopyWithImpl(
      GetExactPlaces _value, $Res Function(GetExactPlaces) _then)
      : super(_value, (v) => _then(v as GetExactPlaces));

  @override
  GetExactPlaces get _value => super._value as GetExactPlaces;

  @override
  $Res call({
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(GetExactPlaces(
      latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
class _$GetExactPlaces implements GetExactPlaces {
  const _$GetExactPlaces(this.latitude, this.longitude);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'MapSearchEvent.getExactPlaces(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetExactPlaces &&
            (identical(other.latitude, latitude) ||
                const DeepCollectionEquality()
                    .equals(other.latitude, latitude)) &&
            (identical(other.longitude, longitude) ||
                const DeepCollectionEquality()
                    .equals(other.longitude, longitude)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(latitude) ^
      const DeepCollectionEquality().hash(longitude);

  @JsonKey(ignore: true)
  @override
  $GetExactPlacesCopyWith<GetExactPlaces> get copyWith =>
      _$GetExactPlacesCopyWithImpl<GetExactPlaces>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String keyword) getPlaces,
    required TResult Function(double latitude, double longitude) getExactPlaces,
    required TResult Function() reset,
  }) {
    return getExactPlaces(latitude, longitude);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String keyword)? getPlaces,
    TResult Function(double latitude, double longitude)? getExactPlaces,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (getExactPlaces != null) {
      return getExactPlaces(latitude, longitude);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetPlaces value) getPlaces,
    required TResult Function(GetExactPlaces value) getExactPlaces,
    required TResult Function(Resettings value) reset,
  }) {
    return getExactPlaces(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetPlaces value)? getPlaces,
    TResult Function(GetExactPlaces value)? getExactPlaces,
    TResult Function(Resettings value)? reset,
    required TResult orElse(),
  }) {
    if (getExactPlaces != null) {
      return getExactPlaces(this);
    }
    return orElse();
  }
}

abstract class GetExactPlaces implements MapSearchEvent {
  const factory GetExactPlaces(double latitude, double longitude) =
      _$GetExactPlaces;

  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetExactPlacesCopyWith<GetExactPlaces> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResettingsCopyWith<$Res> {
  factory $ResettingsCopyWith(
          Resettings value, $Res Function(Resettings) then) =
      _$ResettingsCopyWithImpl<$Res>;
}

/// @nodoc
class _$ResettingsCopyWithImpl<$Res> extends _$MapSearchEventCopyWithImpl<$Res>
    implements $ResettingsCopyWith<$Res> {
  _$ResettingsCopyWithImpl(Resettings _value, $Res Function(Resettings) _then)
      : super(_value, (v) => _then(v as Resettings));

  @override
  Resettings get _value => super._value as Resettings;
}

/// @nodoc
class _$Resettings implements Resettings {
  const _$Resettings();

  @override
  String toString() {
    return 'MapSearchEvent.reset()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Resettings);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String keyword) getPlaces,
    required TResult Function(double latitude, double longitude) getExactPlaces,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String keyword)? getPlaces,
    TResult Function(double latitude, double longitude)? getExactPlaces,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetPlaces value) getPlaces,
    required TResult Function(GetExactPlaces value) getExactPlaces,
    required TResult Function(Resettings value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetPlaces value)? getPlaces,
    TResult Function(GetExactPlaces value)? getExactPlaces,
    TResult Function(Resettings value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class Resettings implements MapSearchEvent {
  const factory Resettings() = _$Resettings;
}
