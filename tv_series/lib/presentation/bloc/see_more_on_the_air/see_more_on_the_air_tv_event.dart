part of 'see_more_on_the_air_tv_bloc.dart';

@freezed
class SeeMoreOnTheAirTvEvent with _$SeeMoreOnTheAirTvEvent {
  // Event untuk memuat data pertama kali
  const factory SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirSeeMoreTv() =
      FetchInitialOnTheAirSeeMoreTv;

  // Event untuk infinite scroll
  const factory SeeMoreOnTheAirTvEvent.fetchMoreOnTheAirSeeMoreTv() =
      FetchMoreOnTheAirSeeMoreTv;

  // Event untuk pull-to-refresh
  const factory SeeMoreOnTheAirTvEvent.refreshOnTheAirTv() = RefreshOnTheAirTv;
}
