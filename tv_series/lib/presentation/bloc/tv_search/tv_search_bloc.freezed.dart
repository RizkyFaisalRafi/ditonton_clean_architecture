// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tv_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TvSearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvSearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvSearchEvent()';
}


}

/// @nodoc
class $TvSearchEventCopyWith<$Res>  {
$TvSearchEventCopyWith(TvSearchEvent _, $Res Function(TvSearchEvent) __);
}


/// Adds pattern-matching-related methods to [TvSearchEvent].
extension TvSearchEventPatterns on TvSearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( OnQueryChangedTv value)?  onQueryChangedTv,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case OnQueryChangedTv() when onQueryChangedTv != null:
return onQueryChangedTv(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( OnQueryChangedTv value)  onQueryChangedTv,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case OnQueryChangedTv():
return onQueryChangedTv(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( OnQueryChangedTv value)?  onQueryChangedTv,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case OnQueryChangedTv() when onQueryChangedTv != null:
return onQueryChangedTv(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String query)?  onQueryChangedTv,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case OnQueryChangedTv() when onQueryChangedTv != null:
return onQueryChangedTv(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String query)  onQueryChangedTv,}) {final _that = this;
switch (_that) {
case _Started():
return started();case OnQueryChangedTv():
return onQueryChangedTv(_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String query)?  onQueryChangedTv,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case OnQueryChangedTv() when onQueryChangedTv != null:
return onQueryChangedTv(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements TvSearchEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvSearchEvent.started()';
}


}




/// @nodoc


class OnQueryChangedTv implements TvSearchEvent {
  const OnQueryChangedTv(this.query);
  

 final  String query;

/// Create a copy of TvSearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnQueryChangedTvCopyWith<OnQueryChangedTv> get copyWith => _$OnQueryChangedTvCopyWithImpl<OnQueryChangedTv>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnQueryChangedTv&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'TvSearchEvent.onQueryChangedTv(query: $query)';
}


}

/// @nodoc
abstract mixin class $OnQueryChangedTvCopyWith<$Res> implements $TvSearchEventCopyWith<$Res> {
  factory $OnQueryChangedTvCopyWith(OnQueryChangedTv value, $Res Function(OnQueryChangedTv) _then) = _$OnQueryChangedTvCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$OnQueryChangedTvCopyWithImpl<$Res>
    implements $OnQueryChangedTvCopyWith<$Res> {
  _$OnQueryChangedTvCopyWithImpl(this._self, this._then);

  final OnQueryChangedTv _self;
  final $Res Function(OnQueryChangedTv) _then;

/// Create a copy of TvSearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(OnQueryChangedTv(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TvSearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvSearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvSearchState()';
}


}

/// @nodoc
class $TvSearchStateCopyWith<$Res>  {
$TvSearchStateCopyWith(TvSearchState _, $Res Function(TvSearchState) __);
}


/// Adds pattern-matching-related methods to [TvSearchState].
extension TvSearchStatePatterns on TvSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchEmpty value)?  searchEmpty,TResult Function( SearchLoading value)?  searchLoading,TResult Function( SearchError value)?  searchError,TResult Function( SearchHasData value)?  searchHasData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchEmpty() when searchEmpty != null:
return searchEmpty(_that);case SearchLoading() when searchLoading != null:
return searchLoading(_that);case SearchError() when searchError != null:
return searchError(_that);case SearchHasData() when searchHasData != null:
return searchHasData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchEmpty value)  searchEmpty,required TResult Function( SearchLoading value)  searchLoading,required TResult Function( SearchError value)  searchError,required TResult Function( SearchHasData value)  searchHasData,}){
final _that = this;
switch (_that) {
case SearchEmpty():
return searchEmpty(_that);case SearchLoading():
return searchLoading(_that);case SearchError():
return searchError(_that);case SearchHasData():
return searchHasData(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchEmpty value)?  searchEmpty,TResult? Function( SearchLoading value)?  searchLoading,TResult? Function( SearchError value)?  searchError,TResult? Function( SearchHasData value)?  searchHasData,}){
final _that = this;
switch (_that) {
case SearchEmpty() when searchEmpty != null:
return searchEmpty(_that);case SearchLoading() when searchLoading != null:
return searchLoading(_that);case SearchError() when searchError != null:
return searchError(_that);case SearchHasData() when searchHasData != null:
return searchHasData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  searchEmpty,TResult Function()?  searchLoading,TResult Function( String message)?  searchError,TResult Function( List<TvSeries> result)?  searchHasData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchEmpty() when searchEmpty != null:
return searchEmpty();case SearchLoading() when searchLoading != null:
return searchLoading();case SearchError() when searchError != null:
return searchError(_that.message);case SearchHasData() when searchHasData != null:
return searchHasData(_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  searchEmpty,required TResult Function()  searchLoading,required TResult Function( String message)  searchError,required TResult Function( List<TvSeries> result)  searchHasData,}) {final _that = this;
switch (_that) {
case SearchEmpty():
return searchEmpty();case SearchLoading():
return searchLoading();case SearchError():
return searchError(_that.message);case SearchHasData():
return searchHasData(_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  searchEmpty,TResult? Function()?  searchLoading,TResult? Function( String message)?  searchError,TResult? Function( List<TvSeries> result)?  searchHasData,}) {final _that = this;
switch (_that) {
case SearchEmpty() when searchEmpty != null:
return searchEmpty();case SearchLoading() when searchLoading != null:
return searchLoading();case SearchError() when searchError != null:
return searchError(_that.message);case SearchHasData() when searchHasData != null:
return searchHasData(_that.result);case _:
  return null;

}
}

}

/// @nodoc


class SearchEmpty implements TvSearchState {
  const SearchEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvSearchState.searchEmpty()';
}


}




/// @nodoc


class SearchLoading implements TvSearchState {
  const SearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvSearchState.searchLoading()';
}


}




/// @nodoc


class SearchError implements TvSearchState {
  const SearchError(this.message);
  

 final  String message;

/// Create a copy of TvSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchErrorCopyWith<SearchError> get copyWith => _$SearchErrorCopyWithImpl<SearchError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TvSearchState.searchError(message: $message)';
}


}

/// @nodoc
abstract mixin class $SearchErrorCopyWith<$Res> implements $TvSearchStateCopyWith<$Res> {
  factory $SearchErrorCopyWith(SearchError value, $Res Function(SearchError) _then) = _$SearchErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SearchErrorCopyWithImpl<$Res>
    implements $SearchErrorCopyWith<$Res> {
  _$SearchErrorCopyWithImpl(this._self, this._then);

  final SearchError _self;
  final $Res Function(SearchError) _then;

/// Create a copy of TvSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SearchError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchHasData implements TvSearchState {
  const SearchHasData(final  List<TvSeries> result): _result = result;
  

 final  List<TvSeries> _result;
 List<TvSeries> get result {
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_result);
}


/// Create a copy of TvSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchHasDataCopyWith<SearchHasData> get copyWith => _$SearchHasDataCopyWithImpl<SearchHasData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchHasData&&const DeepCollectionEquality().equals(other._result, _result));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result));

@override
String toString() {
  return 'TvSearchState.searchHasData(result: $result)';
}


}

/// @nodoc
abstract mixin class $SearchHasDataCopyWith<$Res> implements $TvSearchStateCopyWith<$Res> {
  factory $SearchHasDataCopyWith(SearchHasData value, $Res Function(SearchHasData) _then) = _$SearchHasDataCopyWithImpl;
@useResult
$Res call({
 List<TvSeries> result
});




}
/// @nodoc
class _$SearchHasDataCopyWithImpl<$Res>
    implements $SearchHasDataCopyWith<$Res> {
  _$SearchHasDataCopyWithImpl(this._self, this._then);

  final SearchHasData _self;
  final $Res Function(SearchHasData) _then;

/// Create a copy of TvSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(SearchHasData(
null == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,
  ));
}


}

// dart format on
