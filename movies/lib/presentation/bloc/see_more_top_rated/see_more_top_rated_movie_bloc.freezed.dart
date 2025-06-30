// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'see_more_top_rated_movie_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeeMoreTopRatedMovieEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreTopRatedMovieEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieEvent()';
}


}

/// @nodoc
class $SeeMoreTopRatedMovieEventCopyWith<$Res>  {
$SeeMoreTopRatedMovieEventCopyWith(SeeMoreTopRatedMovieEvent _, $Res Function(SeeMoreTopRatedMovieEvent) __);
}


/// @nodoc


class FetchInitialTopRatedMovies implements SeeMoreTopRatedMovieEvent {
  const FetchInitialTopRatedMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTopRatedMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies()';
}


}




/// @nodoc


class FetchMoreTopRatedSeeMoreMovies implements SeeMoreTopRatedMovieEvent {
  const FetchMoreTopRatedSeeMoreMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreTopRatedSeeMoreMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieEvent.fetchMoreTopRatedSeeMoreMovies()';
}


}




/// @nodoc


class RefreshTopRatedMovies implements SeeMoreTopRatedMovieEvent {
  const RefreshTopRatedMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTopRatedMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieEvent.refreshTopRatedMovies()';
}


}




/// @nodoc
mixin _$SeeMoreTopRatedMovieState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreTopRatedMovieState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieState()';
}


}

/// @nodoc
class $SeeMoreTopRatedMovieStateCopyWith<$Res>  {
$SeeMoreTopRatedMovieStateCopyWith(SeeMoreTopRatedMovieState _, $Res Function(SeeMoreTopRatedMovieState) __);
}


/// @nodoc


class InitialTopRatedMSeeMore implements SeeMoreTopRatedMovieState {
  const InitialTopRatedMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTopRatedMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieState.initialTopRatedMSeeMore()';
}


}




/// @nodoc


class LoadingTopRatedMSeeMore implements SeeMoreTopRatedMovieState {
  const LoadingTopRatedMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTopRatedMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieState.loadingTopRatedMSeeMore()';
}


}




/// @nodoc


class LoadedTopRatedMSeeMore implements SeeMoreTopRatedMovieState {
  const LoadedTopRatedMSeeMore({required final  List<Movie> topRated, required this.topRatedPage, required this.hasMoreTopRated, this.minorError}): _topRated = topRated;
  

// Data List
 final  List<Movie> _topRated;
// Data List
 List<Movie> get topRated {
  if (_topRated is EqualUnmodifiableListView) return _topRated;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topRated);
}

// Pagination Pages
 final  int topRatedPage;
// Pagination Flags
 final  bool hasMoreTopRated;
 final  String? minorError;

/// Create a copy of SeeMoreTopRatedMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedTopRatedMSeeMoreCopyWith<LoadedTopRatedMSeeMore> get copyWith => _$LoadedTopRatedMSeeMoreCopyWithImpl<LoadedTopRatedMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedTopRatedMSeeMore&&const DeepCollectionEquality().equals(other._topRated, _topRated)&&(identical(other.topRatedPage, topRatedPage) || other.topRatedPage == topRatedPage)&&(identical(other.hasMoreTopRated, hasMoreTopRated) || other.hasMoreTopRated == hasMoreTopRated)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topRated),topRatedPage,hasMoreTopRated,minorError);

@override
String toString() {
  return 'SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore(topRated: $topRated, topRatedPage: $topRatedPage, hasMoreTopRated: $hasMoreTopRated, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedTopRatedMSeeMoreCopyWith<$Res> implements $SeeMoreTopRatedMovieStateCopyWith<$Res> {
  factory $LoadedTopRatedMSeeMoreCopyWith(LoadedTopRatedMSeeMore value, $Res Function(LoadedTopRatedMSeeMore) _then) = _$LoadedTopRatedMSeeMoreCopyWithImpl;
@useResult
$Res call({
 List<Movie> topRated, int topRatedPage, bool hasMoreTopRated, String? minorError
});




}
/// @nodoc
class _$LoadedTopRatedMSeeMoreCopyWithImpl<$Res>
    implements $LoadedTopRatedMSeeMoreCopyWith<$Res> {
  _$LoadedTopRatedMSeeMoreCopyWithImpl(this._self, this._then);

  final LoadedTopRatedMSeeMore _self;
  final $Res Function(LoadedTopRatedMSeeMore) _then;

/// Create a copy of SeeMoreTopRatedMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topRated = null,Object? topRatedPage = null,Object? hasMoreTopRated = null,Object? minorError = freezed,}) {
  return _then(LoadedTopRatedMSeeMore(
topRated: null == topRated ? _self._topRated : topRated // ignore: cast_nullable_to_non_nullable
as List<Movie>,topRatedPage: null == topRatedPage ? _self.topRatedPage : topRatedPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreTopRated: null == hasMoreTopRated ? _self.hasMoreTopRated : hasMoreTopRated // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorTopRatedMSeeMore implements SeeMoreTopRatedMovieState {
  const ErrorTopRatedMSeeMore(this.message);
  

 final  String message;

/// Create a copy of SeeMoreTopRatedMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorTopRatedMSeeMoreCopyWith<ErrorTopRatedMSeeMore> get copyWith => _$ErrorTopRatedMSeeMoreCopyWithImpl<ErrorTopRatedMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorTopRatedMSeeMore&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeeMoreTopRatedMovieState.errorTopRatedMSeeMore(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorTopRatedMSeeMoreCopyWith<$Res> implements $SeeMoreTopRatedMovieStateCopyWith<$Res> {
  factory $ErrorTopRatedMSeeMoreCopyWith(ErrorTopRatedMSeeMore value, $Res Function(ErrorTopRatedMSeeMore) _then) = _$ErrorTopRatedMSeeMoreCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorTopRatedMSeeMoreCopyWithImpl<$Res>
    implements $ErrorTopRatedMSeeMoreCopyWith<$Res> {
  _$ErrorTopRatedMSeeMoreCopyWithImpl(this._self, this._then);

  final ErrorTopRatedMSeeMore _self;
  final $Res Function(ErrorTopRatedMSeeMore) _then;

/// Create a copy of SeeMoreTopRatedMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorTopRatedMSeeMore(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
