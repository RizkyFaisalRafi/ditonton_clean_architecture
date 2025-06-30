part of 'movie_list_bloc.dart';

@freezed
class MovieListState with _$MovieListState {
  const factory MovieListState.initialMovieList() = InitialMovieList;

  const factory MovieListState.loadingMovieList() = LoadingMovieList;

  const factory MovieListState.loadedMovieList({
    // Data lists
    required List<Movie> nowPlaying,
    required List<Movie> popular,
    required List<Movie> topRated,
    required List<Movie> upcoming,
    // Pagination pages
    required int nowPlayingPage,
    required int popularPage,
    required int topRatedPage,
    required int upcomingPage,
    // Pagination flags
    required bool hasMoreNowPlaying,
    required bool hasMorePopular,
    required bool hasMoreTopRated,
    required bool hasMoreUpcoming,
    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = LoadedMovieList;

  const factory MovieListState.errorMovieList(String message) = ErrorMovieList;
}
