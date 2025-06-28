// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popular_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PopularTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvEvent()';
}


}

/// @nodoc
class $PopularTvEventCopyWith<$Res>  {
$PopularTvEventCopyWith(PopularTvEvent _, $Res Function(PopularTvEvent) __);
}


/// @nodoc


class FetchInitialPopularTv implements PopularTvEvent {
  const FetchInitialPopularTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialPopularTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvEvent.fetchInitialPopularTv()';
}


}




/// @nodoc


class FetchMorePopularTv implements PopularTvEvent {
  const FetchMorePopularTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMorePopularTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvEvent.fetchMorePopularTv()';
}


}




/// @nodoc


class RefreshPTv implements PopularTvEvent {
  const RefreshPTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshPTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvEvent.refreshPTv()';
}


}




/// @nodoc
mixin _$PopularTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvState()';
}


}

/// @nodoc
class $PopularTvStateCopyWith<$Res>  {
$PopularTvStateCopyWith(PopularTvState _, $Res Function(PopularTvState) __);
}


/// @nodoc


class InitialPopularTv implements PopularTvState {
  const InitialPopularTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialPopularTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvState.initialPopularTv()';
}


}




/// @nodoc


class LoadingPopularTv implements PopularTvState {
  const LoadingPopularTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingPopularTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvState.loadingPopularTv()';
}


}




/// @nodoc


class LoadedPopularTv implements PopularTvState {
  const LoadedPopularTv({required final  List<TvSeries> popular, required this.popularPage, required this.hasMorePopular, this.minorError}): _popular = popular;
  

// Data lists
 final  List<TvSeries> _popular;
// Data lists
 List<TvSeries> get popular {
  if (_popular is EqualUnmodifiableListView) return _popular;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popular);
}

// Pagination pages
 final  int popularPage;
// Pagination flags
 final  bool hasMorePopular;
// Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
 final  String? minorError;

/// Create a copy of PopularTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedPopularTvCopyWith<LoadedPopularTv> get copyWith => _$LoadedPopularTvCopyWithImpl<LoadedPopularTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedPopularTv&&const DeepCollectionEquality().equals(other._popular, _popular)&&(identical(other.popularPage, popularPage) || other.popularPage == popularPage)&&(identical(other.hasMorePopular, hasMorePopular) || other.hasMorePopular == hasMorePopular)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popular),popularPage,hasMorePopular,minorError);

@override
String toString() {
  return 'PopularTvState.loadedPopularTv(popular: $popular, popularPage: $popularPage, hasMorePopular: $hasMorePopular, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedPopularTvCopyWith<$Res> implements $PopularTvStateCopyWith<$Res> {
  factory $LoadedPopularTvCopyWith(LoadedPopularTv value, $Res Function(LoadedPopularTv) _then) = _$LoadedPopularTvCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> popular, int popularPage, bool hasMorePopular, String? minorError
});




}
/// @nodoc
class _$LoadedPopularTvCopyWithImpl<$Res>
    implements $LoadedPopularTvCopyWith<$Res> {
  _$LoadedPopularTvCopyWithImpl(this._self, this._then);

  final LoadedPopularTv _self;
  final $Res Function(LoadedPopularTv) _then;

/// Create a copy of PopularTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? popular = null,Object? popularPage = null,Object? hasMorePopular = null,Object? minorError = freezed,}) {
  return _then(LoadedPopularTv(
popular: null == popular ? _self._popular : popular // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,popularPage: null == popularPage ? _self.popularPage : popularPage // ignore: cast_nullable_to_non_nullable
as int,hasMorePopular: null == hasMorePopular ? _self.hasMorePopular : hasMorePopular // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorPopularTv implements PopularTvState {
  const ErrorPopularTv(this.message);
  

 final  String message;

/// Create a copy of PopularTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorPopularTvCopyWith<ErrorPopularTv> get copyWith => _$ErrorPopularTvCopyWithImpl<ErrorPopularTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorPopularTv&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PopularTvState.errorPopularTv(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorPopularTvCopyWith<$Res> implements $PopularTvStateCopyWith<$Res> {
  factory $ErrorPopularTvCopyWith(ErrorPopularTv value, $Res Function(ErrorPopularTv) _then) = _$ErrorPopularTvCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorPopularTvCopyWithImpl<$Res>
    implements $ErrorPopularTvCopyWith<$Res> {
  _$ErrorPopularTvCopyWithImpl(this._self, this._then);

  final ErrorPopularTv _self;
  final $Res Function(ErrorPopularTv) _then;

/// Create a copy of PopularTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorPopularTv(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
