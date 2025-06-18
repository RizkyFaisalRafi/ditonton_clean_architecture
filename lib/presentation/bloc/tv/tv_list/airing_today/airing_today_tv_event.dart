part of 'airing_today_tv_bloc.dart';

@freezed
class AiringTodayTvEvent with _$AiringTodayTvEvent {
  // Event untuk memuat data pertama kali
  const factory AiringTodayTvEvent.fetchInitialTvS() = FetchInitialTvS;

  // Event untuk infinite scroll per kategori
  const factory AiringTodayTvEvent.fetchMoreAiringTodayTv() = FetchMoreAiringTodayTv;

  // Event untuk pull-to-refresh
  const factory AiringTodayTvEvent.refreshTv() = RefreshTv;

}