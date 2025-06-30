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


class InitialMovieDetail implements MovieDetailState {
  const InitialMovieDetail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialMovieDetail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieDetailState.initialMovieDetail()';
}


}




/// @nodoc


class LoadingMovieDetail implements MovieDetailState {
  const LoadingMovieDetail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingMovieDetail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MovieDetailState.loadingMovieDetail()';
}


}




/// @nodoc


class LoadedMovieDetail implements MovieDetailState {
  const LoadedMovieDetail({required this.movieDetail, required final  List<Movie> movieRecommendations, required this.recommendationState, required this.isAddedToWatchlist, this.watchlistMessage}): _movieRecommendations = movieRecommendations;
  

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
$LoadedMovieDetailCopyWith<LoadedMovieDetail> get copyWith => _$LoadedMovieDetailCopyWithImpl<LoadedMovieDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedMovieDetail&&(identical(other.movieDetail, movieDetail) || other.movieDetail == movieDetail)&&const DeepCollectionEquality().equals(other._movieRecommendations, _movieRecommendations)&&(identical(other.recommendationState, recommendationState) || other.recommendationState == recommendationState)&&(identical(other.isAddedToWatchlist, isAddedToWatchlist) || other.isAddedToWatchlist == isAddedToWatchlist)&&(identical(other.watchlistMessage, watchlistMessage) || other.watchlistMessage == watchlistMessage));
}


@override
int get hashCode => Object.hash(runtimeType,movieDetail,const DeepCollectionEquality().hash(_movieRecommendations),recommendationState,isAddedToWatchlist,watchlistMessage);

@override
String toString() {
  return 'MovieDetailState.loadedMovieDetail(movieDetail: $movieDetail, movieRecommendations: $movieRecommendations, recommendationState: $recommendationState, isAddedToWatchlist: $isAddedToWatchlist, watchlistMessage: $watchlistMessage)';
}


}

/// @nodoc
abstract mixin class $LoadedMovieDetailCopyWith<$Res> implements $MovieDetailStateCopyWith<$Res> {
  factory $LoadedMovieDetailCopyWith(LoadedMovieDetail value, $Res Function(LoadedMovieDetail) _then) = _$LoadedMovieDetailCopyWithImpl;
@useResult
$Res call({
 MovieDetail movieDetail, List<Movie> movieRecommendations, RequestState recommendationState, bool isAddedToWatchlist, String? watchlistMessage
});




}
/// @nodoc
class _$LoadedMovieDetailCopyWithImpl<$Res>
    implements $LoadedMovieDetailCopyWith<$Res> {
  _$LoadedMovieDetailCopyWithImpl(this._self, this._then);

  final LoadedMovieDetail _self;
  final $Res Function(LoadedMovieDetail) _then;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? movieDetail = null,Object? movieRecommendations = null,Object? recommendationState = null,Object? isAddedToWatchlist = null,Object? watchlistMessage = freezed,}) {
  return _then(LoadedMovieDetail(
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


class ErrorMovieDetail implements MovieDetailState {
  const ErrorMovieDetail(this.message);
  

 final  String message;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorMovieDetailCopyWith<ErrorMovieDetail> get copyWith => _$ErrorMovieDetailCopyWithImpl<ErrorMovieDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorMovieDetail&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MovieDetailState.errorMovieDetail(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorMovieDetailCopyWith<$Res> implements $MovieDetailStateCopyWith<$Res> {
  factory $ErrorMovieDetailCopyWith(ErrorMovieDetail value, $Res Function(ErrorMovieDetail) _then) = _$ErrorMovieDetailCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorMovieDetailCopyWithImpl<$Res>
    implements $ErrorMovieDetailCopyWith<$Res> {
  _$ErrorMovieDetailCopyWithImpl(this._self, this._then);

  final ErrorMovieDetail _self;
  final $Res Function(ErrorMovieDetail) _then;

/// Create a copy of MovieDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorMovieDetail(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
