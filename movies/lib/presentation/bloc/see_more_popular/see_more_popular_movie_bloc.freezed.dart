// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'see_more_popular_movie_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeeMorePopularMovieEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMorePopularMovieEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieEvent()';
}


}

/// @nodoc
class $SeeMorePopularMovieEventCopyWith<$Res>  {
$SeeMorePopularMovieEventCopyWith(SeeMorePopularMovieEvent _, $Res Function(SeeMorePopularMovieEvent) __);
}


/// Adds pattern-matching-related methods to [SeeMorePopularMovieEvent].
extension SeeMorePopularMovieEventPatterns on SeeMorePopularMovieEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchInitialPopularMovies value)?  fetchInitialPopularMovies,TResult Function( FetchMorePopularSeeMoreMovies value)?  fetchMorePopularSeeMoreMovies,TResult Function( RefreshPopularMovies value)?  refreshPopularMovies,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchInitialPopularMovies() when fetchInitialPopularMovies != null:
return fetchInitialPopularMovies(_that);case FetchMorePopularSeeMoreMovies() when fetchMorePopularSeeMoreMovies != null:
return fetchMorePopularSeeMoreMovies(_that);case RefreshPopularMovies() when refreshPopularMovies != null:
return refreshPopularMovies(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchInitialPopularMovies value)  fetchInitialPopularMovies,required TResult Function( FetchMorePopularSeeMoreMovies value)  fetchMorePopularSeeMoreMovies,required TResult Function( RefreshPopularMovies value)  refreshPopularMovies,}){
final _that = this;
switch (_that) {
case FetchInitialPopularMovies():
return fetchInitialPopularMovies(_that);case FetchMorePopularSeeMoreMovies():
return fetchMorePopularSeeMoreMovies(_that);case RefreshPopularMovies():
return refreshPopularMovies(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchInitialPopularMovies value)?  fetchInitialPopularMovies,TResult? Function( FetchMorePopularSeeMoreMovies value)?  fetchMorePopularSeeMoreMovies,TResult? Function( RefreshPopularMovies value)?  refreshPopularMovies,}){
final _that = this;
switch (_that) {
case FetchInitialPopularMovies() when fetchInitialPopularMovies != null:
return fetchInitialPopularMovies(_that);case FetchMorePopularSeeMoreMovies() when fetchMorePopularSeeMoreMovies != null:
return fetchMorePopularSeeMoreMovies(_that);case RefreshPopularMovies() when refreshPopularMovies != null:
return refreshPopularMovies(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchInitialPopularMovies,TResult Function()?  fetchMorePopularSeeMoreMovies,TResult Function()?  refreshPopularMovies,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchInitialPopularMovies() when fetchInitialPopularMovies != null:
return fetchInitialPopularMovies();case FetchMorePopularSeeMoreMovies() when fetchMorePopularSeeMoreMovies != null:
return fetchMorePopularSeeMoreMovies();case RefreshPopularMovies() when refreshPopularMovies != null:
return refreshPopularMovies();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchInitialPopularMovies,required TResult Function()  fetchMorePopularSeeMoreMovies,required TResult Function()  refreshPopularMovies,}) {final _that = this;
switch (_that) {
case FetchInitialPopularMovies():
return fetchInitialPopularMovies();case FetchMorePopularSeeMoreMovies():
return fetchMorePopularSeeMoreMovies();case RefreshPopularMovies():
return refreshPopularMovies();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchInitialPopularMovies,TResult? Function()?  fetchMorePopularSeeMoreMovies,TResult? Function()?  refreshPopularMovies,}) {final _that = this;
switch (_that) {
case FetchInitialPopularMovies() when fetchInitialPopularMovies != null:
return fetchInitialPopularMovies();case FetchMorePopularSeeMoreMovies() when fetchMorePopularSeeMoreMovies != null:
return fetchMorePopularSeeMoreMovies();case RefreshPopularMovies() when refreshPopularMovies != null:
return refreshPopularMovies();case _:
  return null;

}
}

}

/// @nodoc


class FetchInitialPopularMovies implements SeeMorePopularMovieEvent {
  const FetchInitialPopularMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchInitialPopularMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieEvent.fetchInitialPopularMovies()';
}


}




/// @nodoc


class FetchMorePopularSeeMoreMovies implements SeeMorePopularMovieEvent {
  const FetchMorePopularSeeMoreMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMorePopularSeeMoreMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieEvent.fetchMorePopularSeeMoreMovies()';
}


}




/// @nodoc


class RefreshPopularMovies implements SeeMorePopularMovieEvent {
  const RefreshPopularMovies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshPopularMovies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieEvent.refreshPopularMovies()';
}


}




/// @nodoc
mixin _$SeeMorePopularMovieState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeeMorePopularMovieState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieState()';
}


}

/// @nodoc
class $SeeMorePopularMovieStateCopyWith<$Res>  {
$SeeMorePopularMovieStateCopyWith(SeeMorePopularMovieState _, $Res Function(SeeMorePopularMovieState) __);
}


/// Adds pattern-matching-related methods to [SeeMorePopularMovieState].
extension SeeMorePopularMovieStatePatterns on SeeMorePopularMovieState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialPopularMSeeMore value)?  initialPopularMSeeMore,TResult Function( LoadingPopularMSeeMore value)?  loadingPopularMSeeMore,TResult Function( LoadedPopularMSeeMore value)?  loadedPopularMSeeMore,TResult Function( ErrorPopularMSeeMore value)?  errorPopularMSeeMore,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialPopularMSeeMore() when initialPopularMSeeMore != null:
return initialPopularMSeeMore(_that);case LoadingPopularMSeeMore() when loadingPopularMSeeMore != null:
return loadingPopularMSeeMore(_that);case LoadedPopularMSeeMore() when loadedPopularMSeeMore != null:
return loadedPopularMSeeMore(_that);case ErrorPopularMSeeMore() when errorPopularMSeeMore != null:
return errorPopularMSeeMore(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialPopularMSeeMore value)  initialPopularMSeeMore,required TResult Function( LoadingPopularMSeeMore value)  loadingPopularMSeeMore,required TResult Function( LoadedPopularMSeeMore value)  loadedPopularMSeeMore,required TResult Function( ErrorPopularMSeeMore value)  errorPopularMSeeMore,}){
final _that = this;
switch (_that) {
case InitialPopularMSeeMore():
return initialPopularMSeeMore(_that);case LoadingPopularMSeeMore():
return loadingPopularMSeeMore(_that);case LoadedPopularMSeeMore():
return loadedPopularMSeeMore(_that);case ErrorPopularMSeeMore():
return errorPopularMSeeMore(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialPopularMSeeMore value)?  initialPopularMSeeMore,TResult? Function( LoadingPopularMSeeMore value)?  loadingPopularMSeeMore,TResult? Function( LoadedPopularMSeeMore value)?  loadedPopularMSeeMore,TResult? Function( ErrorPopularMSeeMore value)?  errorPopularMSeeMore,}){
final _that = this;
switch (_that) {
case InitialPopularMSeeMore() when initialPopularMSeeMore != null:
return initialPopularMSeeMore(_that);case LoadingPopularMSeeMore() when loadingPopularMSeeMore != null:
return loadingPopularMSeeMore(_that);case LoadedPopularMSeeMore() when loadedPopularMSeeMore != null:
return loadedPopularMSeeMore(_that);case ErrorPopularMSeeMore() when errorPopularMSeeMore != null:
return errorPopularMSeeMore(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialPopularMSeeMore,TResult Function()?  loadingPopularMSeeMore,TResult Function( List<Movie> popular,  int popularPage,  bool hasMorePopular,  String? minorError)?  loadedPopularMSeeMore,TResult Function( String message)?  errorPopularMSeeMore,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialPopularMSeeMore() when initialPopularMSeeMore != null:
return initialPopularMSeeMore();case LoadingPopularMSeeMore() when loadingPopularMSeeMore != null:
return loadingPopularMSeeMore();case LoadedPopularMSeeMore() when loadedPopularMSeeMore != null:
return loadedPopularMSeeMore(_that.popular,_that.popularPage,_that.hasMorePopular,_that.minorError);case ErrorPopularMSeeMore() when errorPopularMSeeMore != null:
return errorPopularMSeeMore(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialPopularMSeeMore,required TResult Function()  loadingPopularMSeeMore,required TResult Function( List<Movie> popular,  int popularPage,  bool hasMorePopular,  String? minorError)  loadedPopularMSeeMore,required TResult Function( String message)  errorPopularMSeeMore,}) {final _that = this;
switch (_that) {
case InitialPopularMSeeMore():
return initialPopularMSeeMore();case LoadingPopularMSeeMore():
return loadingPopularMSeeMore();case LoadedPopularMSeeMore():
return loadedPopularMSeeMore(_that.popular,_that.popularPage,_that.hasMorePopular,_that.minorError);case ErrorPopularMSeeMore():
return errorPopularMSeeMore(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialPopularMSeeMore,TResult? Function()?  loadingPopularMSeeMore,TResult? Function( List<Movie> popular,  int popularPage,  bool hasMorePopular,  String? minorError)?  loadedPopularMSeeMore,TResult? Function( String message)?  errorPopularMSeeMore,}) {final _that = this;
switch (_that) {
case InitialPopularMSeeMore() when initialPopularMSeeMore != null:
return initialPopularMSeeMore();case LoadingPopularMSeeMore() when loadingPopularMSeeMore != null:
return loadingPopularMSeeMore();case LoadedPopularMSeeMore() when loadedPopularMSeeMore != null:
return loadedPopularMSeeMore(_that.popular,_that.popularPage,_that.hasMorePopular,_that.minorError);case ErrorPopularMSeeMore() when errorPopularMSeeMore != null:
return errorPopularMSeeMore(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InitialPopularMSeeMore implements SeeMorePopularMovieState {
  const InitialPopularMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialPopularMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieState.initialPopularMSeeMore()';
}


}




/// @nodoc


class LoadingPopularMSeeMore implements SeeMorePopularMovieState {
  const LoadingPopularMSeeMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingPopularMSeeMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeeMorePopularMovieState.loadingPopularMSeeMore()';
}


}




/// @nodoc


class LoadedPopularMSeeMore implements SeeMorePopularMovieState {
  const LoadedPopularMSeeMore({required final  List<Movie> popular, required this.popularPage, required this.hasMorePopular, this.minorError}): _popular = popular;
  

// Data List
 final  List<Movie> _popular;
// Data List
 List<Movie> get popular {
  if (_popular is EqualUnmodifiableListView) return _popular;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popular);
}

// Pagination Pages
 final  int popularPage;
// Pagination Flags
 final  bool hasMorePopular;
 final  String? minorError;

/// Create a copy of SeeMorePopularMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedPopularMSeeMoreCopyWith<LoadedPopularMSeeMore> get copyWith => _$LoadedPopularMSeeMoreCopyWithImpl<LoadedPopularMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedPopularMSeeMore&&const DeepCollectionEquality().equals(other._popular, _popular)&&(identical(other.popularPage, popularPage) || other.popularPage == popularPage)&&(identical(other.hasMorePopular, hasMorePopular) || other.hasMorePopular == hasMorePopular)&&(identical(other.minorError, minorError) || other.minorError == minorError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popular),popularPage,hasMorePopular,minorError);

@override
String toString() {
  return 'SeeMorePopularMovieState.loadedPopularMSeeMore(popular: $popular, popularPage: $popularPage, hasMorePopular: $hasMorePopular, minorError: $minorError)';
}


}

/// @nodoc
abstract mixin class $LoadedPopularMSeeMoreCopyWith<$Res> implements $SeeMorePopularMovieStateCopyWith<$Res> {
  factory $LoadedPopularMSeeMoreCopyWith(LoadedPopularMSeeMore value, $Res Function(LoadedPopularMSeeMore) _then) = _$LoadedPopularMSeeMoreCopyWithImpl;
@useResult
$Res call({
 List<Movie> popular, int popularPage, bool hasMorePopular, String? minorError
});




}
/// @nodoc
class _$LoadedPopularMSeeMoreCopyWithImpl<$Res>
    implements $LoadedPopularMSeeMoreCopyWith<$Res> {
  _$LoadedPopularMSeeMoreCopyWithImpl(this._self, this._then);

  final LoadedPopularMSeeMore _self;
  final $Res Function(LoadedPopularMSeeMore) _then;

/// Create a copy of SeeMorePopularMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? popular = null,Object? popularPage = null,Object? hasMorePopular = null,Object? minorError = freezed,}) {
  return _then(LoadedPopularMSeeMore(
popular: null == popular ? _self._popular : popular // ignore: cast_nullable_to_non_nullable
as List<Movie>,popularPage: null == popularPage ? _self.popularPage : popularPage // ignore: cast_nullable_to_non_nullable
as int,hasMorePopular: null == hasMorePopular ? _self.hasMorePopular : hasMorePopular // ignore: cast_nullable_to_non_nullable
as bool,minorError: freezed == minorError ? _self.minorError : minorError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ErrorPopularMSeeMore implements SeeMorePopularMovieState {
  const ErrorPopularMSeeMore(this.message);
  

 final  String message;

/// Create a copy of SeeMorePopularMovieState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorPopularMSeeMoreCopyWith<ErrorPopularMSeeMore> get copyWith => _$ErrorPopularMSeeMoreCopyWithImpl<ErrorPopularMSeeMore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorPopularMSeeMore&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SeeMorePopularMovieState.errorPopularMSeeMore(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorPopularMSeeMoreCopyWith<$Res> implements $SeeMorePopularMovieStateCopyWith<$Res> {
  factory $ErrorPopularMSeeMoreCopyWith(ErrorPopularMSeeMore value, $Res Function(ErrorPopularMSeeMore) _then) = _$ErrorPopularMSeeMoreCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorPopularMSeeMoreCopyWithImpl<$Res>
    implements $ErrorPopularMSeeMoreCopyWith<$Res> {
  _$ErrorPopularMSeeMoreCopyWithImpl(this._self, this._then);

  final ErrorPopularMSeeMore _self;
  final $Res Function(ErrorPopularMSeeMore) _then;

/// Create a copy of SeeMorePopularMovieState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorPopularMSeeMore(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
