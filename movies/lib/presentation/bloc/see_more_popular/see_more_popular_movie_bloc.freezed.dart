// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'see_more_popular_movie_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeeMorePopularMovieEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMorePopularMovieEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieEvent()';
}


}

/// @nodoc
class $SeeMorePopularMovieEventCopyWith<$Res>  {
$SeeMorePopularMovieEventCopyWith(SeeMorePopularMovieEvent _, $Res Function(SeeMorePopularMovieEvent) __);
}


/// @nodoc


class FetchInitialPopularMovies implements SeeMorePopularMovieEvent {
  const FetchInitialPopularMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialPopularMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieEvent.fetchInitialPopularMovies()';
}


}




/// @nodoc


class FetchMorePopularSeeMoreMovies implements SeeMorePopularMovieEvent {
  const FetchMorePopularSeeMoreMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMorePopularSeeMoreMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieEvent.fetchMorePopularSeeMoreMovies()';
}


}




/// @nodoc


class RefreshPopularMovies implements SeeMorePopularMovieEvent {
  const RefreshPopularMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshPopularMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieEvent.refreshPopularMovies()';
}


}




/// @nodoc
mixin _$SeeMorePopularMovieState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMorePopularMovieState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieState()';
}


}

/// @nodoc
class $SeeMorePopularMovieStateCopyWith<$Res>  {
$SeeMorePopularMovieStateCopyWith(SeeMorePopularMovieState _, $Res Function(SeeMorePopularMovieState) __);
}


/// @nodoc


class InitialPopularMSeeMore implements SeeMorePopularMovieState {
  const InitialPopularMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialPopularMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieState.initialPopularMSeeMore()';
}


}




/// @nodoc


class LoadingPopularMSeeMore implements SeeMorePopularMovieState {
  const LoadingPopularMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingPopularMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieState.loadingPopularMSeeMore()';
}


}




/// @nodoc


class LoadedPopularMSeeMore implements SeeMorePopularMovieState {
  const LoadedPopularMSeeMore({required final  List<Movie> popular, required this.popularPage, required this.hasMorePopular, this.minorError}): _popular = popular;
  

// Data List
 final  List<Movie> _popular;
// Data List
 List<Movie> get popular {
  if (_popular is EqualUnmodifiableListView) return _popular;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popular);
}

// Pagination Pages
 final  int popularPage;
// Pagination Flags
 final  bool hasMorePopular;
 final  String? minorError;

/// Create a copy of SeeMorePopularMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedPopularMSeeMoreCopyWith<LoadedPopularMSeeMore> get copyWith => _$LoadedPopularMSeeMoreCopyWithImpl<LoadedPopularMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedPopularMSeeMore&&const DeepCollectionEquality().equals(other._popular, _popular)&&(identical(other.popularPage, popularPage) || other.popularPage == popularPage)&&(identical(other.hasMorePopular, hasMorePopular) || other.hasMorePopular == hasMorePopular)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popular),popularPage,hasMorePopular,minorError);

@override
String toString() {
  return 'SeeMorePopularMovieState.loadedPopularMSeeMore(popular: $popular, popularPage: $popularPage, hasMorePopular: $hasMorePopular, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedPopularMSeeMoreCopyWith<$Res> implements $SeeMorePopularMovieStateCopyWith<$Res> {
  factory $LoadedPopularMSeeMoreCopyWith(LoadedPopularMSeeMore value, $Res Function(LoadedPopularMSeeMore) _then) = _$LoadedPopularMSeeMoreCopyWithImpl;
@useResult
$Res call({
 List<Movie> popular, int popularPage, bool hasMorePopular, String? minorError
});




}
/// @nodoc
class _$LoadedPopularMSeeMoreCopyWithImpl<$Res>
    implements $LoadedPopularMSeeMoreCopyWith<$Res> {
  _$LoadedPopularMSeeMoreCopyWithImpl(this._self, this._then);

  final LoadedPopularMSeeMore _self;
  final $Res Function(LoadedPopularMSeeMore) _then;

/// Create a copy of SeeMorePopularMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? popular = null,Object? popularPage = null,Object? hasMorePopular = null,Object? minorError = freezed,}) {
  return _then(LoadedPopularMSeeMore(
popular: null == popular ? _self._popular : popular // ignore: cast_nullable_to_non_nullable
as List<Movie>,popularPage: null == popularPage ? _self.popularPage : popularPage // ignore: cast_nullable_to_non_nullable
as int,hasMorePopular: null == hasMorePopular ? _self.hasMorePopular : hasMorePopular // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorPopularMSeeMore implements SeeMorePopularMovieState {
  const ErrorPopularMSeeMore(this.message);
  

 final  String message;

/// Create a copy of SeeMorePopularMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorPopularMSeeMoreCopyWith<ErrorPopularMSeeMore> get copyWith => _$ErrorPopularMSeeMoreCopyWithImpl<ErrorPopularMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorPopularMSeeMore&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeeMorePopularMovieState.errorPopularMSeeMore(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorPopularMSeeMoreCopyWith<$Res> implements $SeeMorePopularMovieStateCopyWith<$Res> {
  factory $ErrorPopularMSeeMoreCopyWith(ErrorPopularMSeeMore value, $Res Function(ErrorPopularMSeeMore) _then) = _$ErrorPopularMSeeMoreCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorPopularMSeeMoreCopyWithImpl<$Res>
    implements $ErrorPopularMSeeMoreCopyWith<$Res> {
  _$ErrorPopularMSeeMoreCopyWithImpl(this._self, this._then);

  final ErrorPopularMSeeMore _self;
  final $Res Function(ErrorPopularMSeeMore) _then;

/// Create a copy of SeeMorePopularMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorPopularMSeeMore(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
