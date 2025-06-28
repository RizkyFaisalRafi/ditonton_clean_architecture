part of 'tv_search_bloc.dart';

@freezed
class TvSearchState with _$TvSearchState {
  // const factory TvSearchState.initial() = _Initial;

  /// State awal atau ketika query kosong.
  const factory TvSearchState.searchEmpty() = SearchEmpty;

  /// State ketika sedang melakukan panggilan API.
  const factory TvSearchState.searchLoading() = SearchLoading;

  /// State ketika terjadi error (baik dari validasi atau API).
  const factory TvSearchState.searchError(String message) = SearchError;

  /// State ketika data berhasil ditemukan dan siap ditampilkan.
  const factory TvSearchState.searchHasData(List<TvSeries> result) = SearchHasData;

}
