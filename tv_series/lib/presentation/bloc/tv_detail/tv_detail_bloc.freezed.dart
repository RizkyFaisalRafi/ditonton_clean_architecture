// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [TvDetailEvent].
extension TvDetailEventPatterns on TvDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchTvDetail value)?  fetchTvDetail,TResult Function( AddToWatchlist value)?  addToWatchlist,TResult Function( RemoveFromWatchlist value)?  removeFromWatchlist,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchTvDetail() when fetchTvDetail != null:
return fetchTvDetail(_that);case AddToWatchlist() when addToWatchlist != null:
return addToWatchlist(_that);case RemoveFromWatchlist() when removeFromWatchlist != null:
return removeFromWatchlist(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchTvDetail value)  fetchTvDetail,required TResult Function( AddToWatchlist value)  addToWatchlist,required TResult Function( RemoveFromWatchlist value)  removeFromWatchlist,}){
final _that = this;
switch (_that) {
case FetchTvDetail():
return fetchTvDetail(_that);case AddToWatchlist():
return addToWatchlist(_that);case RemoveFromWatchlist():
return removeFromWatchlist(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchTvDetail value)?  fetchTvDetail,TResult? Function( AddToWatchlist value)?  addToWatchlist,TResult? Function( RemoveFromWatchlist value)?  removeFromWatchlist,}){
final _that = this;
switch (_that) {
case FetchTvDetail() when fetchTvDetail != null:
return fetchTvDetail(_that);case AddToWatchlist() when addToWatchlist != null:
return addToWatchlist(_that);case RemoveFromWatchlist() when removeFromWatchlist != null:
return removeFromWatchlist(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int id)?  fetchTvDetail,TResult Function( TvDetail tvDetail)?  addToWatchlist,TResult Function( TvDetail tvDetail)?  removeFromWatchlist,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchTvDetail() when fetchTvDetail != null:
return fetchTvDetail(_that.id);case AddToWatchlist() when addToWatchlist != null:
return addToWatchlist(_that.tvDetail);case RemoveFromWatchlist() when removeFromWatchlist != null:
return removeFromWatchlist(_that.tvDetail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int id)  fetchTvDetail,required TResult Function( TvDetail tvDetail)  addToWatchlist,required TResult Function( TvDetail tvDetail)  removeFromWatchlist,}) {final _that = this;
switch (_that) {
case FetchTvDetail():
return fetchTvDetail(_that.id);case AddToWatchlist():
return addToWatchlist(_that.tvDetail);case RemoveFromWatchlist():
return removeFromWatchlist(_that.tvDetail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int id)?  fetchTvDetail,TResult? Function( TvDetail tvDetail)?  addToWatchlist,TResult? Function( TvDetail tvDetail)?  removeFromWatchlist,}) {final _that = this;
switch (_that) {
case FetchTvDetail() when fetchTvDetail != null:
return fetchTvDetail(_that.id);case AddToWatchlist() when addToWatchlist != null:
return addToWatchlist(_that.tvDetail);case RemoveFromWatchlist() when removeFromWatchlist != null:
return removeFromWatchlist(_that.tvDetail);case _:
  return null;

}
}

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


/// Adds pattern-matching-related methods to [TvDetailState].
extension TvDetailStatePatterns on TvDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitialTvDetail value)?  initialTvDetail,TResult Function( LoadingTvDetail value)?  loadingTvDetail,TResult Function( LoadedTvDetail value)?  loadedTvDetail,TResult Function( ErrorTvDetail value)?  errorTvDetail,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitialTvDetail() when initialTvDetail != null:
return initialTvDetail(_that);case LoadingTvDetail() when loadingTvDetail != null:
return loadingTvDetail(_that);case LoadedTvDetail() when loadedTvDetail != null:
return loadedTvDetail(_that);case ErrorTvDetail() when errorTvDetail != null:
return errorTvDetail(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitialTvDetail value)  initialTvDetail,required TResult Function( LoadingTvDetail value)  loadingTvDetail,required TResult Function( LoadedTvDetail value)  loadedTvDetail,required TResult Function( ErrorTvDetail value)  errorTvDetail,}){
final _that = this;
switch (_that) {
case InitialTvDetail():
return initialTvDetail(_that);case LoadingTvDetail():
return loadingTvDetail(_that);case LoadedTvDetail():
return loadedTvDetail(_that);case ErrorTvDetail():
return errorTvDetail(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitialTvDetail value)?  initialTvDetail,TResult? Function( LoadingTvDetail value)?  loadingTvDetail,TResult? Function( LoadedTvDetail value)?  loadedTvDetail,TResult? Function( ErrorTvDetail value)?  errorTvDetail,}){
final _that = this;
switch (_that) {
case InitialTvDetail() when initialTvDetail != null:
return initialTvDetail(_that);case LoadingTvDetail() when loadingTvDetail != null:
return loadingTvDetail(_that);case LoadedTvDetail() when loadedTvDetail != null:
return loadedTvDetail(_that);case ErrorTvDetail() when errorTvDetail != null:
return errorTvDetail(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialTvDetail,TResult Function()?  loadingTvDetail,TResult Function( TvDetail tvDetail,  List<TvSeries> tvRecommendations,  RequestState recommendationState,  bool isAddedToWatchlist,  String? watchlistMessage)?  loadedTvDetail,TResult Function( String message)?  errorTvDetail,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitialTvDetail() when initialTvDetail != null:
return initialTvDetail();case LoadingTvDetail() when loadingTvDetail != null:
return loadingTvDetail();case LoadedTvDetail() when loadedTvDetail != null:
return loadedTvDetail(_that.tvDetail,_that.tvRecommendations,_that.recommendationState,_that.isAddedToWatchlist,_that.watchlistMessage);case ErrorTvDetail() when errorTvDetail != null:
return errorTvDetail(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialTvDetail,required TResult Function()  loadingTvDetail,required TResult Function( TvDetail tvDetail,  List<TvSeries> tvRecommendations,  RequestState recommendationState,  bool isAddedToWatchlist,  String? watchlistMessage)  loadedTvDetail,required TResult Function( String message)  errorTvDetail,}) {final _that = this;
switch (_that) {
case InitialTvDetail():
return initialTvDetail();case LoadingTvDetail():
return loadingTvDetail();case LoadedTvDetail():
return loadedTvDetail(_that.tvDetail,_that.tvRecommendations,_that.recommendationState,_that.isAddedToWatchlist,_that.watchlistMessage);case ErrorTvDetail():
return errorTvDetail(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialTvDetail,TResult? Function()?  loadingTvDetail,TResult? Function( TvDetail tvDetail,  List<TvSeries> tvRecommendations,  RequestState recommendationState,  bool isAddedToWatchlist,  String? watchlistMessage)?  loadedTvDetail,TResult? Function( String message)?  errorTvDetail,}) {final _that = this;
switch (_that) {
case InitialTvDetail() when initialTvDetail != null:
return initialTvDetail();case LoadingTvDetail() when loadingTvDetail != null:
return loadingTvDetail();case LoadedTvDetail() when loadedTvDetail != null:
return loadedTvDetail(_that.tvDetail,_that.tvRecommendations,_that.recommendationState,_that.isAddedToWatchlist,_that.watchlistMessage);case ErrorTvDetail() when errorTvDetail != null:
return errorTvDetail(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InitialTvDetail implements TvDetailState {
  const InitialTvDetail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTvDetail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvDetailState.initialTvDetail()';
}


}




/// @nodoc


class LoadingTvDetail implements TvDetailState {
  const LoadingTvDetail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingTvDetail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TvDetailState.loadingTvDetail()';
}


}




/// @nodoc


class LoadedTvDetail implements TvDetailState {
  const LoadedTvDetail({required this.tvDetail, required final  List<TvSeries> tvRecommendations, required this.recommendationState, required this.isAddedToWatchlist, this.watchlistMessage}): _tvRecommendations = tvRecommendations;
  

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
$LoadedTvDetailCopyWith<LoadedTvDetail> get copyWith => _$LoadedTvDetailCopyWithImpl<LoadedTvDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadedTvDetail&&(identical(other.tvDetail, tvDetail) || other.tvDetail == tvDetail)&&const DeepCollectionEquality().equals(other._tvRecommendations, _tvRecommendations)&&(identical(other.recommendationState, recommendationState) || other.recommendationState == recommendationState)&&(identical(other.isAddedToWatchlist, isAddedToWatchlist) || other.isAddedToWatchlist == isAddedToWatchlist)&&(identical(other.watchlistMessage, watchlistMessage) || other.watchlistMessage == watchlistMessage));
}


@override
int get hashCode => Object.hash(runtimeType,tvDetail,const DeepCollectionEquality().hash(_tvRecommendations),recommendationState,isAddedToWatchlist,watchlistMessage);

@override
String toString() {
  return 'TvDetailState.loadedTvDetail(tvDetail: $tvDetail, tvRecommendations: $tvRecommendations, recommendationState: $recommendationState, isAddedToWatchlist: $isAddedToWatchlist, watchlistMessage: $watchlistMessage)';
}


}

/// @nodoc
abstract mixin class $LoadedTvDetailCopyWith<$Res> implements $TvDetailStateCopyWith<$Res> {
  factory $LoadedTvDetailCopyWith(LoadedTvDetail value, $Res Function(LoadedTvDetail) _then) = _$LoadedTvDetailCopyWithImpl;
@useResult
$Res call({
 TvDetail tvDetail, List<TvSeries> tvRecommendations, RequestState recommendationState, bool isAddedToWatchlist, String? watchlistMessage
});




}
/// @nodoc
class _$LoadedTvDetailCopyWithImpl<$Res>
    implements $LoadedTvDetailCopyWith<$Res> {
  _$LoadedTvDetailCopyWithImpl(this._self, this._then);

  final LoadedTvDetail _self;
  final $Res Function(LoadedTvDetail) _then;

/// Create a copy of TvDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tvDetail = null,Object? tvRecommendations = null,Object? recommendationState = null,Object? isAddedToWatchlist = null,Object? watchlistMessage = freezed,}) {
  return _then(LoadedTvDetail(
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


class ErrorTvDetail implements TvDetailState {
  const ErrorTvDetail(this.message);
  

 final  String message;

/// Create a copy of TvDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorTvDetailCopyWith<ErrorTvDetail> get copyWith => _$ErrorTvDetailCopyWithImpl<ErrorTvDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorTvDetail&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TvDetailState.errorTvDetail(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorTvDetailCopyWith<$Res> implements $TvDetailStateCopyWith<$Res> {
  factory $ErrorTvDetailCopyWith(ErrorTvDetail value, $Res Function(ErrorTvDetail) _then) = _$ErrorTvDetailCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorTvDetailCopyWithImpl<$Res>
    implements $ErrorTvDetailCopyWith<$Res> {
  _$ErrorTvDetailCopyWithImpl(this._self, this._then);

  final ErrorTvDetail _self;
  final $Res Function(ErrorTvDetail) _then;

/// Create a copy of TvDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorTvDetail(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
