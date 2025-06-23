part of 'see_more_on_the_air_tv_bloc.dart';

@freezed
class SeeMoreOnTheAirTvState with _$SeeMoreOnTheAirTvState {
  const factory SeeMoreOnTheAirTvState.initial() = Initial;

  const factory SeeMoreOnTheAirTvState.loading() = Loading;

  const factory SeeMoreOnTheAirTvState.loaded({
    // Data List
    required List<TvSeries> onTheAir,
    // Pagination Pages
    required int onTheAirPage,
    // Pagination Flags
    required bool hasMoreOnTheAir,
    String? minorError,
  }) = Loaded;

  const factory SeeMoreOnTheAirTvState.error(String message) = Error;
}
