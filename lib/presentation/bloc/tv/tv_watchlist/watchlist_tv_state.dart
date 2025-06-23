part of 'watchlist_tv_bloc.dart';

@freezed
class WatchlistTvState with _$WatchlistTvState {
  const factory WatchlistTvState.initial() = Initial;

  const factory WatchlistTvState.loading() = Loading;

  const factory WatchlistTvState.loaded({
    // Data List Watchlist
    required List<TvSeries> watchlistTv,
  }) = Loaded;

  const factory WatchlistTvState.error(String message) = Error;
}
