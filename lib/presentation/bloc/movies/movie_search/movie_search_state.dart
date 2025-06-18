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
  const factory MovieSearchState.searchEmpty() = SearchEmpty;

  /// State ketika sedang melakukan panggilan API.
  const factory MovieSearchState.searchLoading() = SearchLoading;

  /// State ketika terjadi error (baik dari validasi atau API).
  const factory MovieSearchState.searchError(String message) = SearchError;

  /// State ketika data berhasil ditemukan dan siap ditampilkan.
  const factory MovieSearchState.searchHasData(List<Movie> result) = SearchHasData;
}
