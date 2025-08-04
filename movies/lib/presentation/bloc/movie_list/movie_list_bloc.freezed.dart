// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieListEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListEvent()';
}


}

/// @nodoc
class $MovieListEventCopyWith<$Res>  {
$MovieListEventCopyWith(MovieListEvent _, $Res Function(MovieListEvent) __);
}


/// Adds pattern-matching-related methods to [MovieListEvent].
extension MovieListEventPatterns on MovieListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchInitialMovies value)?  fetchInitialMovies,TResult Function( FetchMoreNowPlayingMovies value)?  fetchMoreNowPlayingMovies,TResult Function( FetchMorePopularMovies value)?  fetchMorePopularMovies,TResult Function( FetchMoreTopRatedMovies value)?  fetchMoreTopRatedMovies,TResult Function( FetchMoreUpcomingMovies value)?  fetchMoreUpcomingMovies,TResult Function( RefreshMovies value)?  refreshMovies,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchInitialMovies() when fetchInitialMovies != null:
return fetchInitialMovies(_that);case FetchMoreNowPlayingMovies() when fetchMoreNowPlayingMovies != null:
return fetchMoreNowPlayingMovies(_that);case FetchMorePopularMovies() when fetchMorePopularMovies != null:
return fetchMorePopularMovies(_that);case FetchMoreTopRatedMovies() when fetchMoreTopRatedMovies != null:
return fetchMoreTopRatedMovies(_that);case FetchMoreUpcomingMovies() when fetchMoreUpcomingMovies != null:
return fetchMoreUpcomingMovies(_that);case RefreshMovies() when refreshMovies != null:
return refreshMovies(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchInitialMovies value)  fetchInitialMovies,required TResult Function( FetchMoreNowPlayingMovies value)  fetchMoreNowPlayingMovies,required TResult Function( FetchMorePopularMovies value)  fetchMorePopularMovies,required TResult Function( FetchMoreTopRatedMovies value)  fetchMoreTopRatedMovies,required TResult Function( FetchMoreUpcomingMovies value)  fetchMoreUpcomingMovies,required TResult Function( RefreshMovies value)  refreshMovies,}){
final _that = this;
switch (_that) {
case FetchInitialMovies():
return fetchInitialMovies(_that);case FetchMoreNowPlayingMovies():
return fetchMoreNowPlayingMovies(_that);case FetchMorePopularMovies():
return fetchMorePopularMovies(_that);case FetchMoreTopRatedMovies():
return fetchMoreTopRatedMovies(_that);case FetchMoreUpcomingMovies():
return fetchMoreUpcomingMovies(_that);case RefreshMovies():
return refreshMovies(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchInitialMovies value)?  fetchInitialMovies,TResult? Function( FetchMoreNowPlayingMovies value)?  fetchMoreNowPlayingMovies,TResult? Function( FetchMorePopularMovies value)?  fetchMorePopularMovies,TResult? Function( FetchMoreTopRatedMovies value)?  fetchMoreTopRatedMovies,TResult? Function( FetchMoreUpcomingMovies value)?  fetchMoreUpcomingMovies,TResult? Function( RefreshMovies value)?  refreshMovies,}){
final _that = this;
switch (_that) {
case FetchInitialMovies() when fetchInitialMovies != null:
return fetchInitialMovies(_that);case FetchMoreNowPlayingMovies() when fetchMoreNowPlayingMovies != null:
return fetchMoreNowPlayingMovies(_that);case FetchMorePopularMovies() when fetchMorePopularMovies != null:
return fetchMorePopularMovies(_that);case FetchMoreTopRatedMovies() when fetchMoreTopRatedMovies != null:
return fetchMoreTopRatedMovies(_that);case FetchMoreUpcomingMovies() when fetchMoreUpcomingMovies != null:
return fetchMoreUpcomingMovies(_that);case RefreshMovies() when refreshMovies != null:
return refreshMovies(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchInitialMovies,TResult Function()?  fetchMoreNowPlayingMovies,TResult Function()?  fetchMorePopularMovies,TResult Function()?  fetchMoreTopRatedMovies,TResult Function()?  fetchMoreUpcomingMovies,TResult Function()?  refreshMovies,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchInitialMovies() when fetchInitialMovies != null:
return fetchInitialMovies();case FetchMoreNowPlayingMovies() when fetchMoreNowPlayingMovies != null:
return fetchMoreNowPlayingMovies();case FetchMorePopularMovies() when fetchMorePopularMovies != null:
return fetchMorePopularMovies();case FetchMoreTopRatedMovies() when fetchMoreTopRatedMovies != null:
return fetchMoreTopRatedMovies();case FetchMoreUpcomingMovies() when fetchMoreUpcomingMovies != null:
return fetchMoreUpcomingMovies();case RefreshMovies() when refreshMovies != null:
return refreshMovies();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchInitialMovies,required TResult Function()  fetchMoreNowPlayingMovies,required TResult Function()  fetchMorePopularMovies,required TResult Function()  fetchMoreTopRatedMovies,required TResult Function()  fetchMoreUpcomingMovies,required TResult Function()  refreshMovies,}) {final _that = this;
switch (_that) {
case FetchInitialMovies():
return fetchInitialMovies();case FetchMoreNowPlayingMovies():
return fetchMoreNowPlayingMovies();case FetchMorePopularMovies():
return fetchMorePopularMovies();case FetchMoreTopRatedMovies():
return fetchMoreTopRatedMovies();case FetchMoreUpcomingMovies():
return fetchMoreUpcomingMovies();case RefreshMovies():
return refreshMovies();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchInitialMovies,TResult? Function()?  fetchMoreNowPlayingMovies,TResult? Function()?  fetchMorePopularMovies,TResult? Function()?  fetchMoreTopRatedMovies,TResult? Function()?  fetchMoreUpcomingMovies,TResult? Function()?  refreshMovies,}) {final _that = this;
switch (_that) {
case FetchInitialMovies() when fetchInitialMovies != null:
return fetchInitialMovies();case FetchMoreNowPlayingMovies() when fetchMoreNowPlayingMovies != null:
return fetchMoreNowPlayingMovies();case FetchMorePopularMovies() when fetchMorePopularMovies != null:
return fetchMorePopularMovies();case FetchMoreTopRatedMovies() when fetchMoreTopRatedMovies != null:
return fetchMoreTopRatedMovies();case FetchMoreUpcomingMovies() when fetchMoreUpcomingMovies != null:
return fetchMoreUpcomingMovies();case RefreshMovies() when refreshMovies != null:
return refreshMovies();case _:
  return null;

}
}

}

/// @nodoc


class FetchInitialMovies implements MovieListEvent {
  const FetchInitialMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListEvent.fetchInitialMovies()';
}


}




/// @nodoc


class FetchMoreNowPlayingMovies implements MovieListEvent {
  const FetchMoreNowPlayingMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreNowPlayingMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListEvent.fetchMoreNowPlayingMovies()';
}


}




/// @nodoc


class FetchMorePopularMovies implements MovieListEvent {
  const FetchMorePopularMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMorePopularMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListEvent.fetchMorePopularMovies()';
}


}




/// @nodoc


class FetchMoreTopRatedMovies implements MovieListEvent {
  const FetchMoreTopRatedMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreTopRatedMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListEvent.fetchMoreTopRatedMovies()';
}


}




/// @nodoc


class FetchMoreUpcomingMovies implements MovieListEvent {
  const FetchMoreUpcomingMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreUpcomingMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListEvent.fetchMoreUpcomingMovies()';
}


}




/// @nodoc


class RefreshMovies implements MovieListEvent {
  const RefreshMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListEvent.refreshMovies()';
}


}




/// @nodoc
mixin _$MovieListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListState()';
}


}

/// @nodoc
class $MovieListStateCopyWith<$Res>  {
$MovieListStateCopyWith(MovieListState _, $Res Function(MovieListState) __);
}


/// Adds pattern-matching-related methods to [MovieListState].
extension MovieListStatePatterns on MovieListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialMovieList value)?  initialMovieList,TResult Function( LoadingMovieList value)?  loadingMovieList,TResult Function( LoadedMovieList value)?  loadedMovieList,TResult Function( ErrorMovieList value)?  errorMovieList,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialMovieList() when initialMovieList != null:
return initialMovieList(_that);case LoadingMovieList() when loadingMovieList != null:
return loadingMovieList(_that);case LoadedMovieList() when loadedMovieList != null:
return loadedMovieList(_that);case ErrorMovieList() when errorMovieList != null:
return errorMovieList(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialMovieList value)  initialMovieList,required TResult Function( LoadingMovieList value)  loadingMovieList,required TResult Function( LoadedMovieList value)  loadedMovieList,required TResult Function( ErrorMovieList value)  errorMovieList,}){
final _that = this;
switch (_that) {
case InitialMovieList():
return initialMovieList(_that);case LoadingMovieList():
return loadingMovieList(_that);case LoadedMovieList():
return loadedMovieList(_that);case ErrorMovieList():
return errorMovieList(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialMovieList value)?  initialMovieList,TResult? Function( LoadingMovieList value)?  loadingMovieList,TResult? Function( LoadedMovieList value)?  loadedMovieList,TResult? Function( ErrorMovieList value)?  errorMovieList,}){
final _that = this;
switch (_that) {
case InitialMovieList() when initialMovieList != null:
return initialMovieList(_that);case LoadingMovieList() when loadingMovieList != null:
return loadingMovieList(_that);case LoadedMovieList() when loadedMovieList != null:
return loadedMovieList(_that);case ErrorMovieList() when errorMovieList != null:
return errorMovieList(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialMovieList,TResult Function()?  loadingMovieList,TResult Function( List<Movie> nowPlaying,  List<Movie> popular,  List<Movie> topRated,  List<Movie> upcoming,  int nowPlayingPage,  int popularPage,  int topRatedPage,  int upcomingPage,  bool hasMoreNowPlaying,  bool hasMorePopular,  bool hasMoreTopRated,  bool hasMoreUpcoming,  String? minorError)?  loadedMovieList,TResult Function( String message)?  errorMovieList,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialMovieList() when initialMovieList != null:
return initialMovieList();case LoadingMovieList() when loadingMovieList != null:
return loadingMovieList();case LoadedMovieList() when loadedMovieList != null:
return loadedMovieList(_that.nowPlaying,_that.popular,_that.topRated,_that.upcoming,_that.nowPlayingPage,_that.popularPage,_that.topRatedPage,_that.upcomingPage,_that.hasMoreNowPlaying,_that.hasMorePopular,_that.hasMoreTopRated,_that.hasMoreUpcoming,_that.minorError);case ErrorMovieList() when errorMovieList != null:
return errorMovieList(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialMovieList,required TResult Function()  loadingMovieList,required TResult Function( List<Movie> nowPlaying,  List<Movie> popular,  List<Movie> topRated,  List<Movie> upcoming,  int nowPlayingPage,  int popularPage,  int topRatedPage,  int upcomingPage,  bool hasMoreNowPlaying,  bool hasMorePopular,  bool hasMoreTopRated,  bool hasMoreUpcoming,  String? minorError)  loadedMovieList,required TResult Function( String message)  errorMovieList,}) {final _that = this;
switch (_that) {
case InitialMovieList():
return initialMovieList();case LoadingMovieList():
return loadingMovieList();case LoadedMovieList():
return loadedMovieList(_that.nowPlaying,_that.popular,_that.topRated,_that.upcoming,_that.nowPlayingPage,_that.popularPage,_that.topRatedPage,_that.upcomingPage,_that.hasMoreNowPlaying,_that.hasMorePopular,_that.hasMoreTopRated,_that.hasMoreUpcoming,_that.minorError);case ErrorMovieList():
return errorMovieList(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialMovieList,TResult? Function()?  loadingMovieList,TResult? Function( List<Movie> nowPlaying,  List<Movie> popular,  List<Movie> topRated,  List<Movie> upcoming,  int nowPlayingPage,  int popularPage,  int topRatedPage,  int upcomingPage,  bool hasMoreNowPlaying,  bool hasMorePopular,  bool hasMoreTopRated,  bool hasMoreUpcoming,  String? minorError)?  loadedMovieList,TResult? Function( String message)?  errorMovieList,}) {final _that = this;
switch (_that) {
case InitialMovieList() when initialMovieList != null:
return initialMovieList();case LoadingMovieList() when loadingMovieList != null:
return loadingMovieList();case LoadedMovieList() when loadedMovieList != null:
return loadedMovieList(_that.nowPlaying,_that.popular,_that.topRated,_that.upcoming,_that.nowPlayingPage,_that.popularPage,_that.topRatedPage,_that.upcomingPage,_that.hasMoreNowPlaying,_that.hasMorePopular,_that.hasMoreTopRated,_that.hasMoreUpcoming,_that.minorError);case ErrorMovieList() when errorMovieList != null:
return errorMovieList(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InitialMovieList implements MovieListState {
  const InitialMovieList();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialMovieList);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListState.initialMovieList()';
}


}




/// @nodoc


class LoadingMovieList implements MovieListState {
  const LoadingMovieList();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingMovieList);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListState.loadingMovieList()';
}


}




/// @nodoc


class LoadedMovieList implements MovieListState {
  const LoadedMovieList({required final  List<Movie> nowPlaying, required final  List<Movie> popular, required final  List<Movie> topRated, required final  List<Movie> upcoming, required this.nowPlayingPage, required this.popularPage, required this.topRatedPage, required this.upcomingPage, required this.hasMoreNowPlaying, required this.hasMorePopular, required this.hasMoreTopRated, required this.hasMoreUpcoming, this.minorError}): _nowPlaying = nowPlaying,_popular = popular,_topRated = topRated,_upcoming = upcoming;
  

// Data lists
 final  List<Movie> _nowPlaying;
// Data lists
 List<Movie> get nowPlaying {
  if (_nowPlaying is EqualUnmodifiableListView) return _nowPlaying;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nowPlaying);
}

 final  List<Movie> _popular;
 List<Movie> get popular {
  if (_popular is EqualUnmodifiableListView) return _popular;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popular);
}

 final  List<Movie> _topRated;
 List<Movie> get topRated {
  if (_topRated is EqualUnmodifiableListView) return _topRated;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topRated);
}

 final  List<Movie> _upcoming;
 List<Movie> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

// Pagination pages
 final  int nowPlayingPage;
 final  int popularPage;
 final  int topRatedPage;
 final  int upcomingPage;
// Pagination flags
 final  bool hasMoreNowPlaying;
 final  bool hasMorePopular;
 final  bool hasMoreTopRated;
 final  bool hasMoreUpcoming;
// Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
 final  String? minorError;

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedMovieListCopyWith<LoadedMovieList> get copyWith => _$LoadedMovieListCopyWithImpl<LoadedMovieList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedMovieList&&const DeepCollectionEquality().equals(other._nowPlaying, _nowPlaying)&&const DeepCollectionEquality().equals(other._popular, _popular)&&const DeepCollectionEquality().equals(other._topRated, _topRated)&&const DeepCollectionEquality().equals(other._upcoming, _upcoming)&&(identical(other.nowPlayingPage, nowPlayingPage) || other.nowPlayingPage == nowPlayingPage)&&(identical(other.popularPage, popularPage) || other.popularPage == popularPage)&&(identical(other.topRatedPage, topRatedPage) || other.topRatedPage == topRatedPage)&&(identical(other.upcomingPage, upcomingPage) || other.upcomingPage == upcomingPage)&&(identical(other.hasMoreNowPlaying, hasMoreNowPlaying) || other.hasMoreNowPlaying == hasMoreNowPlaying)&&(identical(other.hasMorePopular, hasMorePopular) || other.hasMorePopular == hasMorePopular)&&(identical(other.hasMoreTopRated, hasMoreTopRated) || other.hasMoreTopRated == hasMoreTopRated)&&(identical(other.hasMoreUpcoming, hasMoreUpcoming) || other.hasMoreUpcoming == hasMoreUpcoming)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nowPlaying),const DeepCollectionEquality().hash(_popular),const DeepCollectionEquality().hash(_topRated),const DeepCollectionEquality().hash(_upcoming),nowPlayingPage,popularPage,topRatedPage,upcomingPage,hasMoreNowPlaying,hasMorePopular,hasMoreTopRated,hasMoreUpcoming,minorError);

@override
String toString() {
  return 'MovieListState.loadedMovieList(nowPlaying: $nowPlaying, popular: $popular, topRated: $topRated, upcoming: $upcoming, nowPlayingPage: $nowPlayingPage, popularPage: $popularPage, topRatedPage: $topRatedPage, upcomingPage: $upcomingPage, hasMoreNowPlaying: $hasMoreNowPlaying, hasMorePopular: $hasMorePopular, hasMoreTopRated: $hasMoreTopRated, hasMoreUpcoming: $hasMoreUpcoming, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedMovieListCopyWith<$Res> implements $MovieListStateCopyWith<$Res> {
  factory $LoadedMovieListCopyWith(LoadedMovieList value, $Res Function(LoadedMovieList) _then) = _$LoadedMovieListCopyWithImpl;
@useResult
$Res call({
 List<Movie> nowPlaying, List<Movie> popular, List<Movie> topRated, List<Movie> upcoming, int nowPlayingPage, int popularPage, int topRatedPage, int upcomingPage, bool hasMoreNowPlaying, bool hasMorePopular, bool hasMoreTopRated, bool hasMoreUpcoming, String? minorError
});




}
/// @nodoc
class _$LoadedMovieListCopyWithImpl<$Res>
    implements $LoadedMovieListCopyWith<$Res> {
  _$LoadedMovieListCopyWithImpl(this._self, this._then);

  final LoadedMovieList _self;
  final $Res Function(LoadedMovieList) _then;

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? nowPlaying = null,Object? popular = null,Object? topRated = null,Object? upcoming = null,Object? nowPlayingPage = null,Object? popularPage = null,Object? topRatedPage = null,Object? upcomingPage = null,Object? hasMoreNowPlaying = null,Object? hasMorePopular = null,Object? hasMoreTopRated = null,Object? hasMoreUpcoming = null,Object? minorError = freezed,}) {
  return _then(LoadedMovieList(
nowPlaying: null == nowPlaying ? _self._nowPlaying : nowPlaying // ignore: cast_nullable_to_non_nullable
as List<Movie>,popular: null == popular ? _self._popular : popular // ignore: cast_nullable_to_non_nullable
as List<Movie>,topRated: null == topRated ? _self._topRated : topRated // ignore: cast_nullable_to_non_nullable
as List<Movie>,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<Movie>,nowPlayingPage: null == nowPlayingPage ? _self.nowPlayingPage : nowPlayingPage // ignore: cast_nullable_to_non_nullable
as int,popularPage: null == popularPage ? _self.popularPage : popularPage // ignore: cast_nullable_to_non_nullable
as int,topRatedPage: null == topRatedPage ? _self.topRatedPage : topRatedPage // ignore: cast_nullable_to_non_nullable
as int,upcomingPage: null == upcomingPage ? _self.upcomingPage : upcomingPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreNowPlaying: null == hasMoreNowPlaying ? _self.hasMoreNowPlaying : hasMoreNowPlaying // ignore: cast_nullable_to_non_nullable
as bool,hasMorePopular: null == hasMorePopular ? _self.hasMorePopular : hasMorePopular // ignore: cast_nullable_to_non_nullable
as bool,hasMoreTopRated: null == hasMoreTopRated ? _self.hasMoreTopRated : hasMoreTopRated // ignore: cast_nullable_to_non_nullable
as bool,hasMoreUpcoming: null == hasMoreUpcoming ? _self.hasMoreUpcoming : hasMoreUpcoming // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorMovieList implements MovieListState {
  const ErrorMovieList(this.message);
  

 final  String message;

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorMovieListCopyWith<ErrorMovieList> get copyWith => _$ErrorMovieListCopyWithImpl<ErrorMovieList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorMovieList&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MovieListState.errorMovieList(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorMovieListCopyWith<$Res> implements $MovieListStateCopyWith<$Res> {
  factory $ErrorMovieListCopyWith(ErrorMovieList value, $Res Function(ErrorMovieList) _then) = _$ErrorMovieListCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorMovieListCopyWithImpl<$Res>
    implements $ErrorMovieListCopyWith<$Res> {
  _$ErrorMovieListCopyWithImpl(this._self, this._then);

  final ErrorMovieList _self;
  final $Res Function(ErrorMovieList) _then;

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorMovieList(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
