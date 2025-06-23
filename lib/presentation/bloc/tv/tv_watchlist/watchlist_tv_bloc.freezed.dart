// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistTvEvent()';
}


}

/// @nodoc
class $WatchlistTvEventCopyWith<$Res>  {
$WatchlistTvEventCopyWith(WatchlistTvEvent _, $Res Function(WatchlistTvEvent) __);
}


/// @nodoc


class FetchInitialWatchlistTv implements WatchlistTvEvent {
  const FetchInitialWatchlistTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialWatchlistTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistTvEvent.fetchInitialWatchlistTv()';
}


}




/// @nodoc
mixin _$WatchlistTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistTvState()';
}


}

/// @nodoc
class $WatchlistTvStateCopyWith<$Res>  {
$WatchlistTvStateCopyWith(WatchlistTvState _, $Res Function(WatchlistTvState) __);
}


/// @nodoc


class Initial implements WatchlistTvState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistTvState.initial()';
}


}




/// @nodoc


class Loading implements WatchlistTvState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistTvState.loading()';
}


}




/// @nodoc


class Loaded implements WatchlistTvState {
  const Loaded({required final  List<TvSeries> watchlistTv}): _watchlistTv = watchlistTv;
  

// Data List Watchlist
 final  List<TvSeries> _watchlistTv;
// Data List Watchlist
 List<TvSeries> get watchlistTv {
  if (_watchlistTv is EqualUnmodifiableListView) return _watchlistTv;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchlistTv);
}


/// Create a copy of WatchlistTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._watchlistTv, _watchlistTv));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_watchlistTv));

@override
String toString() {
  return 'WatchlistTvState.loaded(watchlistTv: $watchlistTv)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $WatchlistTvStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> watchlistTv
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of WatchlistTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? watchlistTv = null,}) {
  return _then(Loaded(
watchlistTv: null == watchlistTv ? _self._watchlistTv : watchlistTv // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,
  ));
}


}

/// @nodoc


class Error implements WatchlistTvState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of WatchlistTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WatchlistTvState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $WatchlistTvStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of WatchlistTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
