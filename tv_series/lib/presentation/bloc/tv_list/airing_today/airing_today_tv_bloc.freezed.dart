// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [AiringTodayTvEvent].
extension AiringTodayTvEventPatterns on AiringTodayTvEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchInitialAiringToday value)?  fetchInitialAiringToday,TResult Function( FetchMoreAiringTodayTv value)?  fetchMoreAiringTodayTv,TResult Function( RefreshTvAt value)?  refreshTvAt,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchInitialAiringToday() when fetchInitialAiringToday != null:
return fetchInitialAiringToday(_that);case FetchMoreAiringTodayTv() when fetchMoreAiringTodayTv != null:
return fetchMoreAiringTodayTv(_that);case RefreshTvAt() when refreshTvAt != null:
return refreshTvAt(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchInitialAiringToday value)  fetchInitialAiringToday,required TResult Function( FetchMoreAiringTodayTv value)  fetchMoreAiringTodayTv,required TResult Function( RefreshTvAt value)  refreshTvAt,}){
final _that = this;
switch (_that) {
case FetchInitialAiringToday():
return fetchInitialAiringToday(_that);case FetchMoreAiringTodayTv():
return fetchMoreAiringTodayTv(_that);case RefreshTvAt():
return refreshTvAt(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchInitialAiringToday value)?  fetchInitialAiringToday,TResult? Function( FetchMoreAiringTodayTv value)?  fetchMoreAiringTodayTv,TResult? Function( RefreshTvAt value)?  refreshTvAt,}){
final _that = this;
switch (_that) {
case FetchInitialAiringToday() when fetchInitialAiringToday != null:
return fetchInitialAiringToday(_that);case FetchMoreAiringTodayTv() when fetchMoreAiringTodayTv != null:
return fetchMoreAiringTodayTv(_that);case RefreshTvAt() when refreshTvAt != null:
return refreshTvAt(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchInitialAiringToday,TResult Function()?  fetchMoreAiringTodayTv,TResult Function()?  refreshTvAt,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchInitialAiringToday() when fetchInitialAiringToday != null:
return fetchInitialAiringToday();case FetchMoreAiringTodayTv() when fetchMoreAiringTodayTv != null:
return fetchMoreAiringTodayTv();case RefreshTvAt() when refreshTvAt != null:
return refreshTvAt();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchInitialAiringToday,required TResult Function()  fetchMoreAiringTodayTv,required TResult Function()  refreshTvAt,}) {final _that = this;
switch (_that) {
case FetchInitialAiringToday():
return fetchInitialAiringToday();case FetchMoreAiringTodayTv():
return fetchMoreAiringTodayTv();case RefreshTvAt():
return refreshTvAt();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchInitialAiringToday,TResult? Function()?  fetchMoreAiringTodayTv,TResult? Function()?  refreshTvAt,}) {final _that = this;
switch (_that) {
case FetchInitialAiringToday() when fetchInitialAiringToday != null:
return fetchInitialAiringToday();case FetchMoreAiringTodayTv() when fetchMoreAiringTodayTv != null:
return fetchMoreAiringTodayTv();case RefreshTvAt() when refreshTvAt != null:
return refreshTvAt();case _:
  return null;

}
}

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


/// Adds pattern-matching-related methods to [AiringTodayTvState].
extension AiringTodayTvStatePatterns on AiringTodayTvState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialAtTv value)?  initialAtTv,TResult Function( LoadingAtTv value)?  loadingAtTv,TResult Function( LoadedAtTv value)?  loadedAtTv,TResult Function( ErrorAtTv value)?  errorAtTv,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialAtTv() when initialAtTv != null:
return initialAtTv(_that);case LoadingAtTv() when loadingAtTv != null:
return loadingAtTv(_that);case LoadedAtTv() when loadedAtTv != null:
return loadedAtTv(_that);case ErrorAtTv() when errorAtTv != null:
return errorAtTv(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialAtTv value)  initialAtTv,required TResult Function( LoadingAtTv value)  loadingAtTv,required TResult Function( LoadedAtTv value)  loadedAtTv,required TResult Function( ErrorAtTv value)  errorAtTv,}){
final _that = this;
switch (_that) {
case InitialAtTv():
return initialAtTv(_that);case LoadingAtTv():
return loadingAtTv(_that);case LoadedAtTv():
return loadedAtTv(_that);case ErrorAtTv():
return errorAtTv(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialAtTv value)?  initialAtTv,TResult? Function( LoadingAtTv value)?  loadingAtTv,TResult? Function( LoadedAtTv value)?  loadedAtTv,TResult? Function( ErrorAtTv value)?  errorAtTv,}){
final _that = this;
switch (_that) {
case InitialAtTv() when initialAtTv != null:
return initialAtTv(_that);case LoadingAtTv() when loadingAtTv != null:
return loadingAtTv(_that);case LoadedAtTv() when loadedAtTv != null:
return loadedAtTv(_that);case ErrorAtTv() when errorAtTv != null:
return errorAtTv(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialAtTv,TResult Function()?  loadingAtTv,TResult Function( List<TvSeries> airingToday,  int airingTodayPage,  bool hasMoreAiringToday,  String? minorError)?  loadedAtTv,TResult Function( String message)?  errorAtTv,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialAtTv() when initialAtTv != null:
return initialAtTv();case LoadingAtTv() when loadingAtTv != null:
return loadingAtTv();case LoadedAtTv() when loadedAtTv != null:
return loadedAtTv(_that.airingToday,_that.airingTodayPage,_that.hasMoreAiringToday,_that.minorError);case ErrorAtTv() when errorAtTv != null:
return errorAtTv(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialAtTv,required TResult Function()  loadingAtTv,required TResult Function( List<TvSeries> airingToday,  int airingTodayPage,  bool hasMoreAiringToday,  String? minorError)  loadedAtTv,required TResult Function( String message)  errorAtTv,}) {final _that = this;
switch (_that) {
case InitialAtTv():
return initialAtTv();case LoadingAtTv():
return loadingAtTv();case LoadedAtTv():
return loadedAtTv(_that.airingToday,_that.airingTodayPage,_that.hasMoreAiringToday,_that.minorError);case ErrorAtTv():
return errorAtTv(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialAtTv,TResult? Function()?  loadingAtTv,TResult? Function( List<TvSeries> airingToday,  int airingTodayPage,  bool hasMoreAiringToday,  String? minorError)?  loadedAtTv,TResult? Function( String message)?  errorAtTv,}) {final _that = this;
switch (_that) {
case InitialAtTv() when initialAtTv != null:
return initialAtTv();case LoadingAtTv() when loadingAtTv != null:
return loadingAtTv();case LoadedAtTv() when loadedAtTv != null:
return loadedAtTv(_that.airingToday,_that.airingTodayPage,_that.hasMoreAiringToday,_that.minorError);case ErrorAtTv() when errorAtTv != null:
return errorAtTv(_that.message);case _:
  return null;

}
}

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
