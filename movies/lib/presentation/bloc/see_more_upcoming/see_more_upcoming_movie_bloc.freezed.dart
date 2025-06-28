// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'see_more_upcoming_movie_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeeMoreUpcomingMovieEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreUpcomingMovieEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieEvent()';
}


}

/// @nodoc
class $SeeMoreUpcomingMovieEventCopyWith<$Res>  {
$SeeMoreUpcomingMovieEventCopyWith(SeeMoreUpcomingMovieEvent _, $Res Function(SeeMoreUpcomingMovieEvent) __);
}


/// @nodoc


class FetchInitialUpComingMovies implements SeeMoreUpcomingMovieEvent {
  const FetchInitialUpComingMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialUpComingMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieEvent.fetchInitialUpComingMovies()';
}


}




/// @nodoc


class FetchMoreUpComingSeeMoreMovies implements SeeMoreUpcomingMovieEvent {
  const FetchMoreUpComingSeeMoreMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreUpComingSeeMoreMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieEvent.fetchMoreUpComingSeeMoreMovies()';
}


}




/// @nodoc


class RefreshUpComingMovies implements SeeMoreUpcomingMovieEvent {
  const RefreshUpComingMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshUpComingMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieEvent.refreshUpComingMovies()';
}


}




/// @nodoc
mixin _$SeeMoreUpcomingMovieState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreUpcomingMovieState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieState()';
}


}

/// @nodoc
class $SeeMoreUpcomingMovieStateCopyWith<$Res>  {
$SeeMoreUpcomingMovieStateCopyWith(SeeMoreUpcomingMovieState _, $Res Function(SeeMoreUpcomingMovieState) __);
}


/// @nodoc


class InitialUpComingMSeeMore implements SeeMoreUpcomingMovieState {
  const InitialUpComingMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialUpComingMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieState.initialUpComingMSeeMore()';
}


}




/// @nodoc


class LoadingUpComingMSeeMore implements SeeMoreUpcomingMovieState {
  const LoadingUpComingMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingUpComingMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieState.loadingUpComingMSeeMore()';
}


}




/// @nodoc


class LoadedUpComingMSeeMore implements SeeMoreUpcomingMovieState {
  const LoadedUpComingMSeeMore({required final  List<Movie> upComing, required this.upComingPage, required this.hasMoreUpComing, this.minorError}): _upComing = upComing;
  

// Data List
 final  List<Movie> _upComing;
// Data List
 List<Movie> get upComing {
  if (_upComing is EqualUnmodifiableListView) return _upComing;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upComing);
}

// Pagination Pages
 final  int upComingPage;
// Pagination Flags
 final  bool hasMoreUpComing;
 final  String? minorError;

/// Create a copy of SeeMoreUpcomingMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedUpComingMSeeMoreCopyWith<LoadedUpComingMSeeMore> get copyWith => _$LoadedUpComingMSeeMoreCopyWithImpl<LoadedUpComingMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedUpComingMSeeMore&&const DeepCollectionEquality().equals(other._upComing, _upComing)&&(identical(other.upComingPage, upComingPage) || other.upComingPage == upComingPage)&&(identical(other.hasMoreUpComing, hasMoreUpComing) || other.hasMoreUpComing == hasMoreUpComing)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_upComing),upComingPage,hasMoreUpComing,minorError);

@override
String toString() {
  return 'SeeMoreUpcomingMovieState.loadedUpComingMSeeMore(upComing: $upComing, upComingPage: $upComingPage, hasMoreUpComing: $hasMoreUpComing, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedUpComingMSeeMoreCopyWith<$Res> implements $SeeMoreUpcomingMovieStateCopyWith<$Res> {
  factory $LoadedUpComingMSeeMoreCopyWith(LoadedUpComingMSeeMore value, $Res Function(LoadedUpComingMSeeMore) _then) = _$LoadedUpComingMSeeMoreCopyWithImpl;
@useResult
$Res call({
 List<Movie> upComing, int upComingPage, bool hasMoreUpComing, String? minorError
});




}
/// @nodoc
class _$LoadedUpComingMSeeMoreCopyWithImpl<$Res>
    implements $LoadedUpComingMSeeMoreCopyWith<$Res> {
  _$LoadedUpComingMSeeMoreCopyWithImpl(this._self, this._then);

  final LoadedUpComingMSeeMore _self;
  final $Res Function(LoadedUpComingMSeeMore) _then;

/// Create a copy of SeeMoreUpcomingMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? upComing = null,Object? upComingPage = null,Object? hasMoreUpComing = null,Object? minorError = freezed,}) {
  return _then(LoadedUpComingMSeeMore(
upComing: null == upComing ? _self._upComing : upComing // ignore: cast_nullable_to_non_nullable
as List<Movie>,upComingPage: null == upComingPage ? _self.upComingPage : upComingPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreUpComing: null == hasMoreUpComing ? _self.hasMoreUpComing : hasMoreUpComing // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorUpComingMSeeMore implements SeeMoreUpcomingMovieState {
  const ErrorUpComingMSeeMore(this.message);
  

 final  String message;

/// Create a copy of SeeMoreUpcomingMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorUpComingMSeeMoreCopyWith<ErrorUpComingMSeeMore> get copyWith => _$ErrorUpComingMSeeMoreCopyWithImpl<ErrorUpComingMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorUpComingMSeeMore&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeeMoreUpcomingMovieState.errorUpComingMSeeMore(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorUpComingMSeeMoreCopyWith<$Res> implements $SeeMoreUpcomingMovieStateCopyWith<$Res> {
  factory $ErrorUpComingMSeeMoreCopyWith(ErrorUpComingMSeeMore value, $Res Function(ErrorUpComingMSeeMore) _then) = _$ErrorUpComingMSeeMoreCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorUpComingMSeeMoreCopyWithImpl<$Res>
    implements $ErrorUpComingMSeeMoreCopyWith<$Res> {
  _$ErrorUpComingMSeeMoreCopyWithImpl(this._self, this._then);

  final ErrorUpComingMSeeMore _self;
  final $Res Function(ErrorUpComingMSeeMore) _then;

/// Create a copy of SeeMoreUpcomingMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorUpComingMSeeMore(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
