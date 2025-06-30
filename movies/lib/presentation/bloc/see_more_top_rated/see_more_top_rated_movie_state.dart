part of 'see_more_top_rated_movie_bloc.dart';

@freezed
class SeeMoreTopRatedMovieState with _$SeeMoreTopRatedMovieState {
  const factory SeeMoreTopRatedMovieState.initialTopRatedMSeeMore() = InitialTopRatedMSeeMore;

  const factory SeeMoreTopRatedMovieState.loadingTopRatedMSeeMore() = LoadingTopRatedMSeeMore;

  const factory SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore({
    // Data List
    required List<Movie> topRated,
    // Pagination Pages
    required int topRatedPage,
    // Pagination Flags
    required bool hasMoreTopRated,
    String? minorError,
  }) = LoadedTopRatedMSeeMore;

  const factory SeeMoreTopRatedMovieState.errorTopRatedMSeeMore(String message) = ErrorTopRatedMSeeMore;
}
