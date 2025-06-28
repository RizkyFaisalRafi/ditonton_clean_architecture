part of 'see_more_upcoming_movie_bloc.dart';

@freezed
class SeeMoreUpcomingMovieEvent with _$SeeMoreUpcomingMovieEvent {
  // Event untuk memuat data pertama kali
  const factory SeeMoreUpcomingMovieEvent.fetchInitialUpComingMovies() =
      FetchInitialUpComingMovies;

  // Event untuk infinite scroll
  const factory SeeMoreUpcomingMovieEvent.fetchMoreUpComingSeeMoreMovies() =
      FetchMoreUpComingSeeMoreMovies;

  // Event untuk pull-to-refresh
  const factory SeeMoreUpcomingMovieEvent.refreshUpComingMovies() = RefreshUpComingMovies;
}
