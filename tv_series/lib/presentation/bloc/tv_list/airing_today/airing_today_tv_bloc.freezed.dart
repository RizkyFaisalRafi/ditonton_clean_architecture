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


class FetchInitialAiringToday implements AiringTodayTvEvent {
  const FetchInitialAiringToday();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialAiringToday);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvEvent.fetchInitialAiringToday()';
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


class RefreshTvAt implements AiringTodayTvEvent {
  const RefreshTvAt();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTvAt);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvEvent.refreshTvAt()';
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


class InitialAtTv implements AiringTodayTvState {
  const InitialAtTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialAtTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvState.initialAtTv()';
}


}




/// @nodoc


class LoadingAtTv implements AiringTodayTvState {
  const LoadingAtTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingAtTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AiringTodayTvState.loadingAtTv()';
}


}




/// @nodoc


class LoadedAtTv implements AiringTodayTvState {
  const LoadedAtTv({required final  List<TvSeries> airingToday, required this.airingTodayPage, required this.hasMoreAiringToday, this.minorError}): _airingToday = airingToday;
  

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
$LoadedAtTvCopyWith<LoadedAtTv> get copyWith => _$LoadedAtTvCopyWithImpl<LoadedAtTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedAtTv&&const DeepCollectionEquality().equals(other._airingToday, _airingToday)&&(identical(other.airingTodayPage, airingTodayPage) || other.airingTodayPage == airingTodayPage)&&(identical(other.hasMoreAiringToday, hasMoreAiringToday) || other.hasMoreAiringToday == hasMoreAiringToday)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_airingToday),airingTodayPage,hasMoreAiringToday,minorError);

@override
String toString() {
  return 'AiringTodayTvState.loadedAtTv(airingToday: $airingToday, airingTodayPage: $airingTodayPage, hasMoreAiringToday: $hasMoreAiringToday, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedAtTvCopyWith<$Res> implements $AiringTodayTvStateCopyWith<$Res> {
  factory $LoadedAtTvCopyWith(LoadedAtTv value, $Res Function(LoadedAtTv) _then) = _$LoadedAtTvCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> airingToday, int airingTodayPage, bool hasMoreAiringToday, String? minorError
});




}
/// @nodoc
class _$LoadedAtTvCopyWithImpl<$Res>
    implements $LoadedAtTvCopyWith<$Res> {
  _$LoadedAtTvCopyWithImpl(this._self, this._then);

  final LoadedAtTv _self;
  final $Res Function(LoadedAtTv) _then;

/// Create a copy of AiringTodayTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? airingToday = null,Object? airingTodayPage = null,Object? hasMoreAiringToday = null,Object? minorError = freezed,}) {
  return _then(LoadedAtTv(
airingToday: null == airingToday ? _self._airingToday : airingToday // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,airingTodayPage: null == airingTodayPage ? _self.airingTodayPage : airingTodayPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreAiringToday: null == hasMoreAiringToday ? _self.hasMoreAiringToday : hasMoreAiringToday // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorAtTv implements AiringTodayTvState {
  const ErrorAtTv(this.message);
  

 final  String message;

/// Create a copy of AiringTodayTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorAtTvCopyWith<ErrorAtTv> get copyWith => _$ErrorAtTvCopyWithImpl<ErrorAtTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorAtTv&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AiringTodayTvState.errorAtTv(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorAtTvCopyWith<$Res> implements $AiringTodayTvStateCopyWith<$Res> {
  factory $ErrorAtTvCopyWith(ErrorAtTv value, $Res Function(ErrorAtTv) _then) = _$ErrorAtTvCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorAtTvCopyWithImpl<$Res>
    implements $ErrorAtTvCopyWith<$Res> {
  _$ErrorAtTvCopyWithImpl(this._self, this._then);

  final ErrorAtTv _self;
  final $Res Function(ErrorAtTv) _then;

/// Create a copy of AiringTodayTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorAtTv(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
