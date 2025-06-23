part of 'watchlist_tv_bloc.dart';

@freezed
class WatchlistTvEvent with _$WatchlistTvEvent {
  // Event untuk memuat data Watchlist pertama kali
  const factory WatchlistTvEvent.fetchInitialWatchlistTv() =
      FetchInitialWatchlistTv;
}
