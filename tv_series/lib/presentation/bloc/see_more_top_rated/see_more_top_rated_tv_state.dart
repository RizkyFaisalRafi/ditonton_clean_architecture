part of 'see_more_top_rated_tv_bloc.dart';

@freezed
class SeeMoreTopRatedTvState with _$SeeMoreTopRatedTvState {
  const factory SeeMoreTopRatedTvState.initialTopRatedTSeeMore() =
      InitialTopRatedTSeeMore;

  const factory SeeMoreTopRatedTvState.loadingTopRatedTSeeMore() =
      LoadingTopRatedTSeeMore;

  const factory SeeMoreTopRatedTvState.loadedTopRatedTSeeMore({
    // Data List
    required List<TvSeries> topRatedTv,
    // Pagination Pages
    required int topRatedTvPage,
    // Pagination Flags
    required bool hasMoreTopRatedTv,

    String? minorError,
  }) = LoadedTopRatedTSeeMore;

  const factory SeeMoreTopRatedTvState.errorTopRatedTSeeMore(String message) =
      ErrorTopRatedTSeeMore;
}
