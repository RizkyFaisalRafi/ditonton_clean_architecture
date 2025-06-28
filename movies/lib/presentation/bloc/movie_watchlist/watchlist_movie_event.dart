part of 'watchlist_movie_bloc.dart';

@freezed
class WatchlistMovieEvent with _$WatchlistMovieEvent {
  // Event untuk memuat data Watchlist pertama kali
  const factory WatchlistMovieEvent.fetchInitialWatchlistMovies() = FetchInitialWatchlistMovies;
}