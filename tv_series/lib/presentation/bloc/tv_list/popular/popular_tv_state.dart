part of 'popular_tv_bloc.dart';

@freezed
class PopularTvState with _$PopularTvState {
  const factory PopularTvState.initialPopularTv() = InitialPopularTv;

  const factory PopularTvState.loadingPopularTv() = LoadingPopularTv;

  const factory PopularTvState.loadedPopularTv({
    // Data lists
    required List<TvSeries> popular,

    // Pagination pages
    required int popularPage,

    // Pagination flags
    required bool hasMorePopular,

    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = LoadedPopularTv;

  const factory PopularTvState.errorPopularTv(String message) = ErrorPopularTv;

}
