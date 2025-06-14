part of 'top_rated_tv_bloc.dart';

@freezed
class TopRatedTvState with _$TopRatedTvState {
  const factory TopRatedTvState.initial() = Initial;

  const factory TopRatedTvState.loading() = Loading;

  const factory TopRatedTvState.loaded({
    // Data lists
    required List<TvSeries> topRated,

    // Pagination pages
    required int topRatedPage,

    // Pagination flags
    required bool hasMoreTopRated,

    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = Loaded;

  const factory TopRatedTvState.error(String message) = Error;

}
