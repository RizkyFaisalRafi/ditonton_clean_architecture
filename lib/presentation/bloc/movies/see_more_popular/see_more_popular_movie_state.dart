part of 'see_more_popular_movie_bloc.dart';

@freezed
class SeeMorePopularMovieState with _$SeeMorePopularMovieState {
  const factory SeeMorePopularMovieState.initial() = Initial;

  const factory SeeMorePopularMovieState.loading() = Loading;

  const factory SeeMorePopularMovieState.loaded({
    // Data List
    required List<Movie> popular,
    // Pagination Pages
    required int popularPage,
    // Pagination Flags
    required bool hasMorePopular,
    String? minorError,
  }) = Loaded;

  const factory SeeMorePopularMovieState.error(String message) = Error;
}
