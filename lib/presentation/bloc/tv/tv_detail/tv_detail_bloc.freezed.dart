// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tv_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TvDetailEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvDetailEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvDetailEvent()';
}


}

/// @nodoc
class $TvDetailEventCopyWith<$Res>  {
$TvDetailEventCopyWith(TvDetailEvent _, $Res Function(TvDetailEvent) __);
}


/// @nodoc


class FetchTvDetail implements TvDetailEvent {
  const FetchTvDetail(this.id);
  

 final  int id;

/// Create a copy of TvDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchTvDetailCopyWith<FetchTvDetail> get copyWith => _$FetchTvDetailCopyWithImpl<FetchTvDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchTvDetail&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'TvDetailEvent.fetchTvDetail(id: $id)';
}


}

/// @nodoc
abstract mixin class $FetchTvDetailCopyWith<$Res> implements $TvDetailEventCopyWith<$Res> {
  factory $FetchTvDetailCopyWith(FetchTvDetail value, $Res Function(FetchTvDetail) _then) = _$FetchTvDetailCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$FetchTvDetailCopyWithImpl<$Res>
    implements $FetchTvDetailCopyWith<$Res> {
  _$FetchTvDetailCopyWithImpl(this._self, this._then);

  final FetchTvDetail _self;
  final $Res Function(FetchTvDetail) _then;

/// Create a copy of TvDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(FetchTvDetail(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class AddToWatchlist implements TvDetailEvent {
  const AddToWatchlist(this.tvDetail);
  

 final  TvDetail tvDetail;

/// Create a copy of TvDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddToWatchlistCopyWith<AddToWatchlist> get copyWith => _$AddToWatchlistCopyWithImpl<AddToWatchlist>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddToWatchlist&&(identical(other.tvDetail, tvDetail) || other.tvDetail == tvDetail));
}


@override
int get hashCode => Object.hash(runtimeType,tvDetail);

@override
String toString() {
  return 'TvDetailEvent.addToWatchlist(tvDetail: $tvDetail)';
}


}

/// @nodoc
abstract mixin class $AddToWatchlistCopyWith<$Res> implements $TvDetailEventCopyWith<$Res> {
  factory $AddToWatchlistCopyWith(AddToWatchlist value, $Res Function(AddToWatchlist) _then) = _$AddToWatchlistCopyWithImpl;
@useResult
$Res call({
 TvDetail tvDetail
});




}
/// @nodoc
class _$AddToWatchlistCopyWithImpl<$Res>
    implements $AddToWatchlistCopyWith<$Res> {
  _$AddToWatchlistCopyWithImpl(this._self, this._then);

  final AddToWatchlist _self;
  final $Res Function(AddToWatchlist) _then;

/// Create a copy of TvDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tvDetail = null,}) {
  return _then(AddToWatchlist(
null == tvDetail ? _self.tvDetail : tvDetail // ignore: cast_nullable_to_non_nullable
as TvDetail,
  ));
}


}

/// @nodoc


class RemoveFromWatchlist implements TvDetailEvent {
  const RemoveFromWatchlist(this.tvDetail);
  

 final  TvDetail tvDetail;

/// Create a copy of TvDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveFromWatchlistCopyWith<RemoveFromWatchlist> get copyWith => _$RemoveFromWatchlistCopyWithImpl<RemoveFromWatchlist>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveFromWatchlist&&(identical(other.tvDetail, tvDetail) || other.tvDetail == tvDetail));
}


@override
int get hashCode => Object.hash(runtimeType,tvDetail);

@override
String toString() {
  return 'TvDetailEvent.removeFromWatchlist(tvDetail: $tvDetail)';
}


}

/// @nodoc
abstract mixin class $RemoveFromWatchlistCopyWith<$Res> implements $TvDetailEventCopyWith<$Res> {
  factory $RemoveFromWatchlistCopyWith(RemoveFromWatchlist value, $Res Function(RemoveFromWatchlist) _then) = _$RemoveFromWatchlistCopyWithImpl;
@useResult
$Res call({
 TvDetail tvDetail
});




}
/// @nodoc
class _$RemoveFromWatchlistCopyWithImpl<$Res>
    implements $RemoveFromWatchlistCopyWith<$Res> {
  _$RemoveFromWatchlistCopyWithImpl(this._self, this._then);

  final RemoveFromWatchlist _self;
  final $Res Function(RemoveFromWatchlist) _then;

/// Create a copy of TvDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tvDetail = null,}) {
  return _then(RemoveFromWatchlist(
null == tvDetail ? _self.tvDetail : tvDetail // ignore: cast_nullable_to_non_nullable
as TvDetail,
  ));
}


}

/// @nodoc
mixin _$TvDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TvDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvDetailState()';
}


}

/// @nodoc
class $TvDetailStateCopyWith<$Res>  {
$TvDetailStateCopyWith(TvDetailState _, $Res Function(TvDetailState) __);
}


/// @nodoc


class Initial implements TvDetailState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvDetailState.initial()';
}


}




/// @nodoc


class Loading implements TvDetailState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvDetailState.loading()';
}


}




/// @nodoc


class Loaded implements TvDetailState {
  const Loaded({required this.tvDetail, required final  List<TvSeries> tvRecommendations, required this.recommendationState, required this.isAddedToWatchlist, this.watchlistMessage}): _tvRecommendations = tvRecommendations;
  

 final  TvDetail tvDetail;
 final  List<TvSeries> _tvRecommendations;
 List<TvSeries> get tvRecommendations {
  if (_tvRecommendations is EqualUnmodifiableListView) return _tvRecommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tvRecommendations);
}

 final  RequestState recommendationState;
 final  bool isAddedToWatchlist;
 final  String? watchlistMessage;

/// Create a copy of TvDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadedCopyWith<Loaded> get copyWith => _$LoadedCopyWithImpl<Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loaded&&(identical(other.tvDetail, tvDetail) || other.tvDetail == tvDetail)&&const DeepCollectionEquality().equals(other._tvRecommendations, _tvRecommendations)&&(identical(other.recommendationState, recommendationState) || other.recommendationState == recommendationState)&&(identical(other.isAddedToWatchlist, isAddedToWatchlist) || other.isAddedToWatchlist == isAddedToWatchlist)&&(identical(other.watchlistMessage, watchlistMessage) || other.watchlistMessage == watchlistMessage));
}


@override
int get hashCode => Object.hash(runtimeType,tvDetail,const DeepCollectionEquality().hash(_tvRecommendations),recommendationState,isAddedToWatchlist,watchlistMessage);

@override
String toString() {
  return 'TvDetailState.loaded(tvDetail: $tvDetail, tvRecommendations: $tvRecommendations, recommendationState: $recommendationState, isAddedToWatchlist: $isAddedToWatchlist, watchlistMessage: $watchlistMessage)';
}


}

/// @nodoc
abstract mixin class $LoadedCopyWith<$Res> implements $TvDetailStateCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) _then) = _$LoadedCopyWithImpl;
@useResult
$Res call({
 TvDetail tvDetail, List<TvSeries> tvRecommendations, RequestState recommendationState, bool isAddedToWatchlist, String? watchlistMessage
});




}
/// @nodoc
class _$LoadedCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(this._self, this._then);

  final Loaded _self;
  final $Res Function(Loaded) _then;

/// Create a copy of TvDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tvDetail = null,Object? tvRecommendations = null,Object? recommendationState = null,Object? isAddedToWatchlist = null,Object? watchlistMessage = freezed,}) {
  return _then(Loaded(
tvDetail: null == tvDetail ? _self.tvDetail : tvDetail // ignore: cast_nullable_to_non_nullable
as TvDetail,tvRecommendations: null == tvRecommendations ? _self._tvRecommendations : tvRecommendations // ignore: cast_nullable_to_non_nullable
as List<TvSeries>,recommendationState: null == recommendationState ? _self.recommendationState : recommendationState // ignore: cast_nullable_to_non_nullable
as RequestState,isAddedToWatchlist: null == isAddedToWatchlist ? _self.isAddedToWatchlist : isAddedToWatchlist // ignore: cast_nullable_to_non_nullable
as bool,watchlistMessage: freezed == watchlistMessage ? _self.watchlistMessage : watchlistMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class Error implements TvDetailState {
  const Error(this.message);
  

 final  String message;

/// Create a copy of TvDetailState
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
  return 'TvDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $TvDetailStateCopyWith<$Res> {
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

/// Create a copy of TvDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
