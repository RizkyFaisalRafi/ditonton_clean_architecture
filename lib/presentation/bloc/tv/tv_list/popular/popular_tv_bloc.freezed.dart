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


class FetchInitialTvS implements PopularTvEvent {
  const FetchInitialTvS();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTvS);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvEvent.fetchInitialTvS()';
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


class RefreshTv implements PopularTvEvent {
  const RefreshTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvEvent.refreshTv()';
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


class Initial implements PopularTvState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvState.initial()';
}


}




/// @nodoc


class Loading implements PopularTvState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PopularTvState.loading()';
}


}




/// @nodoc


class Loaded implements PopularTvState {
  const Loaded({required final  List<TvSeries> popular, required this.popularPage, required this.hasMorePopular, this.minorError}): _popular = popular;
  

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
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._popular, _popular)&&(identical(other.popularPage, popularPage) || other.popularPage == popularPage)&&(identical(other.hasMorePopular, hasMorePopular) || other.hasMorePopular == hasMorePopular)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popular),popularPage,hasMorePopular,minorError);

@override
String toString() {
  return 'PopularTvState.loaded(popular: $popular, popularPage: $popularPage, hasMorePopular: $hasMorePopular, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $PopularTvStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> popular, int popularPage, bool hasMorePopular, String? minorError
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of PopularTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? popular = null,Object? popularPage = null,Object? hasMorePopular = null,Object? minorError = freezed,}) {
  return _then(Loaded(
popular: null == popular ? _self._popular : popular // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,popularPage: null == popularPage ? _self.popularPage : popularPage // ignore: cast_nullable_to_non_nullable
as int,hasMorePopular: null == hasMorePopular ? _self.hasMorePopular : hasMorePopular // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements PopularTvState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of PopularTvState
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
  return 'PopularTvState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $PopularTvStateCopyWith<$Res> {
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

/// Create a copy of PopularTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
