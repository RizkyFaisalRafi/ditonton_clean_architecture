part of 'see_more_top_rated_tv_bloc.dart';

@freezed
class SeeMoreTopRatedTvState with _$SeeMoreTopRatedTvState {
  const factory SeeMoreTopRatedTvState.initial() = Initial;

  const factory SeeMoreTopRatedTvState.loading() = Loading;

  const factory SeeMoreTopRatedTvState.loaded({
    // Data List
    required List<TvSeries> topRatedTv,
    // Pagination Pages
    required int topRatedTvPage,
    // Pagination Flags
    required bool hasMoreTopRatedTv,

    String? minorError,
  }) = Loaded;

  const factory SeeMoreTopRatedTvState.error(String message) = Error;
}
