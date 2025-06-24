// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'see_more_popular_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeeMorePopularTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMorePopularTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvEvent()';
}


}

/// @nodoc
class $SeeMorePopularTvEventCopyWith<$Res>  {
$SeeMorePopularTvEventCopyWith(SeeMorePopularTvEvent _, $Res Function(SeeMorePopularTvEvent) __);
}


/// @nodoc


class FetchInitialPopularTv implements SeeMorePopularTvEvent {
  const FetchInitialPopularTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialPopularTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvEvent.fetchInitialPopularTv()';
}


}




/// @nodoc


class FetchMorePopularTv implements SeeMorePopularTvEvent {
  const FetchMorePopularTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMorePopularTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvEvent.fetchMorePopularTv()';
}


}




/// @nodoc


class RefreshTv implements SeeMorePopularTvEvent {
  const RefreshTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvEvent.refreshTv()';
}


}




/// @nodoc
mixin _$SeeMorePopularTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMorePopularTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvState()';
}


}

/// @nodoc
class $SeeMorePopularTvStateCopyWith<$Res>  {
$SeeMorePopularTvStateCopyWith(SeeMorePopularTvState _, $Res Function(SeeMorePopularTvState) __);
}


/// @nodoc


class Initial implements SeeMorePopularTvState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvState.initial()';
}


}




/// @nodoc


class Loading implements SeeMorePopularTvState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvState.loading()';
}


}




/// @nodoc


class Loaded implements SeeMorePopularTvState {
  const Loaded({required final  List<TvSeries> popularTv, required this.popularTvPage, required this.hasMorePopularTv, this.minorError}): _popularTv = popularTv;
  

// Data List
 final  List<TvSeries> _popularTv;
// Data List
 List<TvSeries> get popularTv {
  if (_popularTv is EqualUnmodifiableListView) return _popularTv;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popularTv);
}

// Pagination Pages
 final  int popularTvPage;
// Pagination Flags
 final  bool hasMorePopularTv;
 final  String? minorError;

/// Create a copy of SeeMorePopularTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._popularTv, _popularTv)&&(identical(other.popularTvPage, popularTvPage) || other.popularTvPage == popularTvPage)&&(identical(other.hasMorePopularTv, hasMorePopularTv) || other.hasMorePopularTv == hasMorePopularTv)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popularTv),popularTvPage,hasMorePopularTv,minorError);

@override
String toString() {
  return 'SeeMorePopularTvState.loaded(popularTv: $popularTv, popularTvPage: $popularTvPage, hasMorePopularTv: $hasMorePopularTv, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $SeeMorePopularTvStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> popularTv, int popularTvPage, bool hasMorePopularTv, String? minorError
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of SeeMorePopularTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? popularTv = null,Object? popularTvPage = null,Object? hasMorePopularTv = null,Object? minorError = freezed,}) {
  return _then(Loaded(
popularTv: null == popularTv ? _self._popularTv : popularTv // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,popularTvPage: null == popularTvPage ? _self.popularTvPage : popularTvPage // ignore: cast_nullable_to_non_nullable
as int,hasMorePopularTv: null == hasMorePopularTv ? _self.hasMorePopularTv : hasMorePopularTv // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements SeeMorePopularTvState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of SeeMorePopularTvState
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
  return 'SeeMorePopularTvState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $SeeMorePopularTvStateCopyWith<$Res> {
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

/// Create a copy of SeeMorePopularTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
