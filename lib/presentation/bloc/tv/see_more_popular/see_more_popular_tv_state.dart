part of 'see_more_popular_tv_bloc.dart';

@freezed
class SeeMorePopularTvState with _$SeeMorePopularTvState {
  const factory SeeMorePopularTvState.initial() = Initial;

  const factory SeeMorePopularTvState.loading() = Loading;

  const factory SeeMorePopularTvState.loaded({
    // Data List
    required List<TvSeries> popularTv,
    // Pagination Pages
    required int popularTvPage,
    // Pagination Flags
    required bool hasMorePopularTv,

    String? minorError,
  }) = Loaded;

  const factory SeeMorePopularTvState.error(String message) = Error;
}
