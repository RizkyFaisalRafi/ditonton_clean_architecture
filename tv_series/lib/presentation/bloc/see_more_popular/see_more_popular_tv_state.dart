part of 'see_more_popular_tv_bloc.dart';

@freezed
class SeeMorePopularTvState with _$SeeMorePopularTvState {
  const factory SeeMorePopularTvState.initialPopularTSeeMore() =
      InitialPopularTSeeMore;

  const factory SeeMorePopularTvState.loadingPopularTSeeMore() =
      LoadingPopularTSeeMore;

  const factory SeeMorePopularTvState.loadedPopularTSeeMore({
    // Data List
    required List<TvSeries> popularTv,
    // Pagination Pages
    required int popularTvPage,
    // Pagination Flags
    required bool hasMorePopularTv,

    String? minorError,
  }) = LoadedPopularTSeeMore;

  const factory SeeMorePopularTvState.errorPopularTSeeMore(String message) =
      ErrorPopularTSeeMore;
}
