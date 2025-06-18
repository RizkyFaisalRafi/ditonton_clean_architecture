// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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


/// @nodoc


class Initial implements MovieListState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListState.initial()';
}


}




/// @nodoc


class Loading implements MovieListState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieListState.loading()';
}


}




/// @nodoc


class Loaded implements MovieListState {
  const Loaded({required final  List<Movie> nowPlaying, required final  List<Movie> popular, required final  List<Movie> topRated, required final  List<Movie> upcoming, required this.nowPlayingPage, required this.popularPage, required this.topRatedPage, required this.upcomingPage, required this.hasMoreNowPlaying, required this.hasMorePopular, required this.hasMoreTopRated, required this.hasMoreUpcoming, this.minorError}): _nowPlaying = nowPlaying,_popular = popular,_topRated = topRated,_upcoming = upcoming;
  

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
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._nowPlaying, _nowPlaying)&&const DeepCollectionEquality().equals(other._popular, _popular)&&const DeepCollectionEquality().equals(other._topRated, _topRated)&&const DeepCollectionEquality().equals(other._upcoming, _upcoming)&&(identical(other.nowPlayingPage, nowPlayingPage) || other.nowPlayingPage == nowPlayingPage)&&(identical(other.popularPage, popularPage) || other.popularPage == popularPage)&&(identical(other.topRatedPage, topRatedPage) || other.topRatedPage == topRatedPage)&&(identical(other.upcomingPage, upcomingPage) || other.upcomingPage == upcomingPage)&&(identical(other.hasMoreNowPlaying, hasMoreNowPlaying) || other.hasMoreNowPlaying == hasMoreNowPlaying)&&(identical(other.hasMorePopular, hasMorePopular) || other.hasMorePopular == hasMorePopular)&&(identical(other.hasMoreTopRated, hasMoreTopRated) || other.hasMoreTopRated == hasMoreTopRated)&&(identical(other.hasMoreUpcoming, hasMoreUpcoming) || other.hasMoreUpcoming == hasMoreUpcoming)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nowPlaying),const DeepCollectionEquality().hash(_popular),const DeepCollectionEquality().hash(_topRated),const DeepCollectionEquality().hash(_upcoming),nowPlayingPage,popularPage,topRatedPage,upcomingPage,hasMoreNowPlaying,hasMorePopular,hasMoreTopRated,hasMoreUpcoming,minorError);

@override
String toString() {
  return 'MovieListState.loaded(nowPlaying: $nowPlaying, popular: $popular, topRated: $topRated, upcoming: $upcoming, nowPlayingPage: $nowPlayingPage, popularPage: $popularPage, topRatedPage: $topRatedPage, upcomingPage: $upcomingPage, hasMoreNowPlaying: $hasMoreNowPlaying, hasMorePopular: $hasMorePopular, hasMoreTopRated: $hasMoreTopRated, hasMoreUpcoming: $hasMoreUpcoming, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $MovieListStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Movie> nowPlaying, List<Movie> popular, List<Movie> topRated, List<Movie> upcoming, int nowPlayingPage, int popularPage, int topRatedPage, int upcomingPage, bool hasMoreNowPlaying, bool hasMorePopular, bool hasMoreTopRated, bool hasMoreUpcoming, String? minorError
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? nowPlaying = null,Object? popular = null,Object? topRated = null,Object? upcoming = null,Object? nowPlayingPage = null,Object? popularPage = null,Object? topRatedPage = null,Object? upcomingPage = null,Object? hasMoreNowPlaying = null,Object? hasMorePopular = null,Object? hasMoreTopRated = null,Object? hasMoreUpcoming = null,Object? minorError = freezed,}) {
  return _then(Loaded(
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


class Error implements MovieListState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of MovieListState
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
  return 'MovieListState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $MovieListStateCopyWith<$Res> {
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

/// Create a copy of MovieListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
