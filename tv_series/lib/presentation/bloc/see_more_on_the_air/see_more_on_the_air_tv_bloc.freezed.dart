// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [SeeMoreOnTheAirTvEvent].
extension SeeMoreOnTheAirTvEventPatterns on SeeMoreOnTheAirTvEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchInitialOnTheAirSeeMoreTv value)?  fetchInitialOnTheAirSeeMoreTv,TResult Function( FetchMoreOnTheAirSeeMoreTv value)?  fetchMoreOnTheAirSeeMoreTv,TResult Function( RefreshOnTheAirTv value)?  refreshOnTheAirTv,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchInitialOnTheAirSeeMoreTv() when fetchInitialOnTheAirSeeMoreTv != null:
return fetchInitialOnTheAirSeeMoreTv(_that);case FetchMoreOnTheAirSeeMoreTv() when fetchMoreOnTheAirSeeMoreTv != null:
return fetchMoreOnTheAirSeeMoreTv(_that);case RefreshOnTheAirTv() when refreshOnTheAirTv != null:
return refreshOnTheAirTv(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchInitialOnTheAirSeeMoreTv value)  fetchInitialOnTheAirSeeMoreTv,required TResult Function( FetchMoreOnTheAirSeeMoreTv value)  fetchMoreOnTheAirSeeMoreTv,required TResult Function( RefreshOnTheAirTv value)  refreshOnTheAirTv,}){
final _that = this;
switch (_that) {
case FetchInitialOnTheAirSeeMoreTv():
return fetchInitialOnTheAirSeeMoreTv(_that);case FetchMoreOnTheAirSeeMoreTv():
return fetchMoreOnTheAirSeeMoreTv(_that);case RefreshOnTheAirTv():
return refreshOnTheAirTv(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchInitialOnTheAirSeeMoreTv value)?  fetchInitialOnTheAirSeeMoreTv,TResult? Function( FetchMoreOnTheAirSeeMoreTv value)?  fetchMoreOnTheAirSeeMoreTv,TResult? Function( RefreshOnTheAirTv value)?  refreshOnTheAirTv,}){
final _that = this;
switch (_that) {
case FetchInitialOnTheAirSeeMoreTv() when fetchInitialOnTheAirSeeMoreTv != null:
return fetchInitialOnTheAirSeeMoreTv(_that);case FetchMoreOnTheAirSeeMoreTv() when fetchMoreOnTheAirSeeMoreTv != null:
return fetchMoreOnTheAirSeeMoreTv(_that);case RefreshOnTheAirTv() when refreshOnTheAirTv != null:
return refreshOnTheAirTv(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchInitialOnTheAirSeeMoreTv,TResult Function()?  fetchMoreOnTheAirSeeMoreTv,TResult Function()?  refreshOnTheAirTv,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchInitialOnTheAirSeeMoreTv() when fetchInitialOnTheAirSeeMoreTv != null:
return fetchInitialOnTheAirSeeMoreTv();case FetchMoreOnTheAirSeeMoreTv() when fetchMoreOnTheAirSeeMoreTv != null:
return fetchMoreOnTheAirSeeMoreTv();case RefreshOnTheAirTv() when refreshOnTheAirTv != null:
return refreshOnTheAirTv();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchInitialOnTheAirSeeMoreTv,required TResult Function()  fetchMoreOnTheAirSeeMoreTv,required TResult Function()  refreshOnTheAirTv,}) {final _that = this;
switch (_that) {
case FetchInitialOnTheAirSeeMoreTv():
return fetchInitialOnTheAirSeeMoreTv();case FetchMoreOnTheAirSeeMoreTv():
return fetchMoreOnTheAirSeeMoreTv();case RefreshOnTheAirTv():
return refreshOnTheAirTv();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchInitialOnTheAirSeeMoreTv,TResult? Function()?  fetchMoreOnTheAirSeeMoreTv,TResult? Function()?  refreshOnTheAirTv,}) {final _that = this;
switch (_that) {
case FetchInitialOnTheAirSeeMoreTv() when fetchInitialOnTheAirSeeMoreTv != null:
return fetchInitialOnTheAirSeeMoreTv();case FetchMoreOnTheAirSeeMoreTv() when fetchMoreOnTheAirSeeMoreTv != null:
return fetchMoreOnTheAirSeeMoreTv();case RefreshOnTheAirTv() when refreshOnTheAirTv != null:
return refreshOnTheAirTv();case _:
  return null;

}
}

}

/// @nodoc


class FetchInitialOnTheAirSeeMoreTv implements SeeMoreOnTheAirTvEvent {
  const FetchInitialOnTheAirSeeMoreTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialOnTheAirSeeMoreTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirSeeMoreTv()';
}


}




/// @nodoc


class FetchMoreOnTheAirSeeMoreTv implements SeeMoreOnTheAirTvEvent {
  const FetchMoreOnTheAirSeeMoreTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreOnTheAirSeeMoreTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvEvent.fetchMoreOnTheAirSeeMoreTv()';
}


}




/// @nodoc


class RefreshOnTheAirTv implements SeeMoreOnTheAirTvEvent {
  const RefreshOnTheAirTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshOnTheAirTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvEvent.refreshOnTheAirTv()';
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


/// Adds pattern-matching-related methods to [SeeMoreOnTheAirTvState].
extension SeeMoreOnTheAirTvStatePatterns on SeeMoreOnTheAirTvState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialOnTheAirTSeeMore value)?  initialOnTheAirTSeeMore,TResult Function( LoadingOnTheAirTSeeMore value)?  loadingOnTheAirTSeeMore,TResult Function( LoadedOnTheAirTSeeMore value)?  loadedOnTheAirTSeeMore,TResult Function( ErrorOnTheAirTSeeMore value)?  errorOnTheAirTSeeMore,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialOnTheAirTSeeMore() when initialOnTheAirTSeeMore != null:
return initialOnTheAirTSeeMore(_that);case LoadingOnTheAirTSeeMore() when loadingOnTheAirTSeeMore != null:
return loadingOnTheAirTSeeMore(_that);case LoadedOnTheAirTSeeMore() when loadedOnTheAirTSeeMore != null:
return loadedOnTheAirTSeeMore(_that);case ErrorOnTheAirTSeeMore() when errorOnTheAirTSeeMore != null:
return errorOnTheAirTSeeMore(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialOnTheAirTSeeMore value)  initialOnTheAirTSeeMore,required TResult Function( LoadingOnTheAirTSeeMore value)  loadingOnTheAirTSeeMore,required TResult Function( LoadedOnTheAirTSeeMore value)  loadedOnTheAirTSeeMore,required TResult Function( ErrorOnTheAirTSeeMore value)  errorOnTheAirTSeeMore,}){
final _that = this;
switch (_that) {
case InitialOnTheAirTSeeMore():
return initialOnTheAirTSeeMore(_that);case LoadingOnTheAirTSeeMore():
return loadingOnTheAirTSeeMore(_that);case LoadedOnTheAirTSeeMore():
return loadedOnTheAirTSeeMore(_that);case ErrorOnTheAirTSeeMore():
return errorOnTheAirTSeeMore(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialOnTheAirTSeeMore value)?  initialOnTheAirTSeeMore,TResult? Function( LoadingOnTheAirTSeeMore value)?  loadingOnTheAirTSeeMore,TResult? Function( LoadedOnTheAirTSeeMore value)?  loadedOnTheAirTSeeMore,TResult? Function( ErrorOnTheAirTSeeMore value)?  errorOnTheAirTSeeMore,}){
final _that = this;
switch (_that) {
case InitialOnTheAirTSeeMore() when initialOnTheAirTSeeMore != null:
return initialOnTheAirTSeeMore(_that);case LoadingOnTheAirTSeeMore() when loadingOnTheAirTSeeMore != null:
return loadingOnTheAirTSeeMore(_that);case LoadedOnTheAirTSeeMore() when loadedOnTheAirTSeeMore != null:
return loadedOnTheAirTSeeMore(_that);case ErrorOnTheAirTSeeMore() when errorOnTheAirTSeeMore != null:
return errorOnTheAirTSeeMore(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialOnTheAirTSeeMore,TResult Function()?  loadingOnTheAirTSeeMore,TResult Function( List<TvSeries> onTheAir,  int onTheAirPage,  bool hasMoreOnTheAir,  String? minorError)?  loadedOnTheAirTSeeMore,TResult Function( String message)?  errorOnTheAirTSeeMore,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialOnTheAirTSeeMore() when initialOnTheAirTSeeMore != null:
return initialOnTheAirTSeeMore();case LoadingOnTheAirTSeeMore() when loadingOnTheAirTSeeMore != null:
return loadingOnTheAirTSeeMore();case LoadedOnTheAirTSeeMore() when loadedOnTheAirTSeeMore != null:
return loadedOnTheAirTSeeMore(_that.onTheAir,_that.onTheAirPage,_that.hasMoreOnTheAir,_that.minorError);case ErrorOnTheAirTSeeMore() when errorOnTheAirTSeeMore != null:
return errorOnTheAirTSeeMore(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialOnTheAirTSeeMore,required TResult Function()  loadingOnTheAirTSeeMore,required TResult Function( List<TvSeries> onTheAir,  int onTheAirPage,  bool hasMoreOnTheAir,  String? minorError)  loadedOnTheAirTSeeMore,required TResult Function( String message)  errorOnTheAirTSeeMore,}) {final _that = this;
switch (_that) {
case InitialOnTheAirTSeeMore():
return initialOnTheAirTSeeMore();case LoadingOnTheAirTSeeMore():
return loadingOnTheAirTSeeMore();case LoadedOnTheAirTSeeMore():
return loadedOnTheAirTSeeMore(_that.onTheAir,_that.onTheAirPage,_that.hasMoreOnTheAir,_that.minorError);case ErrorOnTheAirTSeeMore():
return errorOnTheAirTSeeMore(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialOnTheAirTSeeMore,TResult? Function()?  loadingOnTheAirTSeeMore,TResult? Function( List<TvSeries> onTheAir,  int onTheAirPage,  bool hasMoreOnTheAir,  String? minorError)?  loadedOnTheAirTSeeMore,TResult? Function( String message)?  errorOnTheAirTSeeMore,}) {final _that = this;
switch (_that) {
case InitialOnTheAirTSeeMore() when initialOnTheAirTSeeMore != null:
return initialOnTheAirTSeeMore();case LoadingOnTheAirTSeeMore() when loadingOnTheAirTSeeMore != null:
return loadingOnTheAirTSeeMore();case LoadedOnTheAirTSeeMore() when loadedOnTheAirTSeeMore != null:
return loadedOnTheAirTSeeMore(_that.onTheAir,_that.onTheAirPage,_that.hasMoreOnTheAir,_that.minorError);case ErrorOnTheAirTSeeMore() when errorOnTheAirTSeeMore != null:
return errorOnTheAirTSeeMore(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InitialOnTheAirTSeeMore implements SeeMoreOnTheAirTvState {
  const InitialOnTheAirTSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialOnTheAirTSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvState.initialOnTheAirTSeeMore()';
}


}




/// @nodoc


class LoadingOnTheAirTSeeMore implements SeeMoreOnTheAirTvState {
  const LoadingOnTheAirTSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingOnTheAirTSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreOnTheAirTvState.loadingOnTheAirTSeeMore()';
}


}




/// @nodoc


class LoadedOnTheAirTSeeMore implements SeeMoreOnTheAirTvState {
  const LoadedOnTheAirTSeeMore({required final  List<TvSeries> onTheAir, required this.onTheAirPage, required this.hasMoreOnTheAir, this.minorError}): _onTheAir = onTheAir;
  

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
$LoadedOnTheAirTSeeMoreCopyWith<LoadedOnTheAirTSeeMore> get copyWith => _$LoadedOnTheAirTSeeMoreCopyWithImpl<LoadedOnTheAirTSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedOnTheAirTSeeMore&&const DeepCollectionEquality().equals(other._onTheAir, _onTheAir)&&(identical(other.onTheAirPage, onTheAirPage) || other.onTheAirPage == onTheAirPage)&&(identical(other.hasMoreOnTheAir, hasMoreOnTheAir) || other.hasMoreOnTheAir == hasMoreOnTheAir)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_onTheAir),onTheAirPage,hasMoreOnTheAir,minorError);

@override
String toString() {
  return 'SeeMoreOnTheAirTvState.loadedOnTheAirTSeeMore(onTheAir: $onTheAir, onTheAirPage: $onTheAirPage, hasMoreOnTheAir: $hasMoreOnTheAir, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedOnTheAirTSeeMoreCopyWith<$Res> implements $SeeMoreOnTheAirTvStateCopyWith<$Res> {
  factory $LoadedOnTheAirTSeeMoreCopyWith(LoadedOnTheAirTSeeMore value, $Res Function(LoadedOnTheAirTSeeMore) _then) = _$LoadedOnTheAirTSeeMoreCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> onTheAir, int onTheAirPage, bool hasMoreOnTheAir, String? minorError
});




}
/// @nodoc
class _$LoadedOnTheAirTSeeMoreCopyWithImpl<$Res>
    implements $LoadedOnTheAirTSeeMoreCopyWith<$Res> {
  _$LoadedOnTheAirTSeeMoreCopyWithImpl(this._self, this._then);

  final LoadedOnTheAirTSeeMore _self;
  final $Res Function(LoadedOnTheAirTSeeMore) _then;

/// Create a copy of SeeMoreOnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? onTheAir = null,Object? onTheAirPage = null,Object? hasMoreOnTheAir = null,Object? minorError = freezed,}) {
  return _then(LoadedOnTheAirTSeeMore(
onTheAir: null == onTheAir ? _self._onTheAir : onTheAir // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,onTheAirPage: null == onTheAirPage ? _self.onTheAirPage : onTheAirPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreOnTheAir: null == hasMoreOnTheAir ? _self.hasMoreOnTheAir : hasMoreOnTheAir // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorOnTheAirTSeeMore implements SeeMoreOnTheAirTvState {
  const ErrorOnTheAirTSeeMore(this.message);
  

 final  String message;

/// Create a copy of SeeMoreOnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorOnTheAirTSeeMoreCopyWith<ErrorOnTheAirTSeeMore> get copyWith => _$ErrorOnTheAirTSeeMoreCopyWithImpl<ErrorOnTheAirTSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorOnTheAirTSeeMore&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeeMoreOnTheAirTvState.errorOnTheAirTSeeMore(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorOnTheAirTSeeMoreCopyWith<$Res> implements $SeeMoreOnTheAirTvStateCopyWith<$Res> {
  factory $ErrorOnTheAirTSeeMoreCopyWith(ErrorOnTheAirTSeeMore value, $Res Function(ErrorOnTheAirTSeeMore) _then) = _$ErrorOnTheAirTSeeMoreCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorOnTheAirTSeeMoreCopyWithImpl<$Res>
    implements $ErrorOnTheAirTSeeMoreCopyWith<$Res> {
  _$ErrorOnTheAirTSeeMoreCopyWithImpl(this._self, this._then);

  final ErrorOnTheAirTSeeMore _self;
  final $Res Function(ErrorOnTheAirTSeeMore) _then;

/// Create a copy of SeeMoreOnTheAirTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorOnTheAirTSeeMore(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
