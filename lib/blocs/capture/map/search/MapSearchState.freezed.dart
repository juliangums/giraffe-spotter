// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'MapSearchState.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MapSearchStateTearOff {
  const _$MapSearchStateTearOff();

  Idle idle() {
    return const Idle();
  }

  Loading loading() {
    return const Loading();
  }

  GetPlacesDone getPlacesDone(List<PlacesSearchResult> data) {
    return GetPlacesDone(
      data,
    );
  }

  GetExactPlacesDone getExactPlacesDone(List<MapBoxPlace>? data) {
    return GetExactPlacesDone(
      data,
    );
  }

  Error error(NetworkExceptions error) {
    return Error(
      error,
    );
  }
}

/// @nodoc
const $MapSearchState = _$MapSearchStateTearOff();

/// @nodoc
mixin _$MapSearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<PlacesSearchResult> data) getPlacesDone,
    required TResult Function(List<MapBoxPlace>? data) getExactPlacesDone,
    required TResult Function(NetworkExceptions error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<PlacesSearchResult> data)? getPlacesDone,
    TResult Function(List<MapBoxPlace>? data)? getExactPlacesDone,
    TResult Function(NetworkExceptions error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(GetPlacesDone value) getPlacesDone,
    required TResult Function(GetExactPlacesDone value) getExactPlacesDone,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(GetPlacesDone value)? getPlacesDone,
    TResult Function(GetExactPlacesDone value)? getExactPlacesDone,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapSearchStateCopyWith<$Res> {
  factory $MapSearchStateCopyWith(
          MapSearchState value, $Res Function(MapSearchState) then) =
      _$MapSearchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MapSearchStateCopyWithImpl<$Res>
    implements $MapSearchStateCopyWith<$Res> {
  _$MapSearchStateCopyWithImpl(this._value, this._then);

  final MapSearchState _value;
  // ignore: unused_field
  final $Res Function(MapSearchState) _then;
}

/// @nodoc
abstract class $IdleCopyWith<$Res> {
  factory $IdleCopyWith(Idle value, $Res Function(Idle) then) =
      _$IdleCopyWithImpl<$Res>;
}

/// @nodoc
class _$IdleCopyWithImpl<$Res> extends _$MapSearchStateCopyWithImpl<$Res>
    implements $IdleCopyWith<$Res> {
  _$IdleCopyWithImpl(Idle _value, $Res Function(Idle) _then)
      : super(_value, (v) => _then(v as Idle));

  @override
  Idle get _value => super._value as Idle;
}

/// @nodoc
class _$Idle implements Idle {
  const _$Idle();

  @override
  String toString() {
    return 'MapSearchState.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Idle);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<PlacesSearchResult> data) getPlacesDone,
    required TResult Function(List<MapBoxPlace>? data) getExactPlacesDone,
    required TResult Function(NetworkExceptions error) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<PlacesSearchResult> data)? getPlacesDone,
    TResult Function(List<MapBoxPlace>? data)? getExactPlacesDone,
    TResult Function(NetworkExceptions error)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(GetPlacesDone value) getPlacesDone,
    required TResult Function(GetExactPlacesDone value) getExactPlacesDone,
    required TResult Function(Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(GetPlacesDone value)? getPlacesDone,
    TResult Function(GetExactPlacesDone value)? getExactPlacesDone,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class Idle implements MapSearchState {
  const factory Idle() = _$Idle;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$MapSearchStateCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

/// @nodoc
class _$Loading implements Loading {
  const _$Loading();

  @override
  String toString() {
    return 'MapSearchState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<PlacesSearchResult> data) getPlacesDone,
    required TResult Function(List<MapBoxPlace>? data) getExactPlacesDone,
    required TResult Function(NetworkExceptions error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<PlacesSearchResult> data)? getPlacesDone,
    TResult Function(List<MapBoxPlace>? data)? getExactPlacesDone,
    TResult Function(NetworkExceptions error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(GetPlacesDone value) getPlacesDone,
    required TResult Function(GetExactPlacesDone value) getExactPlacesDone,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(GetPlacesDone value)? getPlacesDone,
    TResult Function(GetExactPlacesDone value)? getExactPlacesDone,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements MapSearchState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $GetPlacesDoneCopyWith<$Res> {
  factory $GetPlacesDoneCopyWith(
          GetPlacesDone value, $Res Function(GetPlacesDone) then) =
      _$GetPlacesDoneCopyWithImpl<$Res>;
  $Res call({List<PlacesSearchResult> data});
}

/// @nodoc
class _$GetPlacesDoneCopyWithImpl<$Res>
    extends _$MapSearchStateCopyWithImpl<$Res>
    implements $GetPlacesDoneCopyWith<$Res> {
  _$GetPlacesDoneCopyWithImpl(
      GetPlacesDone _value, $Res Function(GetPlacesDone) _then)
      : super(_value, (v) => _then(v as GetPlacesDone));

  @override
  GetPlacesDone get _value => super._value as GetPlacesDone;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(GetPlacesDone(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PlacesSearchResult>,
    ));
  }
}

/// @nodoc
class _$GetPlacesDone implements GetPlacesDone {
  const _$GetPlacesDone(this.data);

  @override
  final List<PlacesSearchResult> data;

  @override
  String toString() {
    return 'MapSearchState.getPlacesDone(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetPlacesDone &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $GetPlacesDoneCopyWith<GetPlacesDone> get copyWith =>
      _$GetPlacesDoneCopyWithImpl<GetPlacesDone>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<PlacesSearchResult> data) getPlacesDone,
    required TResult Function(List<MapBoxPlace>? data) getExactPlacesDone,
    required TResult Function(NetworkExceptions error) error,
  }) {
    return getPlacesDone(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<PlacesSearchResult> data)? getPlacesDone,
    TResult Function(List<MapBoxPlace>? data)? getExactPlacesDone,
    TResult Function(NetworkExceptions error)? error,
    required TResult orElse(),
  }) {
    if (getPlacesDone != null) {
      return getPlacesDone(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(GetPlacesDone value) getPlacesDone,
    required TResult Function(GetExactPlacesDone value) getExactPlacesDone,
    required TResult Function(Error value) error,
  }) {
    return getPlacesDone(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(GetPlacesDone value)? getPlacesDone,
    TResult Function(GetExactPlacesDone value)? getExactPlacesDone,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (getPlacesDone != null) {
      return getPlacesDone(this);
    }
    return orElse();
  }
}

abstract class GetPlacesDone implements MapSearchState {
  const factory GetPlacesDone(List<PlacesSearchResult> data) = _$GetPlacesDone;

  List<PlacesSearchResult> get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPlacesDoneCopyWith<GetPlacesDone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetExactPlacesDoneCopyWith<$Res> {
  factory $GetExactPlacesDoneCopyWith(
          GetExactPlacesDone value, $Res Function(GetExactPlacesDone) then) =
      _$GetExactPlacesDoneCopyWithImpl<$Res>;
  $Res call({List<MapBoxPlace>? data});
}

/// @nodoc
class _$GetExactPlacesDoneCopyWithImpl<$Res>
    extends _$MapSearchStateCopyWithImpl<$Res>
    implements $GetExactPlacesDoneCopyWith<$Res> {
  _$GetExactPlacesDoneCopyWithImpl(
      GetExactPlacesDone _value, $Res Function(GetExactPlacesDone) _then)
      : super(_value, (v) => _then(v as GetExactPlacesDone));

  @override
  GetExactPlacesDone get _value => super._value as GetExactPlacesDone;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(GetExactPlacesDone(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<MapBoxPlace>?,
    ));
  }
}

/// @nodoc
class _$GetExactPlacesDone implements GetExactPlacesDone {
  const _$GetExactPlacesDone(this.data);

  @override
  final List<MapBoxPlace>? data;

  @override
  String toString() {
    return 'MapSearchState.getExactPlacesDone(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetExactPlacesDone &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $GetExactPlacesDoneCopyWith<GetExactPlacesDone> get copyWith =>
      _$GetExactPlacesDoneCopyWithImpl<GetExactPlacesDone>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<PlacesSearchResult> data) getPlacesDone,
    required TResult Function(List<MapBoxPlace>? data) getExactPlacesDone,
    required TResult Function(NetworkExceptions error) error,
  }) {
    return getExactPlacesDone(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<PlacesSearchResult> data)? getPlacesDone,
    TResult Function(List<MapBoxPlace>? data)? getExactPlacesDone,
    TResult Function(NetworkExceptions error)? error,
    required TResult orElse(),
  }) {
    if (getExactPlacesDone != null) {
      return getExactPlacesDone(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(GetPlacesDone value) getPlacesDone,
    required TResult Function(GetExactPlacesDone value) getExactPlacesDone,
    required TResult Function(Error value) error,
  }) {
    return getExactPlacesDone(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(GetPlacesDone value)? getPlacesDone,
    TResult Function(GetExactPlacesDone value)? getExactPlacesDone,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (getExactPlacesDone != null) {
      return getExactPlacesDone(this);
    }
    return orElse();
  }
}

abstract class GetExactPlacesDone implements MapSearchState {
  const factory GetExactPlacesDone(List<MapBoxPlace>? data) =
      _$GetExactPlacesDone;

  List<MapBoxPlace>? get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetExactPlacesDoneCopyWith<GetExactPlacesDone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) then) =
      _$ErrorCopyWithImpl<$Res>;
  $Res call({NetworkExceptions error});

  $NetworkExceptionsCopyWith<$Res> get error;
}

/// @nodoc
class _$ErrorCopyWithImpl<$Res> extends _$MapSearchStateCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(Error _value, $Res Function(Error) _then)
      : super(_value, (v) => _then(v as Error));

  @override
  Error get _value => super._value as Error;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(Error(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as NetworkExceptions,
    ));
  }

  @override
  $NetworkExceptionsCopyWith<$Res> get error {
    return $NetworkExceptionsCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc
class _$Error implements Error {
  const _$Error(this.error);

  @override
  final NetworkExceptions error;

  @override
  String toString() {
    return 'MapSearchState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<Error> get copyWith =>
      _$ErrorCopyWithImpl<Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(List<PlacesSearchResult> data) getPlacesDone,
    required TResult Function(List<MapBoxPlace>? data) getExactPlacesDone,
    required TResult Function(NetworkExceptions error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(List<PlacesSearchResult> data)? getPlacesDone,
    TResult Function(List<MapBoxPlace>? data)? getExactPlacesDone,
    TResult Function(NetworkExceptions error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(Loading value) loading,
    required TResult Function(GetPlacesDone value) getPlacesDone,
    required TResult Function(GetExactPlacesDone value) getExactPlacesDone,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(Loading value)? loading,
    TResult Function(GetPlacesDone value)? getPlacesDone,
    TResult Function(GetExactPlacesDone value)? getExactPlacesDone,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements MapSearchState {
  const factory Error(NetworkExceptions error) = _$Error;

  NetworkExceptions get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<Error> get copyWith => throw _privateConstructorUsedError;
}
