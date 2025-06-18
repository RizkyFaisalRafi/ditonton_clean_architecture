part of 'movie_list_bloc.dart';

@freezed
class MovieListState with _$MovieListState {
  const factory MovieListState.initial() = Initial;

  const factory MovieListState.loading() = Loading;

  const factory MovieListState.loaded({
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
  }) = Loaded;

  const factory MovieListState.error(String message) = Error;
}
