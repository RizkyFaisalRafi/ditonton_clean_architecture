// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
