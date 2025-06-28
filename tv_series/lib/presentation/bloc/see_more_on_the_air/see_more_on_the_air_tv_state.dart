part of 'see_more_on_the_air_tv_bloc.dart';

@freezed
class SeeMoreOnTheAirTvState with _$SeeMoreOnTheAirTvState {
  const factory SeeMoreOnTheAirTvState.initialOnTheAirTSeeMore() =
      InitialOnTheAirTSeeMore;

  const factory SeeMoreOnTheAirTvState.loadingOnTheAirTSeeMore() =
      LoadingOnTheAirTSeeMore;

  const factory SeeMoreOnTheAirTvState.loadedOnTheAirTSeeMore({
    // Data List
    required List<TvSeries> onTheAir,
    // Pagination Pages
    required int onTheAirPage,
    // Pagination Flags
    required bool hasMoreOnTheAir,
    String? minorError,
  }) = LoadedOnTheAirTSeeMore;

  const factory SeeMoreOnTheAirTvState.errorOnTheAirTSeeMore(String message) =
      ErrorOnTheAirTSeeMore;
}
