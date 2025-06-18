part of 'popular_tv_bloc.dart';

@freezed
class PopularTvState with _$PopularTvState {
  const factory PopularTvState.initial() = Initial;

  const factory PopularTvState.loading() = Loading;

  const factory PopularTvState.loaded({
    // Data lists
    required List<TvSeries> popular,

    // Pagination pages
    required int popularPage,

    // Pagination flags
    required bool hasMorePopular,

    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = Loaded;

  const factory PopularTvState.error(String message) = Error;

}
