part of 'tv_detail_bloc.dart';

@freezed
class TvDetailEvent with _$TvDetailEvent {
  // Event untuk memuat data detail saat pertama kali
  const factory TvDetailEvent.fetchTvDetail(int id) = FetchTvDetail;

  // Event untuk Add Watchlist
  const factory TvDetailEvent.addToWatchlist(TvDetail tvDetail) =
      AddToWatchlist;

  // Event untuk delete Watchlist
  const factory TvDetailEvent.removeFromWatchlist(TvDetail tvDetail) =
      RemoveFromWatchlist;
}
