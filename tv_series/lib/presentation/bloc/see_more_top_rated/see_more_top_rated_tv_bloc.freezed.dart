// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'see_more_top_rated_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeeMoreTopRatedTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreTopRatedTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvEvent()';
}


}

/// @nodoc
class $SeeMoreTopRatedTvEventCopyWith<$Res>  {
$SeeMoreTopRatedTvEventCopyWith(SeeMoreTopRatedTvEvent _, $Res Function(SeeMoreTopRatedTvEvent) __);
}


/// @nodoc


class FetchInitialTopRatedSeeMoreTv implements SeeMoreTopRatedTvEvent {
  const FetchInitialTopRatedSeeMoreTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTopRatedSeeMoreTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvEvent.fetchInitialTopRatedSeeMoreTv()';
}


}




/// @nodoc


class FetchMoreTopRatedSeeMoreTv implements SeeMoreTopRatedTvEvent {
  const FetchMoreTopRatedSeeMoreTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreTopRatedSeeMoreTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvEvent.fetchMoreTopRatedSeeMoreTv()';
}


}




/// @nodoc


class RefreshTopRatedTv implements SeeMoreTopRatedTvEvent {
  const RefreshTopRatedTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTopRatedTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvEvent.refreshTopRatedTv()';
}


}




/// @nodoc
mixin _$SeeMoreTopRatedTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreTopRatedTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvState()';
}


}

/// @nodoc
class $SeeMoreTopRatedTvStateCopyWith<$Res>  {
$SeeMoreTopRatedTvStateCopyWith(SeeMoreTopRatedTvState _, $Res Function(SeeMoreTopRatedTvState) __);
}


/// @nodoc


class InitialTopRatedTSeeMore implements SeeMoreTopRatedTvState {
  const InitialTopRatedTSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTopRatedTSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvState.initialTopRatedTSeeMore()';
}


}




/// @nodoc


class LoadingTopRatedTSeeMore implements SeeMoreTopRatedTvState {
  const LoadingTopRatedTSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTopRatedTSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvState.loadingTopRatedTSeeMore()';
}


}




/// @nodoc


class LoadedTopRatedTSeeMore implements SeeMoreTopRatedTvState {
  const LoadedTopRatedTSeeMore({required final  List<TvSeries> topRatedTv, required this.topRatedTvPage, required this.hasMoreTopRatedTv, this.minorError}): _topRatedTv = topRatedTv;
  

// Data List
 final  List<TvSeries> _topRatedTv;
// Data List
 List<TvSeries> get topRatedTv {
  if (_topRatedTv is EqualUnmodifiableListView) return _topRatedTv;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topRatedTv);
}

// Pagination Pages
 final  int topRatedTvPage;
// Pagination Flags
 final  bool hasMoreTopRatedTv;
 final  String? minorError;

/// Create a copy of SeeMoreTopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedTopRatedTSeeMoreCopyWith<LoadedTopRatedTSeeMore> get copyWith => _$LoadedTopRatedTSeeMoreCopyWithImpl<LoadedTopRatedTSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedTopRatedTSeeMore&&const DeepCollectionEquality().equals(other._topRatedTv, _topRatedTv)&&(identical(other.topRatedTvPage, topRatedTvPage) || other.topRatedTvPage == topRatedTvPage)&&(identical(other.hasMoreTopRatedTv, hasMoreTopRatedTv) || other.hasMoreTopRatedTv == hasMoreTopRatedTv)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topRatedTv),topRatedTvPage,hasMoreTopRatedTv,minorError);

@override
String toString() {
  return 'SeeMoreTopRatedTvState.loadedTopRatedTSeeMore(topRatedTv: $topRatedTv, topRatedTvPage: $topRatedTvPage, hasMoreTopRatedTv: $hasMoreTopRatedTv, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedTopRatedTSeeMoreCopyWith<$Res> implements $SeeMoreTopRatedTvStateCopyWith<$Res> {
  factory $LoadedTopRatedTSeeMoreCopyWith(LoadedTopRatedTSeeMore value, $Res Function(LoadedTopRatedTSeeMore) _then) = _$LoadedTopRatedTSeeMoreCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> topRatedTv, int topRatedTvPage, bool hasMoreTopRatedTv, String? minorError
});




}
/// @nodoc
class _$LoadedTopRatedTSeeMoreCopyWithImpl<$Res>
    implements $LoadedTopRatedTSeeMoreCopyWith<$Res> {
  _$LoadedTopRatedTSeeMoreCopyWithImpl(this._self, this._then);

  final LoadedTopRatedTSeeMore _self;
  final $Res Function(LoadedTopRatedTSeeMore) _then;

/// Create a copy of SeeMoreTopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topRatedTv = null,Object? topRatedTvPage = null,Object? hasMoreTopRatedTv = null,Object? minorError = freezed,}) {
  return _then(LoadedTopRatedTSeeMore(
topRatedTv: null == topRatedTv ? _self._topRatedTv : topRatedTv // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,topRatedTvPage: null == topRatedTvPage ? _self.topRatedTvPage : topRatedTvPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreTopRatedTv: null == hasMoreTopRatedTv ? _self.hasMoreTopRatedTv : hasMoreTopRatedTv // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorTopRatedTSeeMore implements SeeMoreTopRatedTvState {
  const ErrorTopRatedTSeeMore(this.message);
  

 final  String message;

/// Create a copy of SeeMoreTopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorTopRatedTSeeMoreCopyWith<ErrorTopRatedTSeeMore> get copyWith => _$ErrorTopRatedTSeeMoreCopyWithImpl<ErrorTopRatedTSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorTopRatedTSeeMore&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeeMoreTopRatedTvState.errorTopRatedTSeeMore(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorTopRatedTSeeMoreCopyWith<$Res> implements $SeeMoreTopRatedTvStateCopyWith<$Res> {
  factory $ErrorTopRatedTSeeMoreCopyWith(ErrorTopRatedTSeeMore value, $Res Function(ErrorTopRatedTSeeMore) _then) = _$ErrorTopRatedTSeeMoreCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorTopRatedTSeeMoreCopyWithImpl<$Res>
    implements $ErrorTopRatedTSeeMoreCopyWith<$Res> {
  _$ErrorTopRatedTSeeMoreCopyWithImpl(this._self, this._then);

  final ErrorTopRatedTSeeMore _self;
  final $Res Function(ErrorTopRatedTSeeMore) _then;

/// Create a copy of SeeMoreTopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorTopRatedTSeeMore(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
