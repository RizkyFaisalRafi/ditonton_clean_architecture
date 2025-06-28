// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_movie_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistMovieEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistMovieEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistMovieEvent()';
}


}

/// @nodoc
class $WatchlistMovieEventCopyWith<$Res>  {
$WatchlistMovieEventCopyWith(WatchlistMovieEvent _, $Res Function(WatchlistMovieEvent) __);
}


/// @nodoc


class FetchInitialWatchlistMovies implements WatchlistMovieEvent {
  const FetchInitialWatchlistMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialWatchlistMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistMovieEvent.fetchInitialWatchlistMovies()';
}


}




/// @nodoc
mixin _$WatchlistMovieState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistMovieState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistMovieState()';
}


}

/// @nodoc
class $WatchlistMovieStateCopyWith<$Res>  {
$WatchlistMovieStateCopyWith(WatchlistMovieState _, $Res Function(WatchlistMovieState) __);
}


/// @nodoc


class InitialWatchlistMovie implements WatchlistMovieState {
  const InitialWatchlistMovie();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialWatchlistMovie);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistMovieState.initialWatchlistMovie()';
}


}




/// @nodoc


class LoadingWatchlistMovie implements WatchlistMovieState {
  const LoadingWatchlistMovie();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingWatchlistMovie);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistMovieState.loadingWatchlistMovie()';
}


}




/// @nodoc


class LoadedWatchlistMovie implements WatchlistMovieState {
  const LoadedWatchlistMovie({required final  List<Movie> watchlistMovie}): _watchlistMovie = watchlistMovie;
  

// Data List Watchlist
 final  List<Movie> _watchlistMovie;
// Data List Watchlist
 List<Movie> get watchlistMovie {
  if (_watchlistMovie is EqualUnmodifiableListView) return _watchlistMovie;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchlistMovie);
}


/// Create a copy of WatchlistMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedWatchlistMovieCopyWith<LoadedWatchlistMovie> get copyWith => _$LoadedWatchlistMovieCopyWithImpl<LoadedWatchlistMovie>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedWatchlistMovie&&const DeepCollectionEquality().equals(other._watchlistMovie, _watchlistMovie));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_watchlistMovie));

@override
String toString() {
  return 'WatchlistMovieState.loadedWatchlistMovie(watchlistMovie: $watchlistMovie)';
}


}

/// @nodoc
abstract mixin class $LoadedWatchlistMovieCopyWith<$Res> implements $WatchlistMovieStateCopyWith<$Res> {
  factory $LoadedWatchlistMovieCopyWith(LoadedWatchlistMovie value, $Res Function(LoadedWatchlistMovie) _then) = _$LoadedWatchlistMovieCopyWithImpl;
@useResult
$Res call({
 List<Movie> watchlistMovie
});




}
/// @nodoc
class _$LoadedWatchlistMovieCopyWithImpl<$Res>
    implements $LoadedWatchlistMovieCopyWith<$Res> {
  _$LoadedWatchlistMovieCopyWithImpl(this._self, this._then);

  final LoadedWatchlistMovie _self;
  final $Res Function(LoadedWatchlistMovie) _then;

/// Create a copy of WatchlistMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? watchlistMovie = null,}) {
  return _then(LoadedWatchlistMovie(
watchlistMovie: null == watchlistMovie ? _self._watchlistMovie : watchlistMovie // ignore: cast_nullable_to_non_nullable
as List<Movie>,
  ));
}


}

/// @nodoc


class ErrorWatchlistMovie implements WatchlistMovieState {
  const ErrorWatchlistMovie(this.message);
  

 final  String message;

/// Create a copy of WatchlistMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorWatchlistMovieCopyWith<ErrorWatchlistMovie> get copyWith => _$ErrorWatchlistMovieCopyWithImpl<ErrorWatchlistMovie>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorWatchlistMovie&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WatchlistMovieState.errorWatchlistMovie(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorWatchlistMovieCopyWith<$Res> implements $WatchlistMovieStateCopyWith<$Res> {
  factory $ErrorWatchlistMovieCopyWith(ErrorWatchlistMovie value, $Res Function(ErrorWatchlistMovie) _then) = _$ErrorWatchlistMovieCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorWatchlistMovieCopyWithImpl<$Res>
    implements $ErrorWatchlistMovieCopyWith<$Res> {
  _$ErrorWatchlistMovieCopyWithImpl(this._self, this._then);

  final ErrorWatchlistMovie _self;
  final $Res Function(ErrorWatchlistMovie) _then;

/// Create a copy of WatchlistMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorWatchlistMovie(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
