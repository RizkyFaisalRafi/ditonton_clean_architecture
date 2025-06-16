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


class Started implements MovieSearchEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
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


class Initial implements MovieSearchState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieSearchState.initial()';
}


}




/// @nodoc


class SearchEmpty implements MovieSearchState {
  const SearchEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieSearchState.searchEmpty()';
}


}




/// @nodoc


class SearchLoading implements MovieSearchState {
  const SearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieSearchState.searchLoading()';
}


}




/// @nodoc


class SearchError implements MovieSearchState {
  const SearchError(this.message);
  

 final  String message;

/// Create a copy of MovieSearchState
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
  return 'MovieSearchState.searchError(message: $message)';
}


}

/// @nodoc
abstract mixin class $SearchErrorCopyWith<$Res> implements $MovieSearchStateCopyWith<$Res> {
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

/// Create a copy of MovieSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SearchError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchHasData implements MovieSearchState {
  const SearchHasData(final  List<Movie> result): _result = result;
  

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
$SearchHasDataCopyWith<SearchHasData> get copyWith => _$SearchHasDataCopyWithImpl<SearchHasData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchHasData&&const DeepCollectionEquality().equals(other._result, _result));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result));

@override
String toString() {
  return 'MovieSearchState.searchHasData(result: $result)';
}


}

/// @nodoc
abstract mixin class $SearchHasDataCopyWith<$Res> implements $MovieSearchStateCopyWith<$Res> {
  factory $SearchHasDataCopyWith(SearchHasData value, $Res Function(SearchHasData) _then) = _$SearchHasDataCopyWithImpl;
@useResult
$Res call({
 List<Movie> result
});




}
/// @nodoc
class _$SearchHasDataCopyWithImpl<$Res>
    implements $SearchHasDataCopyWith<$Res> {
  _$SearchHasDataCopyWithImpl(this._self, this._then);

  final SearchHasData _self;
  final $Res Function(SearchHasData) _then;

/// Create a copy of MovieSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(SearchHasData(
null == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<Movie>,
  ));
}


}

// dart format on
