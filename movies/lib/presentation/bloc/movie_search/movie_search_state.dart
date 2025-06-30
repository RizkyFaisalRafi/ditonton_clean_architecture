part of 'movie_search_bloc.dart';

/**
 *
    Pada search_state.dart, tambahkan state yang bisa terjadi,
    sebagai contoh kondisi halaman kosong, loading, sukses mendapatkan data,
    atau ketika terjadi eror.
 */
@freezed
class MovieSearchState with _$MovieSearchState {
  /// State awal atau ketika query kosong.
  const factory MovieSearchState.movieSearchEmpty() = MovieSearchEmpty;

  /// State ketika sedang melakukan panggilan API.
  const factory MovieSearchState.movieSearchLoading() = MovieSearchLoading;

  /// State ketika terjadi error (baik dari validasi atau API).
  const factory MovieSearchState.movieSearchError(String message) = MovieSearchError;

  /// State ketika data berhasil ditemukan dan siap ditampilkan.
  const factory MovieSearchState.movieSearchHasData(List<Movie> result) = MovieSearchHasData;
}
