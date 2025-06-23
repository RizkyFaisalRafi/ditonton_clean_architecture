// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'see_more_on_the_air_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeeMoreOnTheAirTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreOnTheAirTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvEvent()';
}


}

/// @nodoc
class $SeeMoreOnTheAirTvEventCopyWith<$Res>  {
$SeeMoreOnTheAirTvEventCopyWith(SeeMoreOnTheAirTvEvent _, $Res Function(SeeMoreOnTheAirTvEvent) __);
}


/// @nodoc


class FetchInitialOnTheAirTv implements SeeMoreOnTheAirTvEvent {
  const FetchInitialOnTheAirTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialOnTheAirTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirTv()';
}


}




/// @nodoc


class FetchMoreOnTheAirTv implements SeeMoreOnTheAirTvEvent {
  const FetchMoreOnTheAirTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreOnTheAirTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvEvent.fetchMoreOnTheAirTv()';
}


}




/// @nodoc


class RefreshTv implements SeeMoreOnTheAirTvEvent {
  const RefreshTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvEvent.refreshMovies()';
}


}




/// @nodoc
mixin _$SeeMoreOnTheAirTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreOnTheAirTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvState()';
}


}

/// @nodoc
class $SeeMoreOnTheAirTvStateCopyWith<$Res>  {
$SeeMoreOnTheAirTvStateCopyWith(SeeMoreOnTheAirTvState _, $Res Function(SeeMoreOnTheAirTvState) __);
}


/// @nodoc


class Initial implements SeeMoreOnTheAirTvState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvState.initial()';
}


}




/// @nodoc


class Loading implements SeeMoreOnTheAirTvState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvState.loading()';
}


}




/// @nodoc


class Loaded implements SeeMoreOnTheAirTvState {
  const Loaded({required final  List<TvSeries> onTheAir, required this.onTheAirPage, required this.hasMoreOnTheAir, this.minorError}): _onTheAir = onTheAir;
  

// Data List
 final  List<TvSeries> _onTheAir;
// Data List
 List<TvSeries> get onTheAir {
  if (_onTheAir is EqualUnmodifiableListView) return _onTheAir;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_onTheAir);
}

// Pagination Pages
 final  int onTheAirPage;
// Pagination Flags
 final  bool hasMoreOnTheAir;
 final  String? minorError;

/// Create a copy of SeeMoreOnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._onTheAir, _onTheAir)&&(identical(other.onTheAirPage, onTheAirPage) || other.onTheAirPage == onTheAirPage)&&(identical(other.hasMoreOnTheAir, hasMoreOnTheAir) || other.hasMoreOnTheAir == hasMoreOnTheAir)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_onTheAir),onTheAirPage,hasMoreOnTheAir,minorError);

@override
String toString() {
  return 'SeeMoreOnTheAirTvState.loaded(onTheAir: $onTheAir, onTheAirPage: $onTheAirPage, hasMoreOnTheAir: $hasMoreOnTheAir, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $SeeMoreOnTheAirTvStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> onTheAir, int onTheAirPage, bool hasMoreOnTheAir, String? minorError
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of SeeMoreOnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onTheAir = null,Object? onTheAirPage = null,Object? hasMoreOnTheAir = null,Object? minorError = freezed,}) {
  return _then(Loaded(
onTheAir: null == onTheAir ? _self._onTheAir : onTheAir // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,onTheAirPage: null == onTheAirPage ? _self.onTheAirPage : onTheAirPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreOnTheAir: null == hasMoreOnTheAir ? _self.hasMoreOnTheAir : hasMoreOnTheAir // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements SeeMoreOnTheAirTvState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of SeeMoreOnTheAirTvState
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
  return 'SeeMoreOnTheAirTvState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $SeeMoreOnTheAirTvStateCopyWith<$Res> {
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

/// Create a copy of SeeMoreOnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
