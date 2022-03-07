// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'ThumbNailEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ThumbNailEventTearOff {
  const _$ThumbNailEventTearOff();

  GetThumb getThumbNail(String youtubeUrl) {
    return GetThumb(
      youtubeUrl,
    );
  }
}

/// @nodoc
const $ThumbNailEvent = _$ThumbNailEventTearOff();

/// @nodoc
mixin _$ThumbNailEvent {
  String get youtubeUrl => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String youtubeUrl) getThumbNail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String youtubeUrl)? getThumbNail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetThumb value) getThumbNail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetThumb value)? getThumbNail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThumbNailEventCopyWith<ThumbNailEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThumbNailEventCopyWith<$Res> {
  factory $ThumbNailEventCopyWith(
          ThumbNailEvent value, $Res Function(ThumbNailEvent) then) =
      _$ThumbNailEventCopyWithImpl<$Res>;
  $Res call({String youtubeUrl});
}

/// @nodoc
class _$ThumbNailEventCopyWithImpl<$Res>
    implements $ThumbNailEventCopyWith<$Res> {
  _$ThumbNailEventCopyWithImpl(this._value, this._then);

  final ThumbNailEvent _value;
  // ignore: unused_field
  final $Res Function(ThumbNailEvent) _then;

  @override
  $Res call({
    Object? youtubeUrl = freezed,
  }) {
    return _then(_value.copyWith(
      youtubeUrl: youtubeUrl == freezed
          ? _value.youtubeUrl
          : youtubeUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $GetThumbCopyWith<$Res>
    implements $ThumbNailEventCopyWith<$Res> {
  factory $GetThumbCopyWith(GetThumb value, $Res Function(GetThumb) then) =
      _$GetThumbCopyWithImpl<$Res>;
  @override
  $Res call({String youtubeUrl});
}

/// @nodoc
class _$GetThumbCopyWithImpl<$Res> extends _$ThumbNailEventCopyWithImpl<$Res>
    implements $GetThumbCopyWith<$Res> {
  _$GetThumbCopyWithImpl(GetThumb _value, $Res Function(GetThumb) _then)
      : super(_value, (v) => _then(v as GetThumb));

  @override
  GetThumb get _value => super._value as GetThumb;

  @override
  $Res call({
    Object? youtubeUrl = freezed,
  }) {
    return _then(GetThumb(
      youtubeUrl == freezed
          ? _value.youtubeUrl
          : youtubeUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$GetThumb implements GetThumb {
  const _$GetThumb(this.youtubeUrl);

  @override
  final String youtubeUrl;

  @override
  String toString() {
    return 'ThumbNailEvent.getThumbNail(youtubeUrl: $youtubeUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GetThumb &&
            (identical(other.youtubeUrl, youtubeUrl) ||
                const DeepCollectionEquality()
                    .equals(other.youtubeUrl, youtubeUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(youtubeUrl);

  @JsonKey(ignore: true)
  @override
  $GetThumbCopyWith<GetThumb> get copyWith =>
      _$GetThumbCopyWithImpl<GetThumb>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String youtubeUrl) getThumbNail,
  }) {
    return getThumbNail(youtubeUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String youtubeUrl)? getThumbNail,
    required TResult orElse(),
  }) {
    if (getThumbNail != null) {
      return getThumbNail(youtubeUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetThumb value) getThumbNail,
  }) {
    return getThumbNail(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetThumb value)? getThumbNail,
    required TResult orElse(),
  }) {
    if (getThumbNail != null) {
      return getThumbNail(this);
    }
    return orElse();
  }
}

abstract class GetThumb implements ThumbNailEvent {
  const factory GetThumb(String youtubeUrl) = _$GetThumb;

  @override
  String get youtubeUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  $GetThumbCopyWith<GetThumb> get copyWith =>
      throw _privateConstructorUsedError;
}
