part of 'see_more_popular_movie_bloc.dart';

@freezed
class SeeMorePopularMovieState with _$SeeMorePopularMovieState {
  const factory SeeMorePopularMovieState.initialPopularMSeeMore() = InitialPopularMSeeMore;

  const factory SeeMorePopularMovieState.loadingPopularMSeeMore() = LoadingPopularMSeeMore;

  const factory SeeMorePopularMovieState.loadedPopularMSeeMore({
    // Data List
    required List<Movie> popular,
    // Pagination Pages
    required int popularPage,
    // Pagination Flags
    required bool hasMorePopular,
    String? minorError,
  }) = LoadedPopularMSeeMore;

  const factory SeeMorePopularMovieState.errorPopularMSeeMore(String message) = ErrorPopularMSeeMore;
}
