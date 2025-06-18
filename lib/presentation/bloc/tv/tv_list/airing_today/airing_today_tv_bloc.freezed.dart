// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airing_today_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiringTodayTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiringTodayTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvEvent()';
}


}

/// @nodoc
class $AiringTodayTvEventCopyWith<$Res>  {
$AiringTodayTvEventCopyWith(AiringTodayTvEvent _, $Res Function(AiringTodayTvEvent) __);
}


/// @nodoc


class FetchInitialTvS implements AiringTodayTvEvent {
  const FetchInitialTvS();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTvS);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvEvent.fetchInitialTvS()';
}


}




/// @nodoc


class FetchMoreAiringTodayTv implements AiringTodayTvEvent {
  const FetchMoreAiringTodayTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreAiringTodayTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvEvent.fetchMoreAiringTodayTv()';
}


}




/// @nodoc


class RefreshTv implements AiringTodayTvEvent {
  const RefreshTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvEvent.refreshTv()';
}


}




/// @nodoc
mixin _$AiringTodayTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiringTodayTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvState()';
}


}

/// @nodoc
class $AiringTodayTvStateCopyWith<$Res>  {
$AiringTodayTvStateCopyWith(AiringTodayTvState _, $Res Function(AiringTodayTvState) __);
}


/// @nodoc


class Initial implements AiringTodayTvState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvState.initial()';
}


}




/// @nodoc


class Loading implements AiringTodayTvState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvState.loading()';
}


}




/// @nodoc


class Loaded implements AiringTodayTvState {
  const Loaded({required final  List<TvSeries> airingToday, required this.airingTodayPage, required this.hasMoreAiringToday, this.minorError}): _airingToday = airingToday;
  

// Data lists
 final  List<TvSeries> _airingToday;
// Data lists
 List<TvSeries> get airingToday {
  if (_airingToday is EqualUnmodifiableListView) return _airingToday;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_airingToday);
}

// Pagination pages
 final  int airingTodayPage;
// Pagination flags
 final  bool hasMoreAiringToday;
// Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
 final  String? minorError;

/// Create a copy of AiringTodayTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&const DeepCollectionEquality().equals(other._airingToday, _airingToday)&&(identical(other.airingTodayPage, airingTodayPage) || other.airingTodayPage == airingTodayPage)&&(identical(other.hasMoreAiringToday, hasMoreAiringToday) || other.hasMoreAiringToday == hasMoreAiringToday)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_airingToday),airingTodayPage,hasMoreAiringToday,minorError);

@override
String toString() {
  return 'AiringTodayTvState.loaded(airingToday: $airingToday, airingTodayPage: $airingTodayPage, hasMoreAiringToday: $hasMoreAiringToday, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $AiringTodayTvStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> airingToday, int airingTodayPage, bool hasMoreAiringToday, String? minorError
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of AiringTodayTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? airingToday = null,Object? airingTodayPage = null,Object? hasMoreAiringToday = null,Object? minorError = freezed,}) {
  return _then(Loaded(
airingToday: null == airingToday ? _self._airingToday : airingToday // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,airingTodayPage: null == airingTodayPage ? _self.airingTodayPage : airingTodayPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreAiringToday: null == hasMoreAiringToday ? _self.hasMoreAiringToday : hasMoreAiringToday // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements AiringTodayTvState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of AiringTodayTvState
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
  return 'AiringTodayTvState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $AiringTodayTvStateCopyWith<$Res> {
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

/// Create a copy of AiringTodayTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
