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


class FetchMoreUpComingMovies implements SeeMoreUpcomingMovieEvent {
  const FetchMoreUpComingMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreUpComingMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieEvent.fetchMoreUpComingMovies()';
}


}




/// @nodoc


class RefreshMovies implements SeeMoreUpcomingMovieEvent {
  const RefreshMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieEvent.refreshMovies()';
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


class Initial implements SeeMoreUpcomingMovieState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieState.initial()';
}


}




/// @nodoc


class Loading implements SeeMoreUpcomingMovieState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreUpcomingMovieState.loading()';
}


}




/// @nodoc


class Loaded implements SeeMoreUpcomingMovieState {
  const Loaded({required final  List<Movie> upComing, required this.upComingPage, required this.hasMoreUpComing, this.minorError}): _upComing = upComing;
  

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
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._upComing, _upComing)&&(identical(other.upComingPage, upComingPage) || other.upComingPage == upComingPage)&&(identical(other.hasMoreUpComing, hasMoreUpComing) || other.hasMoreUpComing == hasMoreUpComing)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_upComing),upComingPage,hasMoreUpComing,minorError);

@override
String toString() {
  return 'SeeMoreUpcomingMovieState.loaded(upComing: $upComing, upComingPage: $upComingPage, hasMoreUpComing: $hasMoreUpComing, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $SeeMoreUpcomingMovieStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Movie> upComing, int upComingPage, bool hasMoreUpComing, String? minorError
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of SeeMoreUpcomingMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? upComing = null,Object? upComingPage = null,Object? hasMoreUpComing = null,Object? minorError = freezed,}) {
  return _then(Loaded(
upComing: null == upComing ? _self._upComing : upComing // ignore: cast_nullable_to_non_nullable
as List<Movie>,upComingPage: null == upComingPage ? _self.upComingPage : upComingPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreUpComing: null == hasMoreUpComing ? _self.hasMoreUpComing : hasMoreUpComing // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements SeeMoreUpcomingMovieState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of SeeMoreUpcomingMovieState
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
  return 'SeeMoreUpcomingMovieState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $SeeMoreUpcomingMovieStateCopyWith<$Res> {
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

/// Create a copy of SeeMoreUpcomingMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
