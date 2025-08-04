// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [WatchlistMovieEvent].
extension WatchlistMovieEventPatterns on WatchlistMovieEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchInitialWatchlistMovies value)?  fetchInitialWatchlistMovies,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchInitialWatchlistMovies() when fetchInitialWatchlistMovies != null:
return fetchInitialWatchlistMovies(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchInitialWatchlistMovies value)  fetchInitialWatchlistMovies,}){
final _that = this;
switch (_that) {
case FetchInitialWatchlistMovies():
return fetchInitialWatchlistMovies(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchInitialWatchlistMovies value)?  fetchInitialWatchlistMovies,}){
final _that = this;
switch (_that) {
case FetchInitialWatchlistMovies() when fetchInitialWatchlistMovies != null:
return fetchInitialWatchlistMovies(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchInitialWatchlistMovies,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchInitialWatchlistMovies() when fetchInitialWatchlistMovies != null:
return fetchInitialWatchlistMovies();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchInitialWatchlistMovies,}) {final _that = this;
switch (_that) {
case FetchInitialWatchlistMovies():
return fetchInitialWatchlistMovies();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchInitialWatchlistMovies,}) {final _that = this;
switch (_that) {
case FetchInitialWatchlistMovies() when fetchInitialWatchlistMovies != null:
return fetchInitialWatchlistMovies();case _:
  return null;

}
}

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


/// Adds pattern-matching-related methods to [WatchlistMovieState].
extension WatchlistMovieStatePatterns on WatchlistMovieState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialWatchlistMovie value)?  initialWatchlistMovie,TResult Function( LoadingWatchlistMovie value)?  loadingWatchlistMovie,TResult Function( LoadedWatchlistMovie value)?  loadedWatchlistMovie,TResult Function( ErrorWatchlistMovie value)?  errorWatchlistMovie,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialWatchlistMovie() when initialWatchlistMovie != null:
return initialWatchlistMovie(_that);case LoadingWatchlistMovie() when loadingWatchlistMovie != null:
return loadingWatchlistMovie(_that);case LoadedWatchlistMovie() when loadedWatchlistMovie != null:
return loadedWatchlistMovie(_that);case ErrorWatchlistMovie() when errorWatchlistMovie != null:
return errorWatchlistMovie(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialWatchlistMovie value)  initialWatchlistMovie,required TResult Function( LoadingWatchlistMovie value)  loadingWatchlistMovie,required TResult Function( LoadedWatchlistMovie value)  loadedWatchlistMovie,required TResult Function( ErrorWatchlistMovie value)  errorWatchlistMovie,}){
final _that = this;
switch (_that) {
case InitialWatchlistMovie():
return initialWatchlistMovie(_that);case LoadingWatchlistMovie():
return loadingWatchlistMovie(_that);case LoadedWatchlistMovie():
return loadedWatchlistMovie(_that);case ErrorWatchlistMovie():
return errorWatchlistMovie(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialWatchlistMovie value)?  initialWatchlistMovie,TResult? Function( LoadingWatchlistMovie value)?  loadingWatchlistMovie,TResult? Function( LoadedWatchlistMovie value)?  loadedWatchlistMovie,TResult? Function( ErrorWatchlistMovie value)?  errorWatchlistMovie,}){
final _that = this;
switch (_that) {
case InitialWatchlistMovie() when initialWatchlistMovie != null:
return initialWatchlistMovie(_that);case LoadingWatchlistMovie() when loadingWatchlistMovie != null:
return loadingWatchlistMovie(_that);case LoadedWatchlistMovie() when loadedWatchlistMovie != null:
return loadedWatchlistMovie(_that);case ErrorWatchlistMovie() when errorWatchlistMovie != null:
return errorWatchlistMovie(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialWatchlistMovie,TResult Function()?  loadingWatchlistMovie,TResult Function( List<Movie> watchlistMovie)?  loadedWatchlistMovie,TResult Function( String message)?  errorWatchlistMovie,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialWatchlistMovie() when initialWatchlistMovie != null:
return initialWatchlistMovie();case LoadingWatchlistMovie() when loadingWatchlistMovie != null:
return loadingWatchlistMovie();case LoadedWatchlistMovie() when loadedWatchlistMovie != null:
return loadedWatchlistMovie(_that.watchlistMovie);case ErrorWatchlistMovie() when errorWatchlistMovie != null:
return errorWatchlistMovie(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialWatchlistMovie,required TResult Function()  loadingWatchlistMovie,required TResult Function( List<Movie> watchlistMovie)  loadedWatchlistMovie,required TResult Function( String message)  errorWatchlistMovie,}) {final _that = this;
switch (_that) {
case InitialWatchlistMovie():
return initialWatchlistMovie();case LoadingWatchlistMovie():
return loadingWatchlistMovie();case LoadedWatchlistMovie():
return loadedWatchlistMovie(_that.watchlistMovie);case ErrorWatchlistMovie():
return errorWatchlistMovie(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialWatchlistMovie,TResult? Function()?  loadingWatchlistMovie,TResult? Function( List<Movie> watchlistMovie)?  loadedWatchlistMovie,TResult? Function( String message)?  errorWatchlistMovie,}) {final _that = this;
switch (_that) {
case InitialWatchlistMovie() when initialWatchlistMovie != null:
return initialWatchlistMovie();case LoadingWatchlistMovie() when loadingWatchlistMovie != null:
return loadingWatchlistMovie();case LoadedWatchlistMovie() when loadedWatchlistMovie != null:
return loadedWatchlistMovie(_that.watchlistMovie);case ErrorWatchlistMovie() when errorWatchlistMovie != null:
return errorWatchlistMovie(_that.message);case _:
  return null;

}
}

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
