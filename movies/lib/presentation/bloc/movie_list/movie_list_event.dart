part of 'movie_list_bloc.dart';

@freezed
class MovieListEvent with _$MovieListEvent {
  // Event untuk memuat semua data pertama kali
  const factory MovieListEvent.fetchInitialMovies() = FetchInitialMovies;

  // Event untuk infinite scroll per kategori
  const factory MovieListEvent.fetchMoreNowPlayingMovies() =
      FetchMoreNowPlayingMovies;

  const factory MovieListEvent.fetchMorePopularMovies() =
      FetchMorePopularMovies;

  const factory MovieListEvent.fetchMoreTopRatedMovies() =
      FetchMoreTopRatedMovies;

  const factory MovieListEvent.fetchMoreUpcomingMovies() =
      FetchMoreUpcomingMovies;

  // Event untuk pull-to-refresh
  const factory MovieListEvent.refreshMovies() = RefreshMovies;
}
