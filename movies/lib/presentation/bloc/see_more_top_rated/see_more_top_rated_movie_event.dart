part of 'see_more_top_rated_movie_bloc.dart';

@freezed
class SeeMoreTopRatedMovieEvent with _$SeeMoreTopRatedMovieEvent {
  // Event untuk memuat data pertama kali
  const factory SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies() =
      FetchInitialTopRatedMovies;

  // Event untuk infinite scroll
  const factory SeeMoreTopRatedMovieEvent.fetchMoreTopRatedSeeMoreMovies() =
      FetchMoreTopRatedSeeMoreMovies;

  // Event untuk pull-to-refresh
  const factory SeeMoreTopRatedMovieEvent.refreshTopRatedMovies() = RefreshTopRatedMovies;
}
