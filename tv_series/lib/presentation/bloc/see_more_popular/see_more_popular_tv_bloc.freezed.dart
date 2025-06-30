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


class FetchInitialPopularSeeMoreTv implements SeeMorePopularTvEvent {
  const FetchInitialPopularSeeMoreTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialPopularSeeMoreTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvEvent.fetchInitialPopularSeeMoreTv()';
}


}




/// @nodoc


class FetchMorePopularSeeMoreTv implements SeeMorePopularTvEvent {
  const FetchMorePopularSeeMoreTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMorePopularSeeMoreTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvEvent.fetchMorePopularSeeMoreTv()';
}


}




/// @nodoc


class RefreshPopularTv implements SeeMorePopularTvEvent {
  const RefreshPopularTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshPopularTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvEvent.refreshPopularTv()';
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


class InitialPopularTSeeMore implements SeeMorePopularTvState {
  const InitialPopularTSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialPopularTSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvState.initialPopularTSeeMore()';
}


}




/// @nodoc


class LoadingPopularTSeeMore implements SeeMorePopularTvState {
  const LoadingPopularTSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingPopularTSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularTvState.loadingPopularTSeeMore()';
}


}




/// @nodoc


class LoadedPopularTSeeMore implements SeeMorePopularTvState {
  const LoadedPopularTSeeMore({required final  List<TvSeries> popularTv, required this.popularTvPage, required this.hasMorePopularTv, this.minorError}): _popularTv = popularTv;
  

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
$LoadedPopularTSeeMoreCopyWith<LoadedPopularTSeeMore> get copyWith => _$LoadedPopularTSeeMoreCopyWithImpl<LoadedPopularTSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedPopularTSeeMore&&const DeepCollectionEquality().equals(other._popularTv, _popularTv)&&(identical(other.popularTvPage, popularTvPage) || other.popularTvPage == popularTvPage)&&(identical(other.hasMorePopularTv, hasMorePopularTv) || other.hasMorePopularTv == hasMorePopularTv)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popularTv),popularTvPage,hasMorePopularTv,minorError);

@override
String toString() {
  return 'SeeMorePopularTvState.loadedPopularTSeeMore(popularTv: $popularTv, popularTvPage: $popularTvPage, hasMorePopularTv: $hasMorePopularTv, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedPopularTSeeMoreCopyWith<$Res> implements $SeeMorePopularTvStateCopyWith<$Res> {
  factory $LoadedPopularTSeeMoreCopyWith(LoadedPopularTSeeMore value, $Res Function(LoadedPopularTSeeMore) _then) = _$LoadedPopularTSeeMoreCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> popularTv, int popularTvPage, bool hasMorePopularTv, String? minorError
});




}
/// @nodoc
class _$LoadedPopularTSeeMoreCopyWithImpl<$Res>
    implements $LoadedPopularTSeeMoreCopyWith<$Res> {
  _$LoadedPopularTSeeMoreCopyWithImpl(this._self, this._then);

  final LoadedPopularTSeeMore _self;
  final $Res Function(LoadedPopularTSeeMore) _then;

/// Create a copy of SeeMorePopularTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? popularTv = null,Object? popularTvPage = null,Object? hasMorePopularTv = null,Object? minorError = freezed,}) {
  return _then(LoadedPopularTSeeMore(
popularTv: null == popularTv ? _self._popularTv : popularTv // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,popularTvPage: null == popularTvPage ? _self.popularTvPage : popularTvPage // ignore: cast_nullable_to_non_nullable
as int,hasMorePopularTv: null == hasMorePopularTv ? _self.hasMorePopularTv : hasMorePopularTv // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorPopularTSeeMore implements SeeMorePopularTvState {
  const ErrorPopularTSeeMore(this.message);
  

 final  String message;

/// Create a copy of SeeMorePopularTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorPopularTSeeMoreCopyWith<ErrorPopularTSeeMore> get copyWith => _$ErrorPopularTSeeMoreCopyWithImpl<ErrorPopularTSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorPopularTSeeMore&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeeMorePopularTvState.errorPopularTSeeMore(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorPopularTSeeMoreCopyWith<$Res> implements $SeeMorePopularTvStateCopyWith<$Res> {
  factory $ErrorPopularTSeeMoreCopyWith(ErrorPopularTSeeMore value, $Res Function(ErrorPopularTSeeMore) _then) = _$ErrorPopularTSeeMoreCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorPopularTSeeMoreCopyWithImpl<$Res>
    implements $ErrorPopularTSeeMoreCopyWith<$Res> {
  _$ErrorPopularTSeeMoreCopyWithImpl(this._self, this._then);

  final ErrorPopularTSeeMore _self;
  final $Res Function(ErrorPopularTSeeMore) _then;

/// Create a copy of SeeMorePopularTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorPopularTSeeMore(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
