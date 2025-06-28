part of 'watchlist_tv_bloc.dart';

@freezed
class WatchlistTvState with _$WatchlistTvState {
  const factory WatchlistTvState.initialWatchlistTv() = InitialWatchlistTv;

  const factory WatchlistTvState.loadingWatchlistTv() = LoadingWatchlistTv;

  const factory WatchlistTvState.loadedWatchlistTv({
    // Data List Watchlist
    required List<TvSeries> watchlistTv,
  }) = LoadedWatchlistTv;

  const factory WatchlistTvState.errorWatchlistTv(String message) =
      ErrorWatchlistTv;
}
