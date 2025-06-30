part of 'watchlist_movie_bloc.dart';

@freezed
class WatchlistMovieState with _$WatchlistMovieState {
  const factory WatchlistMovieState.initialWatchlistMovie() = InitialWatchlistMovie;

  const factory WatchlistMovieState.loadingWatchlistMovie() = LoadingWatchlistMovie;

  const factory WatchlistMovieState.loadedWatchlistMovie({
    // Data List Watchlist
    required List<Movie> watchlistMovie,
  }) = LoadedWatchlistMovie;

  const factory WatchlistMovieState.errorWatchlistMovie(String message) = ErrorWatchlistMovie;
}
