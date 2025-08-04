// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'see_more_top_rated_movie_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeeMoreTopRatedMovieEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreTopRatedMovieEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieEvent()';
}


}

/// @nodoc
class $SeeMoreTopRatedMovieEventCopyWith<$Res>  {
$SeeMoreTopRatedMovieEventCopyWith(SeeMoreTopRatedMovieEvent _, $Res Function(SeeMoreTopRatedMovieEvent) __);
}


/// Adds pattern-matching-related methods to [SeeMoreTopRatedMovieEvent].
extension SeeMoreTopRatedMovieEventPatterns on SeeMoreTopRatedMovieEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchInitialTopRatedMovies value)?  fetchInitialTopRatedMovies,TResult Function( FetchMoreTopRatedSeeMoreMovies value)?  fetchMoreTopRatedSeeMoreMovies,TResult Function( RefreshTopRatedMovies value)?  refreshTopRatedMovies,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchInitialTopRatedMovies() when fetchInitialTopRatedMovies != null:
return fetchInitialTopRatedMovies(_that);case FetchMoreTopRatedSeeMoreMovies() when fetchMoreTopRatedSeeMoreMovies != null:
return fetchMoreTopRatedSeeMoreMovies(_that);case RefreshTopRatedMovies() when refreshTopRatedMovies != null:
return refreshTopRatedMovies(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchInitialTopRatedMovies value)  fetchInitialTopRatedMovies,required TResult Function( FetchMoreTopRatedSeeMoreMovies value)  fetchMoreTopRatedSeeMoreMovies,required TResult Function( RefreshTopRatedMovies value)  refreshTopRatedMovies,}){
final _that = this;
switch (_that) {
case FetchInitialTopRatedMovies():
return fetchInitialTopRatedMovies(_that);case FetchMoreTopRatedSeeMoreMovies():
return fetchMoreTopRatedSeeMoreMovies(_that);case RefreshTopRatedMovies():
return refreshTopRatedMovies(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchInitialTopRatedMovies value)?  fetchInitialTopRatedMovies,TResult? Function( FetchMoreTopRatedSeeMoreMovies value)?  fetchMoreTopRatedSeeMoreMovies,TResult? Function( RefreshTopRatedMovies value)?  refreshTopRatedMovies,}){
final _that = this;
switch (_that) {
case FetchInitialTopRatedMovies() when fetchInitialTopRatedMovies != null:
return fetchInitialTopRatedMovies(_that);case FetchMoreTopRatedSeeMoreMovies() when fetchMoreTopRatedSeeMoreMovies != null:
return fetchMoreTopRatedSeeMoreMovies(_that);case RefreshTopRatedMovies() when refreshTopRatedMovies != null:
return refreshTopRatedMovies(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchInitialTopRatedMovies,TResult Function()?  fetchMoreTopRatedSeeMoreMovies,TResult Function()?  refreshTopRatedMovies,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchInitialTopRatedMovies() when fetchInitialTopRatedMovies != null:
return fetchInitialTopRatedMovies();case FetchMoreTopRatedSeeMoreMovies() when fetchMoreTopRatedSeeMoreMovies != null:
return fetchMoreTopRatedSeeMoreMovies();case RefreshTopRatedMovies() when refreshTopRatedMovies != null:
return refreshTopRatedMovies();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchInitialTopRatedMovies,required TResult Function()  fetchMoreTopRatedSeeMoreMovies,required TResult Function()  refreshTopRatedMovies,}) {final _that = this;
switch (_that) {
case FetchInitialTopRatedMovies():
return fetchInitialTopRatedMovies();case FetchMoreTopRatedSeeMoreMovies():
return fetchMoreTopRatedSeeMoreMovies();case RefreshTopRatedMovies():
return refreshTopRatedMovies();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchInitialTopRatedMovies,TResult? Function()?  fetchMoreTopRatedSeeMoreMovies,TResult? Function()?  refreshTopRatedMovies,}) {final _that = this;
switch (_that) {
case FetchInitialTopRatedMovies() when fetchInitialTopRatedMovies != null:
return fetchInitialTopRatedMovies();case FetchMoreTopRatedSeeMoreMovies() when fetchMoreTopRatedSeeMoreMovies != null:
return fetchMoreTopRatedSeeMoreMovies();case RefreshTopRatedMovies() when refreshTopRatedMovies != null:
return refreshTopRatedMovies();case _:
  return null;

}
}

}

/// @nodoc


class FetchInitialTopRatedMovies implements SeeMoreTopRatedMovieEvent {
  const FetchInitialTopRatedMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialTopRatedMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies()';
}


}




/// @nodoc


class FetchMoreTopRatedSeeMoreMovies implements SeeMoreTopRatedMovieEvent {
  const FetchMoreTopRatedSeeMoreMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMoreTopRatedSeeMoreMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieEvent.fetchMoreTopRatedSeeMoreMovies()';
}


}




/// @nodoc


class RefreshTopRatedMovies implements SeeMoreTopRatedMovieEvent {
  const RefreshTopRatedMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTopRatedMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieEvent.refreshTopRatedMovies()';
}


}




/// @nodoc
mixin _$SeeMoreTopRatedMovieState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMoreTopRatedMovieState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieState()';
}


}

/// @nodoc
class $SeeMoreTopRatedMovieStateCopyWith<$Res>  {
$SeeMoreTopRatedMovieStateCopyWith(SeeMoreTopRatedMovieState _, $Res Function(SeeMoreTopRatedMovieState) __);
}


/// Adds pattern-matching-related methods to [SeeMoreTopRatedMovieState].
extension SeeMoreTopRatedMovieStatePatterns on SeeMoreTopRatedMovieState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialTopRatedMSeeMore value)?  initialTopRatedMSeeMore,TResult Function( LoadingTopRatedMSeeMore value)?  loadingTopRatedMSeeMore,TResult Function( LoadedTopRatedMSeeMore value)?  loadedTopRatedMSeeMore,TResult Function( ErrorTopRatedMSeeMore value)?  errorTopRatedMSeeMore,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialTopRatedMSeeMore() when initialTopRatedMSeeMore != null:
return initialTopRatedMSeeMore(_that);case LoadingTopRatedMSeeMore() when loadingTopRatedMSeeMore != null:
return loadingTopRatedMSeeMore(_that);case LoadedTopRatedMSeeMore() when loadedTopRatedMSeeMore != null:
return loadedTopRatedMSeeMore(_that);case ErrorTopRatedMSeeMore() when errorTopRatedMSeeMore != null:
return errorTopRatedMSeeMore(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialTopRatedMSeeMore value)  initialTopRatedMSeeMore,required TResult Function( LoadingTopRatedMSeeMore value)  loadingTopRatedMSeeMore,required TResult Function( LoadedTopRatedMSeeMore value)  loadedTopRatedMSeeMore,required TResult Function( ErrorTopRatedMSeeMore value)  errorTopRatedMSeeMore,}){
final _that = this;
switch (_that) {
case InitialTopRatedMSeeMore():
return initialTopRatedMSeeMore(_that);case LoadingTopRatedMSeeMore():
return loadingTopRatedMSeeMore(_that);case LoadedTopRatedMSeeMore():
return loadedTopRatedMSeeMore(_that);case ErrorTopRatedMSeeMore():
return errorTopRatedMSeeMore(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialTopRatedMSeeMore value)?  initialTopRatedMSeeMore,TResult? Function( LoadingTopRatedMSeeMore value)?  loadingTopRatedMSeeMore,TResult? Function( LoadedTopRatedMSeeMore value)?  loadedTopRatedMSeeMore,TResult? Function( ErrorTopRatedMSeeMore value)?  errorTopRatedMSeeMore,}){
final _that = this;
switch (_that) {
case InitialTopRatedMSeeMore() when initialTopRatedMSeeMore != null:
return initialTopRatedMSeeMore(_that);case LoadingTopRatedMSeeMore() when loadingTopRatedMSeeMore != null:
return loadingTopRatedMSeeMore(_that);case LoadedTopRatedMSeeMore() when loadedTopRatedMSeeMore != null:
return loadedTopRatedMSeeMore(_that);case ErrorTopRatedMSeeMore() when errorTopRatedMSeeMore != null:
return errorTopRatedMSeeMore(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialTopRatedMSeeMore,TResult Function()?  loadingTopRatedMSeeMore,TResult Function( List<Movie> topRated,  int topRatedPage,  bool hasMoreTopRated,  String? minorError)?  loadedTopRatedMSeeMore,TResult Function( String message)?  errorTopRatedMSeeMore,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialTopRatedMSeeMore() when initialTopRatedMSeeMore != null:
return initialTopRatedMSeeMore();case LoadingTopRatedMSeeMore() when loadingTopRatedMSeeMore != null:
return loadingTopRatedMSeeMore();case LoadedTopRatedMSeeMore() when loadedTopRatedMSeeMore != null:
return loadedTopRatedMSeeMore(_that.topRated,_that.topRatedPage,_that.hasMoreTopRated,_that.minorError);case ErrorTopRatedMSeeMore() when errorTopRatedMSeeMore != null:
return errorTopRatedMSeeMore(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialTopRatedMSeeMore,required TResult Function()  loadingTopRatedMSeeMore,required TResult Function( List<Movie> topRated,  int topRatedPage,  bool hasMoreTopRated,  String? minorError)  loadedTopRatedMSeeMore,required TResult Function( String message)  errorTopRatedMSeeMore,}) {final _that = this;
switch (_that) {
case InitialTopRatedMSeeMore():
return initialTopRatedMSeeMore();case LoadingTopRatedMSeeMore():
return loadingTopRatedMSeeMore();case LoadedTopRatedMSeeMore():
return loadedTopRatedMSeeMore(_that.topRated,_that.topRatedPage,_that.hasMoreTopRated,_that.minorError);case ErrorTopRatedMSeeMore():
return errorTopRatedMSeeMore(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialTopRatedMSeeMore,TResult? Function()?  loadingTopRatedMSeeMore,TResult? Function( List<Movie> topRated,  int topRatedPage,  bool hasMoreTopRated,  String? minorError)?  loadedTopRatedMSeeMore,TResult? Function( String message)?  errorTopRatedMSeeMore,}) {final _that = this;
switch (_that) {
case InitialTopRatedMSeeMore() when initialTopRatedMSeeMore != null:
return initialTopRatedMSeeMore();case LoadingTopRatedMSeeMore() when loadingTopRatedMSeeMore != null:
return loadingTopRatedMSeeMore();case LoadedTopRatedMSeeMore() when loadedTopRatedMSeeMore != null:
return loadedTopRatedMSeeMore(_that.topRated,_that.topRatedPage,_that.hasMoreTopRated,_that.minorError);case ErrorTopRatedMSeeMore() when errorTopRatedMSeeMore != null:
return errorTopRatedMSeeMore(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InitialTopRatedMSeeMore implements SeeMoreTopRatedMovieState {
  const InitialTopRatedMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTopRatedMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieState.initialTopRatedMSeeMore()';
}


}




/// @nodoc


class LoadingTopRatedMSeeMore implements SeeMoreTopRatedMovieState {
  const LoadingTopRatedMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTopRatedMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMoreTopRatedMovieState.loadingTopRatedMSeeMore()';
}


}




/// @nodoc


class LoadedTopRatedMSeeMore implements SeeMoreTopRatedMovieState {
  const LoadedTopRatedMSeeMore({required final  List<Movie> topRated, required this.topRatedPage, required this.hasMoreTopRated, this.minorError}): _topRated = topRated;
  

// Data List
 final  List<Movie> _topRated;
// Data List
 List<Movie> get topRated {
  if (_topRated is EqualUnmodifiableListView) return _topRated;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topRated);
}

// Pagination Pages
 final  int topRatedPage;
// Pagination Flags
 final  bool hasMoreTopRated;
 final  String? minorError;

/// Create a copy of SeeMoreTopRatedMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedTopRatedMSeeMoreCopyWith<LoadedTopRatedMSeeMore> get copyWith => _$LoadedTopRatedMSeeMoreCopyWithImpl<LoadedTopRatedMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedTopRatedMSeeMore&&const DeepCollectionEquality().equals(other._topRated, _topRated)&&(identical(other.topRatedPage, topRatedPage) || other.topRatedPage == topRatedPage)&&(identical(other.hasMoreTopRated, hasMoreTopRated) || other.hasMoreTopRated == hasMoreTopRated)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topRated),topRatedPage,hasMoreTopRated,minorError);

@override
String toString() {
  return 'SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore(topRated: $topRated, topRatedPage: $topRatedPage, hasMoreTopRated: $hasMoreTopRated, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedTopRatedMSeeMoreCopyWith<$Res> implements $SeeMoreTopRatedMovieStateCopyWith<$Res> {
  factory $LoadedTopRatedMSeeMoreCopyWith(LoadedTopRatedMSeeMore value, $Res Function(LoadedTopRatedMSeeMore) _then) = _$LoadedTopRatedMSeeMoreCopyWithImpl;
@useResult
$Res call({
 List<Movie> topRated, int topRatedPage, bool hasMoreTopRated, String? minorError
});




}
/// @nodoc
class _$LoadedTopRatedMSeeMoreCopyWithImpl<$Res>
    implements $LoadedTopRatedMSeeMoreCopyWith<$Res> {
  _$LoadedTopRatedMSeeMoreCopyWithImpl(this._self, this._then);

  final LoadedTopRatedMSeeMore _self;
  final $Res Function(LoadedTopRatedMSeeMore) _then;

/// Create a copy of SeeMoreTopRatedMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topRated = null,Object? topRatedPage = null,Object? hasMoreTopRated = null,Object? minorError = freezed,}) {
  return _then(LoadedTopRatedMSeeMore(
topRated: null == topRated ? _self._topRated : topRated // ignore: cast_nullable_to_non_nullable
as List<Movie>,topRatedPage: null == topRatedPage ? _self.topRatedPage : topRatedPage // ignore: cast_nullable_to_non_nullable
as int,hasMoreTopRated: null == hasMoreTopRated ? _self.hasMoreTopRated : hasMoreTopRated // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorTopRatedMSeeMore implements SeeMoreTopRatedMovieState {
  const ErrorTopRatedMSeeMore(this.message);
  

 final  String message;

/// Create a copy of SeeMoreTopRatedMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorTopRatedMSeeMoreCopyWith<ErrorTopRatedMSeeMore> get copyWith => _$ErrorTopRatedMSeeMoreCopyWithImpl<ErrorTopRatedMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorTopRatedMSeeMore&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeeMoreTopRatedMovieState.errorTopRatedMSeeMore(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorTopRatedMSeeMoreCopyWith<$Res> implements $SeeMoreTopRatedMovieStateCopyWith<$Res> {
  factory $ErrorTopRatedMSeeMoreCopyWith(ErrorTopRatedMSeeMore value, $Res Function(ErrorTopRatedMSeeMore) _then) = _$ErrorTopRatedMSeeMoreCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorTopRatedMSeeMoreCopyWithImpl<$Res>
    implements $ErrorTopRatedMSeeMoreCopyWith<$Res> {
  _$ErrorTopRatedMSeeMoreCopyWithImpl(this._self, this._then);

  final ErrorTopRatedMSeeMore _self;
  final $Res Function(ErrorTopRatedMSeeMore) _then;

/// Create a copy of SeeMoreTopRatedMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorTopRatedMSeeMore(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
