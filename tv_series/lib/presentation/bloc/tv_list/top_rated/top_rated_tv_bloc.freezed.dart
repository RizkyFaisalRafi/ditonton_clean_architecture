// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_rated_tv_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TopRatedTvEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopRatedTvEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent()';
}


}

/// @nodoc
class $TopRatedTvEventCopyWith<$Res>  {
$TopRatedTvEventCopyWith(TopRatedTvEvent _, $Res Function(TopRatedTvEvent) __);
}


/// Adds pattern-matching-related methods to [TopRatedTvEvent].
extension TopRatedTvEventPatterns on TopRatedTvEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchInitialTopRatedTv value)?  fetchInitialTopRatedTv,TResult Function( FetchMoreTopRatedTv value)?  fetchMoreTopRatedTv,TResult Function( RefreshTvTr value)?  refreshTvTr,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchInitialTopRatedTv() when fetchInitialTopRatedTv != null:
return fetchInitialTopRatedTv(_that);case FetchMoreTopRatedTv() when fetchMoreTopRatedTv != null:
return fetchMoreTopRatedTv(_that);case RefreshTvTr() when refreshTvTr != null:
return refreshTvTr(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchInitialTopRatedTv value)  fetchInitialTopRatedTv,required TResult Function( FetchMoreTopRatedTv value)  fetchMoreTopRatedTv,required TResult Function( RefreshTvTr value)  refreshTvTr,}){
final _that = this;
switch (_that) {
case FetchInitialTopRatedTv():
return fetchInitialTopRatedTv(_that);case FetchMoreTopRatedTv():
return fetchMoreTopRatedTv(_that);case RefreshTvTr():
return refreshTvTr(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchInitialTopRatedTv value)?  fetchInitialTopRatedTv,TResult? Function( FetchMoreTopRatedTv value)?  fetchMoreTopRatedTv,TResult? Function( RefreshTvTr value)?  refreshTvTr,}){
final _that = this;
switch (_that) {
case FetchInitialTopRatedTv() when fetchInitialTopRatedTv != null:
return fetchInitialTopRatedTv(_that);case FetchMoreTopRatedTv() when fetchMoreTopRatedTv != null:
return fetchMoreTopRatedTv(_that);case RefreshTvTr() when refreshTvTr != null:
return refreshTvTr(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchInitialTopRatedTv,TResult Function()?  fetchMoreTopRatedTv,TResult Function()?  refreshTvTr,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchInitialTopRatedTv() when fetchInitialTopRatedTv != null:
return fetchInitialTopRatedTv();case FetchMoreTopRatedTv() when fetchMoreTopRatedTv != null:
return fetchMoreTopRatedTv();case RefreshTvTr() when refreshTvTr != null:
return refreshTvTr();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchInitialTopRatedTv,required TResult Function()  fetchMoreTopRatedTv,required TResult Function()  refreshTvTr,}) {final _that = this;
switch (_that) {
case FetchInitialTopRatedTv():
return fetchInitialTopRatedTv();case FetchMoreTopRatedTv():
return fetchMoreTopRatedTv();case RefreshTvTr():
return refreshTvTr();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchInitialTopRatedTv,TResult? Function()?  fetchMoreTopRatedTv,TResult? Function()?  refreshTvTr,}) {final _that = this;
switch (_that) {
case FetchInitialTopRatedTv() when fetchInitialTopRatedTv != null:
return fetchInitialTopRatedTv();case FetchMoreTopRatedTv() when fetchMoreTopRatedTv != null:
return fetchMoreTopRatedTv();case RefreshTvTr() when refreshTvTr != null:
return refreshTvTr();case _:
  return null;

}
}

}

/// @nodoc


class FetchInitialTopRatedTv implements TopRatedTvEvent {
  const FetchInitialTopRatedTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTopRatedTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent.fetchInitialTopRatedTv()';
}


}




/// @nodoc


class FetchMoreTopRatedTv implements TopRatedTvEvent {
  const FetchMoreTopRatedTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreTopRatedTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent.fetchMoreTopRatedTv()';
}


}




/// @nodoc


class RefreshTvTr implements TopRatedTvEvent {
  const RefreshTvTr();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTvTr);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvEvent.refreshTvTr()';
}


}




/// @nodoc
mixin _$TopRatedTvState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopRatedTvState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvState()';
}


}

/// @nodoc
class $TopRatedTvStateCopyWith<$Res>  {
$TopRatedTvStateCopyWith(TopRatedTvState _, $Res Function(TopRatedTvState) __);
}


/// Adds pattern-matching-related methods to [TopRatedTvState].
extension TopRatedTvStatePatterns on TopRatedTvState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialTrTv value)?  initialTrTv,TResult Function( LoadingTrTv value)?  loadingTrTv,TResult Function( LoadedTrTv value)?  loadedTrTv,TResult Function( ErrorTrTv value)?  errorTrTv,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialTrTv() when initialTrTv != null:
return initialTrTv(_that);case LoadingTrTv() when loadingTrTv != null:
return loadingTrTv(_that);case LoadedTrTv() when loadedTrTv != null:
return loadedTrTv(_that);case ErrorTrTv() when errorTrTv != null:
return errorTrTv(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialTrTv value)  initialTrTv,required TResult Function( LoadingTrTv value)  loadingTrTv,required TResult Function( LoadedTrTv value)  loadedTrTv,required TResult Function( ErrorTrTv value)  errorTrTv,}){
final _that = this;
switch (_that) {
case InitialTrTv():
return initialTrTv(_that);case LoadingTrTv():
return loadingTrTv(_that);case LoadedTrTv():
return loadedTrTv(_that);case ErrorTrTv():
return errorTrTv(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialTrTv value)?  initialTrTv,TResult? Function( LoadingTrTv value)?  loadingTrTv,TResult? Function( LoadedTrTv value)?  loadedTrTv,TResult? Function( ErrorTrTv value)?  errorTrTv,}){
final _that = this;
switch (_that) {
case InitialTrTv() when initialTrTv != null:
return initialTrTv(_that);case LoadingTrTv() when loadingTrTv != null:
return loadingTrTv(_that);case LoadedTrTv() when loadedTrTv != null:
return loadedTrTv(_that);case ErrorTrTv() when errorTrTv != null:
return errorTrTv(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialTrTv,TResult Function()?  loadingTrTv,TResult Function( List<TvSeries> topRated,  int topRatedPage,  bool hasMoreTopRated,  String? minorError)?  loadedTrTv,TResult Function( String message)?  errorTrTv,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialTrTv() when initialTrTv != null:
return initialTrTv();case LoadingTrTv() when loadingTrTv != null:
return loadingTrTv();case LoadedTrTv() when loadedTrTv != null:
return loadedTrTv(_that.topRated,_that.topRatedPage,_that.hasMoreTopRated,_that.minorError);case ErrorTrTv() when errorTrTv != null:
return errorTrTv(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialTrTv,required TResult Function()  loadingTrTv,required TResult Function( List<TvSeries> topRated,  int topRatedPage,  bool hasMoreTopRated,  String? minorError)  loadedTrTv,required TResult Function( String message)  errorTrTv,}) {final _that = this;
switch (_that) {
case InitialTrTv():
return initialTrTv();case LoadingTrTv():
return loadingTrTv();case LoadedTrTv():
return loadedTrTv(_that.topRated,_that.topRatedPage,_that.hasMoreTopRated,_that.minorError);case ErrorTrTv():
return errorTrTv(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialTrTv,TResult? Function()?  loadingTrTv,TResult? Function( List<TvSeries> topRated,  int topRatedPage,  bool hasMoreTopRated,  String? minorError)?  loadedTrTv,TResult? Function( String message)?  errorTrTv,}) {final _that = this;
switch (_that) {
case InitialTrTv() when initialTrTv != null:
return initialTrTv();case LoadingTrTv() when loadingTrTv != null:
return loadingTrTv();case LoadedTrTv() when loadedTrTv != null:
return loadedTrTv(_that.topRated,_that.topRatedPage,_that.hasMoreTopRated,_that.minorError);case ErrorTrTv() when errorTrTv != null:
return errorTrTv(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InitialTrTv implements TopRatedTvState {
  const InitialTrTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTrTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvState.initialTrTv()';
}


}




/// @nodoc


class LoadingTrTv implements TopRatedTvState {
  const LoadingTrTv();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTrTv);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TopRatedTvState.loadingTrTv()';
}


}




/// @nodoc


class LoadedTrTv implements TopRatedTvState {
  const LoadedTrTv({required final  List<TvSeries> topRated, required this.topRatedPage, required this.hasMoreTopRated, this.minorError}): _topRated = topRated;
  

// Data lists
 final  List<TvSeries> _topRated;
// Data lists
 List<TvSeries> get topRated {
  if (_topRated is EqualUnmodifiableListView) return _topRated;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topRated);
}

// Pagination pages
 final  int topRatedPage;
// Pagination flags
 final  bool hasMoreTopRated;
// Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
 final  String? minorError;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedTrTvCopyWith<LoadedTrTv> get copyWith => _$LoadedTrTvCopyWithImpl<LoadedTrTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedTrTv&&const DeepCollectionEquality().equals(other._topRated, _topRated)&&(identical(other.topRatedPage, topRatedPage) || other.topRatedPage == topRatedPage)&&(identical(other.hasMoreTopRated, hasMoreTopRated) || other.hasMoreTopRated == hasMoreTopRated)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topRated),topRatedPage,hasMoreTopRated,minorError);

@override
String toString() {
  return 'TopRatedTvState.loadedTrTv(topRated: $topRated, topRatedPage: $topRatedPage, hasMoreTopRated: $hasMoreTopRated, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedTrTvCopyWith<$Res> implements $TopRatedTvStateCopyWith<$Res> {
  factory $LoadedTrTvCopyWith(LoadedTrTv value, $Res Function(LoadedTrTv) _then) = _$LoadedTrTvCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> topRated, int topRatedPage, bool hasMoreTopRated, String? minorError
});




}
/// @nodoc
class _$LoadedTrTvCopyWithImpl<$Res>
    implements $LoadedTrTvCopyWith<$Res> {
  _$LoadedTrTvCopyWithImpl(this._self, this._then);

  final LoadedTrTv _self;
  final $Res Function(LoadedTrTv) _then;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topRated = null,Object? topRatedPage = null,Object? hasMoreTopRated = null,Object? minorError = freezed,}) {
  return _then(LoadedTrTv(
topRated: null == topRated ? _self._topRated : topRated // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,topRatedPage: null == topRatedPage ? _self.topRatedPage : topRatedPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreTopRated: null == hasMoreTopRated ? _self.hasMoreTopRated : hasMoreTopRated // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorTrTv implements TopRatedTvState {
  const ErrorTrTv(this.message);
  

 final  String message;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorTrTvCopyWith<ErrorTrTv> get copyWith => _$ErrorTrTvCopyWithImpl<ErrorTrTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorTrTv&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TopRatedTvState.errorTrTv(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorTrTvCopyWith<$Res> implements $TopRatedTvStateCopyWith<$Res> {
  factory $ErrorTrTvCopyWith(ErrorTrTv value, $Res Function(ErrorTrTv) _then) = _$ErrorTrTvCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorTrTvCopyWithImpl<$Res>
    implements $ErrorTrTvCopyWith<$Res> {
  _$ErrorTrTvCopyWithImpl(this._self, this._then);

  final ErrorTrTv _self;
  final $Res Function(ErrorTrTv) _then;

/// Create a copy of TopRatedTvState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorTrTv(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
