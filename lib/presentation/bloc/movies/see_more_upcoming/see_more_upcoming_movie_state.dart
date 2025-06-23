part of 'see_more_upcoming_movie_bloc.dart';

@freezed
class SeeMoreUpcomingMovieState with _$SeeMoreUpcomingMovieState {
  const factory SeeMoreUpcomingMovieState.initial() = Initial;

  const factory SeeMoreUpcomingMovieState.loading() = Loading;

  const factory SeeMoreUpcomingMovieState.loaded({
    // Data List
    required List<Movie> upComing,
    // Pagination Pages
    required int upComingPage,
    // Pagination Flags
    required bool hasMoreUpComing,
    String? minorError,
  }) = Loaded;

  const factory SeeMoreUpcomingMovieState.error(String message) = Error;

}
