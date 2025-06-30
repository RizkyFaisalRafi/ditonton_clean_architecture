part of 'see_more_upcoming_movie_bloc.dart';

@freezed
class SeeMoreUpcomingMovieState with _$SeeMoreUpcomingMovieState {
  const factory SeeMoreUpcomingMovieState.initialUpComingMSeeMore() = InitialUpComingMSeeMore;

  const factory SeeMoreUpcomingMovieState.loadingUpComingMSeeMore() = LoadingUpComingMSeeMore;

  const factory SeeMoreUpcomingMovieState.loadedUpComingMSeeMore({
    // Data List
    required List<Movie> upComing,
    // Pagination Pages
    required int upComingPage,
    // Pagination Flags
    required bool hasMoreUpComing,
    String? minorError,
  }) = LoadedUpComingMSeeMore;

  const factory SeeMoreUpcomingMovieState.errorUpComingMSeeMore(String message) = ErrorUpComingMSeeMore;

}
