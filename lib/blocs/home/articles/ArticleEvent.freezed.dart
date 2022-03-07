// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'ArticleEvent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ArticleEventTearOff {
  const _$ArticleEventTearOff();

  GetFeed getFeed() {
    return const GetFeed();
  }
}

/// @nodoc
const $ArticleEvent = _$ArticleEventTearOff();

/// @nodoc
mixin _$ArticleEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getFeed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getFeed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetFeed value) getFeed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetFeed value)? getFeed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleEventCopyWith<$Res> {
  factory $ArticleEventCopyWith(
          ArticleEvent value, $Res Function(ArticleEvent) then) =
      _$ArticleEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ArticleEventCopyWithImpl<$Res> implements $ArticleEventCopyWith<$Res> {
  _$ArticleEventCopyWithImpl(this._value, this._then);

  final ArticleEvent _value;
  // ignore: unused_field
  final $Res Function(ArticleEvent) _then;
}

/// @nodoc
abstract class $GetFeedCopyWith<$Res> {
  factory $GetFeedCopyWith(GetFeed value, $Res Function(GetFeed) then) =
      _$GetFeedCopyWithImpl<$Res>;
}

/// @nodoc
class _$GetFeedCopyWithImpl<$Res> extends _$ArticleEventCopyWithImpl<$Res>
    implements $GetFeedCopyWith<$Res> {
  _$GetFeedCopyWithImpl(GetFeed _value, $Res Function(GetFeed) _then)
      : super(_value, (v) => _then(v as GetFeed));

  @override
  GetFeed get _value => super._value as GetFeed;
}

/// @nodoc
class _$GetFeed implements GetFeed {
  const _$GetFeed();

  @override
  String toString() {
    return 'ArticleEvent.getFeed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is GetFeed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() getFeed,
  }) {
    return getFeed();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? getFeed,
    required TResult orElse(),
  }) {
    if (getFeed != null) {
      return getFeed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GetFeed value) getFeed,
  }) {
    return getFeed(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GetFeed value)? getFeed,
    required TResult orElse(),
  }) {
    if (getFeed != null) {
      return getFeed(this);
    }
    return orElse();
  }
}

abstract class GetFeed implements ArticleEvent {
  const factory GetFeed() = _$GetFeed;
}
