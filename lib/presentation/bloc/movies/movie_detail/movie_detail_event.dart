part of 'movie_detail_bloc.dart';

@freezed
class MovieDetailEvent with _$MovieDetailEvent {
  // Event untuk memuat data detail saat pertama kali
  const factory MovieDetailEvent.fetchMovieDetail(int id) = FetchMovieDetail;

  // Event untuk Add to Watchlist
  const factory MovieDetailEvent.addToWatchlist(MovieDetail movieDetail) = AddToWatchlist;

  // Event untuk Delete to Watchlist
  const factory MovieDetailEvent.removeFromWatchlist(MovieDetail movieDetail) = RemoveFromWatchlist;

  // Event untuk Add to Watchlist
  // const factory MovieDetailEvent.loadWatchlistStatus(int id) = LoadWatchlistStatus;
}