part of 'on_the_air_tv_bloc.dart';

@freezed
class OnTheAirTvEvent with _$OnTheAirTvEvent {
  // Event untuk memuat data pertama kali
  const factory OnTheAirTvEvent.fetchInitialOnTheAir() = FetchInitialOnTheAir;

  // Event untuk infinite scroll per kategori
  const factory OnTheAirTvEvent.fetchMoreOnTheAirTv() = FetchMoreOnTheAirTv;

  // Event untuk pull-to-refresh
  const factory OnTheAirTvEvent.refreshTvOta() = RefreshTvOta;
}
