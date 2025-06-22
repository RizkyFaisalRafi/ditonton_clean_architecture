part of 'tv_detail_bloc.dart';

@freezed
class TvDetailState with _$TvDetailState {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  const factory TvDetailState.initial() = Initial;
  const factory TvDetailState.loading() = Loading;
  const factory TvDetailState.loaded({
    required TvDetail tvDetail,
    required List<TvSeries> tvRecommendations,
    required RequestState recommendationState,
    required bool isAddedToWatchlist,
    String? watchlistMessage,
  }) = Loaded;
  const factory TvDetailState.error(String message) = Error;
}
