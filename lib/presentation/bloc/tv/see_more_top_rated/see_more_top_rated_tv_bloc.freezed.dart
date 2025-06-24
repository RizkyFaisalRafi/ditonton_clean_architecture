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


class FetchInitialTopRatedTv implements SeeMoreTopRatedTvEvent {
  const FetchInitialTopRatedTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTopRatedTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvEvent.fetchInitialTopRatedTv()';
}


}




/// @nodoc


class FetchMoreTopRatedTv implements SeeMoreTopRatedTvEvent {
  const FetchMoreTopRatedTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreTopRatedTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvEvent.fetchMoreTopRatedTv()';
}


}




/// @nodoc


class RefreshTv implements SeeMoreTopRatedTvEvent {
  const RefreshTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvEvent.refreshTv()';
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


class Initial implements SeeMoreTopRatedTvState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvState.initial()';
}


}




/// @nodoc


class Loading implements SeeMoreTopRatedTvState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedTvState.loading()';
}


}




/// @nodoc


class Loaded implements SeeMoreTopRatedTvState {
  const Loaded({required final  List<TvSeries> topRatedTv, required this.topRatedTvPage, required this.hasMoreTopRatedTv, this.minorError}): _topRatedTv = topRatedTv;
  

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
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._topRatedTv, _topRatedTv)&&(identical(other.topRatedTvPage, topRatedTvPage) || other.topRatedTvPage == topRatedTvPage)&&(identical(other.hasMoreTopRatedTv, hasMoreTopRatedTv) || other.hasMoreTopRatedTv == hasMoreTopRatedTv)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topRatedTv),topRatedTvPage,hasMoreTopRatedTv,minorError);

@override
String toString() {
  return 'SeeMoreTopRatedTvState.loaded(topRatedTv: $topRatedTv, topRatedTvPage: $topRatedTvPage, hasMoreTopRatedTv: $hasMoreTopRatedTv, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $SeeMoreTopRatedTvStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> topRatedTv, int topRatedTvPage, bool hasMoreTopRatedTv, String? minorError
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of SeeMoreTopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topRatedTv = null,Object? topRatedTvPage = null,Object? hasMoreTopRatedTv = null,Object? minorError = freezed,}) {
  return _then(Loaded(
topRatedTv: null == topRatedTv ? _self._topRatedTv : topRatedTv // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,topRatedTvPage: null == topRatedTvPage ? _self.topRatedTvPage : topRatedTvPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreTopRatedTv: null == hasMoreTopRatedTv ? _self.hasMoreTopRatedTv : hasMoreTopRatedTv // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements SeeMoreTopRatedTvState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of SeeMoreTopRatedTvState
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
  return 'SeeMoreTopRatedTvState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $SeeMoreTopRatedTvStateCopyWith<$Res> {
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

/// Create a copy of SeeMoreTopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
