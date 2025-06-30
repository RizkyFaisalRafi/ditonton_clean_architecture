part of 'top_rated_tv_bloc.dart';

@freezed
class TopRatedTvState with _$TopRatedTvState {
  const factory TopRatedTvState.initialTrTv() = InitialTrTv;

  const factory TopRatedTvState.loadingTrTv() = LoadingTrTv;

  const factory TopRatedTvState.loadedTrTv({
    // Data lists
    required List<TvSeries> topRated,

    // Pagination pages
    required int topRatedPage,

    // Pagination flags
    required bool hasMoreTopRated,

    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = LoadedTrTv;

  const factory TopRatedTvState.errorTrTv(String message) = ErrorTrTv;
}
