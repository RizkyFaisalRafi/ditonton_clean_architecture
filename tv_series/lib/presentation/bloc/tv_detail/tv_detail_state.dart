part of 'tv_detail_bloc.dart';

@freezed
class TvDetailState with _$TvDetailState {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  const factory TvDetailState.initialTvDetail() = InitialTvDetail;
  const factory TvDetailState.loadingTvDetail() = LoadingTvDetail;
  const factory TvDetailState.loadedTvDetail({
    required TvDetail tvDetail,
    required List<TvSeries> tvRecommendations,
    required RequestState recommendationState,
    required bool isAddedToWatchlist,
    String? watchlistMessage,
  }) = LoadedTvDetail;
  const factory TvDetailState.errorTvDetail(String message) = ErrorTvDetail;
}
