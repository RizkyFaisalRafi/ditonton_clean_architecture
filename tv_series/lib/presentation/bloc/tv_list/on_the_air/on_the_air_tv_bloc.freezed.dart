// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'on_the_air_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnTheAirTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnTheAirTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnTheAirTvEvent()';
}


}

/// @nodoc
class $OnTheAirTvEventCopyWith<$Res>  {
$OnTheAirTvEventCopyWith(OnTheAirTvEvent _, $Res Function(OnTheAirTvEvent) __);
}


/// @nodoc


class FetchInitialOnTheAir implements OnTheAirTvEvent {
  const FetchInitialOnTheAir();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialOnTheAir);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnTheAirTvEvent.fetchInitialOnTheAir()';
}


}




/// @nodoc


class FetchMoreOnTheAirTv implements OnTheAirTvEvent {
  const FetchMoreOnTheAirTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreOnTheAirTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnTheAirTvEvent.fetchMoreOnTheAirTv()';
}


}




/// @nodoc


class RefreshTvOta implements OnTheAirTvEvent {
  const RefreshTvOta();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTvOta);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnTheAirTvEvent.refreshTvOta()';
}


}




/// @nodoc
mixin _$OnTheAirTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnTheAirTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnTheAirTvState()';
}


}

/// @nodoc
class $OnTheAirTvStateCopyWith<$Res>  {
$OnTheAirTvStateCopyWith(OnTheAirTvState _, $Res Function(OnTheAirTvState) __);
}


/// @nodoc


class InitialOtaTv implements OnTheAirTvState {
  const InitialOtaTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialOtaTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnTheAirTvState.initialOtaTv()';
}


}




/// @nodoc


class LoadingOtaTv implements OnTheAirTvState {
  const LoadingOtaTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingOtaTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnTheAirTvState.loadingOtaTv()';
}


}




/// @nodoc


class LoadedOtaTv implements OnTheAirTvState {
  const LoadedOtaTv({required final  List<TvSeries> onTheAir, required this.onTheAirPage, required this.hasMoreOnTheAir, this.minorError}): _onTheAir = onTheAir;
  

// Data lists
 final  List<TvSeries> _onTheAir;
// Data lists
 List<TvSeries> get onTheAir {
  if (_onTheAir is EqualUnmodifiableListView) return _onTheAir;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_onTheAir);
}

// Pagination pages
 final  int onTheAirPage;
// Pagination flags
 final  bool hasMoreOnTheAir;
// Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
 final  String? minorError;

/// Create a copy of OnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedOtaTvCopyWith<LoadedOtaTv> get copyWith => _$LoadedOtaTvCopyWithImpl<LoadedOtaTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedOtaTv&&const DeepCollectionEquality().equals(other._onTheAir, _onTheAir)&&(identical(other.onTheAirPage, onTheAirPage) || other.onTheAirPage == onTheAirPage)&&(identical(other.hasMoreOnTheAir, hasMoreOnTheAir) || other.hasMoreOnTheAir == hasMoreOnTheAir)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_onTheAir),onTheAirPage,hasMoreOnTheAir,minorError);

@override
String toString() {
  return 'OnTheAirTvState.loadedOtaTv(onTheAir: $onTheAir, onTheAirPage: $onTheAirPage, hasMoreOnTheAir: $hasMoreOnTheAir, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedOtaTvCopyWith<$Res> implements $OnTheAirTvStateCopyWith<$Res> {
  factory $LoadedOtaTvCopyWith(LoadedOtaTv value, $Res Function(LoadedOtaTv) _then) = _$LoadedOtaTvCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> onTheAir, int onTheAirPage, bool hasMoreOnTheAir, String? minorError
});




}
/// @nodoc
class _$LoadedOtaTvCopyWithImpl<$Res>
    implements $LoadedOtaTvCopyWith<$Res> {
  _$LoadedOtaTvCopyWithImpl(this._self, this._then);

  final LoadedOtaTv _self;
  final $Res Function(LoadedOtaTv) _then;

/// Create a copy of OnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onTheAir = null,Object? onTheAirPage = null,Object? hasMoreOnTheAir = null,Object? minorError = freezed,}) {
  return _then(LoadedOtaTv(
onTheAir: null == onTheAir ? _self._onTheAir : onTheAir // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,onTheAirPage: null == onTheAirPage ? _self.onTheAirPage : onTheAirPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreOnTheAir: null == hasMoreOnTheAir ? _self.hasMoreOnTheAir : hasMoreOnTheAir // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorOtaTv implements OnTheAirTvState {
  const ErrorOtaTv(this.message);
  

 final  String message;

/// Create a copy of OnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorOtaTvCopyWith<ErrorOtaTv> get copyWith => _$ErrorOtaTvCopyWithImpl<ErrorOtaTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorOtaTv&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OnTheAirTvState.errorOtaTv(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorOtaTvCopyWith<$Res> implements $OnTheAirTvStateCopyWith<$Res> {
  factory $ErrorOtaTvCopyWith(ErrorOtaTv value, $Res Function(ErrorOtaTv) _then) = _$ErrorOtaTvCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorOtaTvCopyWithImpl<$Res>
    implements $ErrorOtaTvCopyWith<$Res> {
  _$ErrorOtaTvCopyWithImpl(this._self, this._then);

  final ErrorOtaTv _self;
  final $Res Function(ErrorOtaTv) _then;

/// Create a copy of OnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorOtaTv(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
