// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_rated_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TopRatedTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopRatedTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent()';
}


}

/// @nodoc
class $TopRatedTvEventCopyWith<$Res>  {
$TopRatedTvEventCopyWith(TopRatedTvEvent _, $Res Function(TopRatedTvEvent) __);
}


/// @nodoc


class FetchInitialTvS implements TopRatedTvEvent {
  const FetchInitialTvS();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTvS);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent.fetchInitialTvS()';
}


}




/// @nodoc


class FetchMoreTopRatedTv implements TopRatedTvEvent {
  const FetchMoreTopRatedTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreTopRatedTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent.fetchMoreTopRatedTv()';
}


}




/// @nodoc


class RefreshTv implements TopRatedTvEvent {
  const RefreshTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent.refreshTv()';
}


}




/// @nodoc
mixin _$TopRatedTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopRatedTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvState()';
}


}

/// @nodoc
class $TopRatedTvStateCopyWith<$Res>  {
$TopRatedTvStateCopyWith(TopRatedTvState _, $Res Function(TopRatedTvState) __);
}


/// @nodoc


class Initial implements TopRatedTvState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvState.initial()';
}


}




/// @nodoc


class Loading implements TopRatedTvState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvState.loading()';
}


}




/// @nodoc


class Loaded implements TopRatedTvState {
  const Loaded({required final  List<TvSeries> topRated, required this.topRatedPage, required this.hasMoreTopRated, this.minorError}): _topRated = topRated;
  

// Data lists
 final  List<TvSeries> _topRated;
// Data lists
 List<TvSeries> get topRated {
  if (_topRated is EqualUnmodifiableListView) return _topRated;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topRated);
}

// Pagination pages
 final  int topRatedPage;
// Pagination flags
 final  bool hasMoreTopRated;
// Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
 final  String? minorError;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._topRated, _topRated)&&(identical(other.topRatedPage, topRatedPage) || other.topRatedPage == topRatedPage)&&(identical(other.hasMoreTopRated, hasMoreTopRated) || other.hasMoreTopRated == hasMoreTopRated)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topRated),topRatedPage,hasMoreTopRated,minorError);

@override
String toString() {
  return 'TopRatedTvState.loaded(topRated: $topRated, topRatedPage: $topRatedPage, hasMoreTopRated: $hasMoreTopRated, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $TopRatedTvStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> topRated, int topRatedPage, bool hasMoreTopRated, String? minorError
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topRated = null,Object? topRatedPage = null,Object? hasMoreTopRated = null,Object? minorError = freezed,}) {
  return _then(Loaded(
topRated: null == topRated ? _self._topRated : topRated // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,topRatedPage: null == topRatedPage ? _self.topRatedPage : topRatedPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreTopRated: null == hasMoreTopRated ? _self.hasMoreTopRated : hasMoreTopRated // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements TopRatedTvState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of TopRatedTvState
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
  return 'TopRatedTvState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $TopRatedTvStateCopyWith<$Res> {
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

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
