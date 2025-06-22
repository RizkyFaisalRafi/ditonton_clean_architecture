part of 'see_more_top_rated_movie_bloc.dart';

@freezed
class SeeMoreTopRatedMovieState with _$SeeMoreTopRatedMovieState {
  const factory SeeMoreTopRatedMovieState.initial() = Initial;

  const factory SeeMoreTopRatedMovieState.loading() = Loading;

  const factory SeeMoreTopRatedMovieState.loaded({
    // Data List
    required List<Movie> topRated,
    // Pagination Pages
    required int topRatedPage,
    // Pagination Flags
    required bool hasMoreTopRated,
    String? minorError,
  }) = Loaded;

  const factory SeeMoreTopRatedMovieState.error(String message) = Error;
}
