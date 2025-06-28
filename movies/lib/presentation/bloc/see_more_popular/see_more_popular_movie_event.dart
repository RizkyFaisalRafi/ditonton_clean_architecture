part of 'see_more_popular_movie_bloc.dart';

@freezed
class SeeMorePopularMovieEvent with _$SeeMorePopularMovieEvent {
  // Event untuk memuat data pertama kali
  const factory SeeMorePopularMovieEvent.fetchInitialPopularMovies() =
      FetchInitialPopularMovies;

  // Event untuk infinite scroll
  const factory SeeMorePopularMovieEvent.fetchMorePopularSeeMoreMovies() =
      FetchMorePopularSeeMoreMovies;

  // Event untuk pull-to-refresh
  const factory SeeMorePopularMovieEvent.refreshPopularMovies() = RefreshPopularMovies;
}
