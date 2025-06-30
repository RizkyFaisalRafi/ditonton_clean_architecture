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


class FetchInitialTopRatedTv implements TopRatedTvEvent {
  const FetchInitialTopRatedTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTopRatedTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent.fetchInitialTopRatedTv()';
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


class RefreshTvTr implements TopRatedTvEvent {
  const RefreshTvTr();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTvTr);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent.refreshTvTr()';
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


class InitialTrTv implements TopRatedTvState {
  const InitialTrTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTrTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvState.initialTrTv()';
}


}




/// @nodoc


class LoadingTrTv implements TopRatedTvState {
  const LoadingTrTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTrTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvState.loadingTrTv()';
}


}




/// @nodoc


class LoadedTrTv implements TopRatedTvState {
  const LoadedTrTv({required final  List<TvSeries> topRated, required this.topRatedPage, required this.hasMoreTopRated, this.minorError}): _topRated = topRated;
  

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
$LoadedTrTvCopyWith<LoadedTrTv> get copyWith => _$LoadedTrTvCopyWithImpl<LoadedTrTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedTrTv&&const DeepCollectionEquality().equals(other._topRated, _topRated)&&(identical(other.topRatedPage, topRatedPage) || other.topRatedPage == topRatedPage)&&(identical(other.hasMoreTopRated, hasMoreTopRated) || other.hasMoreTopRated == hasMoreTopRated)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topRated),topRatedPage,hasMoreTopRated,minorError);

@override
String toString() {
  return 'TopRatedTvState.loadedTrTv(topRated: $topRated, topRatedPage: $topRatedPage, hasMoreTopRated: $hasMoreTopRated, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedTrTvCopyWith<$Res> implements $TopRatedTvStateCopyWith<$Res> {
  factory $LoadedTrTvCopyWith(LoadedTrTv value, $Res Function(LoadedTrTv) _then) = _$LoadedTrTvCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> topRated, int topRatedPage, bool hasMoreTopRated, String? minorError
});




}
/// @nodoc
class _$LoadedTrTvCopyWithImpl<$Res>
    implements $LoadedTrTvCopyWith<$Res> {
  _$LoadedTrTvCopyWithImpl(this._self, this._then);

  final LoadedTrTv _self;
  final $Res Function(LoadedTrTv) _then;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topRated = null,Object? topRatedPage = null,Object? hasMoreTopRated = null,Object? minorError = freezed,}) {
  return _then(LoadedTrTv(
topRated: null == topRated ? _self._topRated : topRated // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,topRatedPage: null == topRatedPage ? _self.topRatedPage : topRatedPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreTopRated: null == hasMoreTopRated ? _self.hasMoreTopRated : hasMoreTopRated // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorTrTv implements TopRatedTvState {
  const ErrorTrTv(this.message);
  

 final  String message;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorTrTvCopyWith<ErrorTrTv> get copyWith => _$ErrorTrTvCopyWithImpl<ErrorTrTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorTrTv&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TopRatedTvState.errorTrTv(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorTrTvCopyWith<$Res> implements $TopRatedTvStateCopyWith<$Res> {
  factory $ErrorTrTvCopyWith(ErrorTrTv value, $Res Function(ErrorTrTv) _then) = _$ErrorTrTvCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorTrTvCopyWithImpl<$Res>
    implements $ErrorTrTvCopyWith<$Res> {
  _$ErrorTrTvCopyWithImpl(this._self, this._then);

  final ErrorTrTv _self;
  final $Res Function(ErrorTrTv) _then;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorTrTv(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
