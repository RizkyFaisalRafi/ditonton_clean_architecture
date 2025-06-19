// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MovieDetailEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieDetailEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieDetailEvent()';
}


}

/// @nodoc
class $MovieDetailEventCopyWith<$Res>  {
$MovieDetailEventCopyWith(MovieDetailEvent _, $Res Function(MovieDetailEvent) __);
}


/// @nodoc


class FetchMovieDetail implements MovieDetailEvent {
  const FetchMovieDetail(this.id);
  

 final  int id;

/// Create a copy of MovieDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchMovieDetailCopyWith<FetchMovieDetail> get copyWith => _$FetchMovieDetailCopyWithImpl<FetchMovieDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMovieDetail&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'MovieDetailEvent.fetchMovieDetail(id: $id)';
}


}

/// @nodoc
abstract mixin class $FetchMovieDetailCopyWith<$Res> implements $MovieDetailEventCopyWith<$Res> {
  factory $FetchMovieDetailCopyWith(FetchMovieDetail value, $Res Function(FetchMovieDetail) _then) = _$FetchMovieDetailCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$FetchMovieDetailCopyWithImpl<$Res>
    implements $FetchMovieDetailCopyWith<$Res> {
  _$FetchMovieDetailCopyWithImpl(this._self, this._then);

  final FetchMovieDetail _self;
  final $Res Function(FetchMovieDetail) _then;

/// Create a copy of MovieDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(FetchMovieDetail(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class AddToWatchlist implements MovieDetailEvent {
  const AddToWatchlist(this.movieDetail);
  

 final  MovieDetail movieDetail;

/// Create a copy of MovieDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddToWatchlistCopyWith<AddToWatchlist> get copyWith => _$AddToWatchlistCopyWithImpl<AddToWatchlist>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddToWatchlist&&(identical(other.movieDetail, movieDetail) || other.movieDetail == movieDetail));
}


@override
int get hashCode => Object.hash(runtimeType,movieDetail);

@override
String toString() {
  return 'MovieDetailEvent.addToWatchlist(movieDetail: $movieDetail)';
}


}

/// @nodoc
abstract mixin class $AddToWatchlistCopyWith<$Res> implements $MovieDetailEventCopyWith<$Res> {
  factory $AddToWatchlistCopyWith(AddToWatchlist value, $Res Function(AddToWatchlist) _then) = _$AddToWatchlistCopyWithImpl;
@useResult
$Res call({
 MovieDetail movieDetail
});




}
/// @nodoc
class _$AddToWatchlistCopyWithImpl<$Res>
    implements $AddToWatchlistCopyWith<$Res> {
  _$AddToWatchlistCopyWithImpl(this._self, this._then);

  final AddToWatchlist _self;
  final $Res Function(AddToWatchlist) _then;

/// Create a copy of MovieDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? movieDetail = null,}) {
  return _then(AddToWatchlist(
null == movieDetail ? _self.movieDetail : movieDetail // ignore: cast_nullable_to_non_nullable
as MovieDetail,
  ));
}


}

/// @nodoc


class RemoveFromWatchlist implements MovieDetailEvent {
  const RemoveFromWatchlist(this.movieDetail);
  

 final  MovieDetail movieDetail;

/// Create a copy of MovieDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveFromWatchlistCopyWith<RemoveFromWatchlist> get copyWith => _$RemoveFromWatchlistCopyWithImpl<RemoveFromWatchlist>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveFromWatchlist&&(identical(other.movieDetail, movieDetail) || other.movieDetail == movieDetail));
}


@override
int get hashCode => Object.hash(runtimeType,movieDetail);

@override
String toString() {
  return 'MovieDetailEvent.removeFromWatchlist(movieDetail: $movieDetail)';
}


}

/// @nodoc
abstract mixin class $RemoveFromWatchlistCopyWith<$Res> implements $MovieDetailEventCopyWith<$Res> {
  factory $RemoveFromWatchlistCopyWith(RemoveFromWatchlist value, $Res Function(RemoveFromWatchlist) _then) = _$RemoveFromWatchlistCopyWithImpl;
@useResult
$Res call({
 MovieDetail movieDetail
});




}
/// @nodoc
class _$RemoveFromWatchlistCopyWithImpl<$Res>
    implements $RemoveFromWatchlistCopyWith<$Res> {
  _$RemoveFromWatchlistCopyWithImpl(this._self, this._then);

  final RemoveFromWatchlist _self;
  final $Res Function(RemoveFromWatchlist) _then;

/// Create a copy of MovieDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? movieDetail = null,}) {
  return _then(RemoveFromWatchlist(
null == movieDetail ? _self.movieDetail : movieDetail // ignore: cast_nullable_to_non_nullable
as MovieDetail,
  ));
}


}

/// @nodoc
mixin _$MovieDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovieDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieDetailState()';
}


}

/// @nodoc
class $MovieDetailStateCopyWith<$Res>  {
$MovieDetailStateCopyWith(MovieDetailState _, $Res Function(MovieDetailState) __);
}


/// @nodoc


class Initial implements MovieDetailState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieDetailState.initial()';
}


}




/// @nodoc


class Loading implements MovieDetailState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieDetailState.loading()';
}


}




/// @nodoc


class Loaded implements MovieDetailState {
  const Loaded({required this.movieDetail, required final  List<Movie> movieRecommendations, required this.recommendationState, required this.isAddedToWatchlist, this.watchlistMessage}): _movieRecommendations = movieRecommendations;
  

 final  MovieDetail movieDetail;
 final  List<Movie> _movieRecommendations;
 List<Movie> get movieRecommendations {
  if (_movieRecommendations is EqualUnmodifiableListView) return _movieRecommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movieRecommendations);
}

 final  RequestState recommendationState;
 final  bool isAddedToWatchlist;
 final  String? watchlistMessage;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&(identical(other.movieDetail, movieDetail) || other.movieDetail == movieDetail)&&const DeepCollectionEquality().equals(other._movieRecommendations, _movieRecommendations)&&(identical(other.recommendationState, recommendationState) || other.recommendationState == recommendationState)&&(identical(other.isAddedToWatchlist, isAddedToWatchlist) || other.isAddedToWatchlist == isAddedToWatchlist)&&(identical(other.watchlistMessage, watchlistMessage) || other.watchlistMessage == watchlistMessage));
}


@override
int get hashCode => Object.hash(runtimeType,movieDetail,const DeepCollectionEquality().hash(_movieRecommendations),recommendationState,isAddedToWatchlist,watchlistMessage);

@override
String toString() {
  return 'MovieDetailState.loaded(movieDetail: $movieDetail, movieRecommendations: $movieRecommendations, recommendationState: $recommendationState, isAddedToWatchlist: $isAddedToWatchlist, watchlistMessage: $watchlistMessage)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $MovieDetailStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 MovieDetail movieDetail, List<Movie> movieRecommendations, RequestState recommendationState, bool isAddedToWatchlist, String? watchlistMessage
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? movieDetail = null,Object? movieRecommendations = null,Object? recommendationState = null,Object? isAddedToWatchlist = null,Object? watchlistMessage = freezed,}) {
  return _then(Loaded(
movieDetail: null == movieDetail ? _self.movieDetail : movieDetail // ignore: cast_nullable_to_non_nullable
as MovieDetail,movieRecommendations: null == movieRecommendations ? _self._movieRecommendations : movieRecommendations // ignore: cast_nullable_to_non_nullable
as List<Movie>,recommendationState: null == recommendationState ? _self.recommendationState : recommendationState // ignore: cast_nullable_to_non_nullable
as RequestState,isAddedToWatchlist: null == isAddedToWatchlist ? _self.isAddedToWatchlist : isAddedToWatchlist // ignore: cast_nullable_to_non_nullable
as bool,watchlistMessage: freezed == watchlistMessage ? _self.watchlistMessage : watchlistMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements MovieDetailState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MovieDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $MovieDetailStateCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
