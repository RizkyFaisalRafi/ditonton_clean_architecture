part of 'watchlist_movie_bloc.dart';

@freezed
class WatchlistMovieState with _$WatchlistMovieState {
  const factory WatchlistMovieState.initial() = Initial;

  const factory WatchlistMovieState.loading() = Loading;

  const factory WatchlistMovieState.loaded({
    // Data List Watchlist
    required List<Movie> watchlistMovie,
  }) = Loaded;

  const factory WatchlistMovieState.error(String message) = Error;
}
