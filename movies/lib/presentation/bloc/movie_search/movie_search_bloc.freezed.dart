// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieSearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieSearchEvent()';
}


}

/// @nodoc
class $MovieSearchEventCopyWith<$Res>  {
$MovieSearchEventCopyWith(MovieSearchEvent _, $Res Function(MovieSearchEvent) __);
}


/// Adds pattern-matching-related methods to [MovieSearchEvent].
extension MovieSearchEventPatterns on MovieSearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( OnQueryChanged value)?  onQueryChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case OnQueryChanged() when onQueryChanged != null:
return onQueryChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( OnQueryChanged value)  onQueryChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case OnQueryChanged():
return onQueryChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( OnQueryChanged value)?  onQueryChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case OnQueryChanged() when onQueryChanged != null:
return onQueryChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String query)?  onQueryChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case OnQueryChanged() when onQueryChanged != null:
return onQueryChanged(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String query)  onQueryChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case OnQueryChanged():
return onQueryChanged(_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String query)?  onQueryChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case OnQueryChanged() when onQueryChanged != null:
return onQueryChanged(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements MovieSearchEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieSearchEvent.started()';
}


}




/// @nodoc


class OnQueryChanged implements MovieSearchEvent {
  const OnQueryChanged(this.query);
  

 final  String query;

/// Create a copy of MovieSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnQueryChangedCopyWith<OnQueryChanged> get copyWith => _$OnQueryChangedCopyWithImpl<OnQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'MovieSearchEvent.onQueryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $OnQueryChangedCopyWith<$Res> implements $MovieSearchEventCopyWith<$Res> {
  factory $OnQueryChangedCopyWith(OnQueryChanged value, $Res Function(OnQueryChanged) _then) = _$OnQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$OnQueryChangedCopyWithImpl<$Res>
    implements $OnQueryChangedCopyWith<$Res> {
  _$OnQueryChangedCopyWithImpl(this._self, this._then);

  final OnQueryChanged _self;
  final $Res Function(OnQueryChanged) _then;

/// Create a copy of MovieSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(OnQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MovieSearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieSearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieSearchState()';
}


}

/// @nodoc
class $MovieSearchStateCopyWith<$Res>  {
$MovieSearchStateCopyWith(MovieSearchState _, $Res Function(MovieSearchState) __);
}


/// Adds pattern-matching-related methods to [MovieSearchState].
extension MovieSearchStatePatterns on MovieSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MovieSearchEmpty value)?  movieSearchEmpty,TResult Function( MovieSearchLoading value)?  movieSearchLoading,TResult Function( MovieSearchError value)?  movieSearchError,TResult Function( MovieSearchHasData value)?  movieSearchHasData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MovieSearchEmpty() when movieSearchEmpty != null:
return movieSearchEmpty(_that);case MovieSearchLoading() when movieSearchLoading != null:
return movieSearchLoading(_that);case MovieSearchError() when movieSearchError != null:
return movieSearchError(_that);case MovieSearchHasData() when movieSearchHasData != null:
return movieSearchHasData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MovieSearchEmpty value)  movieSearchEmpty,required TResult Function( MovieSearchLoading value)  movieSearchLoading,required TResult Function( MovieSearchError value)  movieSearchError,required TResult Function( MovieSearchHasData value)  movieSearchHasData,}){
final _that = this;
switch (_that) {
case MovieSearchEmpty():
return movieSearchEmpty(_that);case MovieSearchLoading():
return movieSearchLoading(_that);case MovieSearchError():
return movieSearchError(_that);case MovieSearchHasData():
return movieSearchHasData(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MovieSearchEmpty value)?  movieSearchEmpty,TResult? Function( MovieSearchLoading value)?  movieSearchLoading,TResult? Function( MovieSearchError value)?  movieSearchError,TResult? Function( MovieSearchHasData value)?  movieSearchHasData,}){
final _that = this;
switch (_that) {
case MovieSearchEmpty() when movieSearchEmpty != null:
return movieSearchEmpty(_that);case MovieSearchLoading() when movieSearchLoading != null:
return movieSearchLoading(_that);case MovieSearchError() when movieSearchError != null:
return movieSearchError(_that);case MovieSearchHasData() when movieSearchHasData != null:
return movieSearchHasData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  movieSearchEmpty,TResult Function()?  movieSearchLoading,TResult Function( String message)?  movieSearchError,TResult Function( List<Movie> result)?  movieSearchHasData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MovieSearchEmpty() when movieSearchEmpty != null:
return movieSearchEmpty();case MovieSearchLoading() when movieSearchLoading != null:
return movieSearchLoading();case MovieSearchError() when movieSearchError != null:
return movieSearchError(_that.message);case MovieSearchHasData() when movieSearchHasData != null:
return movieSearchHasData(_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  movieSearchEmpty,required TResult Function()  movieSearchLoading,required TResult Function( String message)  movieSearchError,required TResult Function( List<Movie> result)  movieSearchHasData,}) {final _that = this;
switch (_that) {
case MovieSearchEmpty():
return movieSearchEmpty();case MovieSearchLoading():
return movieSearchLoading();case MovieSearchError():
return movieSearchError(_that.message);case MovieSearchHasData():
return movieSearchHasData(_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  movieSearchEmpty,TResult? Function()?  movieSearchLoading,TResult? Function( String message)?  movieSearchError,TResult? Function( List<Movie> result)?  movieSearchHasData,}) {final _that = this;
switch (_that) {
case MovieSearchEmpty() when movieSearchEmpty != null:
return movieSearchEmpty();case MovieSearchLoading() when movieSearchLoading != null:
return movieSearchLoading();case MovieSearchError() when movieSearchError != null:
return movieSearchError(_that.message);case MovieSearchHasData() when movieSearchHasData != null:
return movieSearchHasData(_that.result);case _:
  return null;

}
}

}

/// @nodoc


class MovieSearchEmpty implements MovieSearchState {
  const MovieSearchEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieSearchEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieSearchState.movieSearchEmpty()';
}


}




/// @nodoc


class MovieSearchLoading implements MovieSearchState {
  const MovieSearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieSearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieSearchState.movieSearchLoading()';
}


}




/// @nodoc


class MovieSearchError implements MovieSearchState {
  const MovieSearchError(this.message);
  

 final  String message;

/// Create a copy of MovieSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieSearchErrorCopyWith<MovieSearchError> get copyWith => _$MovieSearchErrorCopyWithImpl<MovieSearchError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieSearchError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MovieSearchState.movieSearchError(message: $message)';
}


}

/// @nodoc
abstract mixin class $MovieSearchErrorCopyWith<$Res> implements $MovieSearchStateCopyWith<$Res> {
  factory $MovieSearchErrorCopyWith(MovieSearchError value, $Res Function(MovieSearchError) _then) = _$MovieSearchErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MovieSearchErrorCopyWithImpl<$Res>
    implements $MovieSearchErrorCopyWith<$Res> {
  _$MovieSearchErrorCopyWithImpl(this._self, this._then);

  final MovieSearchError _self;
  final $Res Function(MovieSearchError) _then;

/// Create a copy of MovieSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MovieSearchError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MovieSearchHasData implements MovieSearchState {
  const MovieSearchHasData(final  List<Movie> result): _result = result;
  

 final  List<Movie> _result;
 List<Movie> get result {
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_result);
}


/// Create a copy of MovieSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovieSearchHasDataCopyWith<MovieSearchHasData> get copyWith => _$MovieSearchHasDataCopyWithImpl<MovieSearchHasData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieSearchHasData&&const DeepCollectionEquality().equals(other._result, _result));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result));

@override
String toString() {
  return 'MovieSearchState.movieSearchHasData(result: $result)';
}


}

/// @nodoc
abstract mixin class $MovieSearchHasDataCopyWith<$Res> implements $MovieSearchStateCopyWith<$Res> {
  factory $MovieSearchHasDataCopyWith(MovieSearchHasData value, $Res Function(MovieSearchHasData) _then) = _$MovieSearchHasDataCopyWithImpl;
@useResult
$Res call({
 List<Movie> result
});




}
/// @nodoc
class _$MovieSearchHasDataCopyWithImpl<$Res>
    implements $MovieSearchHasDataCopyWith<$Res> {
  _$MovieSearchHasDataCopyWithImpl(this._self, this._then);

  final MovieSearchHasData _self;
  final $Res Function(MovieSearchHasData) _then;

/// Create a copy of MovieSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(MovieSearchHasData(
null == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<Movie>,
  ));
}


}

// dart format on
