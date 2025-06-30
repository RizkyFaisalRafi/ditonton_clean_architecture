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


class InitialWatchlistTv implements WatchlistTvState {
  const InitialWatchlistTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialWatchlistTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistTvState.initialWatchlistTv()';
}


}




/// @nodoc


class LoadingWatchlistTv implements WatchlistTvState {
  const LoadingWatchlistTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingWatchlistTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistTvState.loadingWatchlistTv()';
}


}




/// @nodoc


class LoadedWatchlistTv implements WatchlistTvState {
  const LoadedWatchlistTv({required final  List<TvSeries> watchlistTv}): _watchlistTv = watchlistTv;
  

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
$LoadedWatchlistTvCopyWith<LoadedWatchlistTv> get copyWith => _$LoadedWatchlistTvCopyWithImpl<LoadedWatchlistTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedWatchlistTv&&const DeepCollectionEquality().equals(other._watchlistTv, _watchlistTv));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_watchlistTv));

@override
String toString() {
  return 'WatchlistTvState.loadedWatchlistTv(watchlistTv: $watchlistTv)';
}


}

/// @nodoc
abstract mixin class $LoadedWatchlistTvCopyWith<$Res> implements $WatchlistTvStateCopyWith<$Res> {
  factory $LoadedWatchlistTvCopyWith(LoadedWatchlistTv value, $Res Function(LoadedWatchlistTv) _then) = _$LoadedWatchlistTvCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> watchlistTv
});




}
/// @nodoc
class _$LoadedWatchlistTvCopyWithImpl<$Res>
    implements $LoadedWatchlistTvCopyWith<$Res> {
  _$LoadedWatchlistTvCopyWithImpl(this._self, this._then);

  final LoadedWatchlistTv _self;
  final $Res Function(LoadedWatchlistTv) _then;

/// Create a copy of WatchlistTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? watchlistTv = null,}) {
  return _then(LoadedWatchlistTv(
watchlistTv: null == watchlistTv ? _self._watchlistTv : watchlistTv // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,
  ));
}


}

/// @nodoc


class ErrorWatchlistTv implements WatchlistTvState {
  const ErrorWatchlistTv(this.message);
  

 final  String message;

/// Create a copy of WatchlistTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorWatchlistTvCopyWith<ErrorWatchlistTv> get copyWith => _$ErrorWatchlistTvCopyWithImpl<ErrorWatchlistTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorWatchlistTv&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WatchlistTvState.errorWatchlistTv(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorWatchlistTvCopyWith<$Res> implements $WatchlistTvStateCopyWith<$Res> {
  factory $ErrorWatchlistTvCopyWith(ErrorWatchlistTv value, $Res Function(ErrorWatchlistTv) _then) = _$ErrorWatchlistTvCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorWatchlistTvCopyWithImpl<$Res>
    implements $ErrorWatchlistTvCopyWith<$Res> {
  _$ErrorWatchlistTvCopyWithImpl(this._self, this._then);

  final ErrorWatchlistTv _self;
  final $Res Function(ErrorWatchlistTv) _then;

/// Create a copy of WatchlistTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorWatchlistTv(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
