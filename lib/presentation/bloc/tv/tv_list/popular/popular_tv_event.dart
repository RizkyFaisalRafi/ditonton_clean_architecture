part of 'popular_tv_bloc.dart';

@freezed
class PopularTvEvent with _$PopularTvEvent {
  // Event untuk memuat data pertama kali
  const factory PopularTvEvent.fetchInitialTvS() = FetchInitialTvS;

  // Event untuk infinite scroll per kategori
  const factory PopularTvEvent.fetchMorePopularTv() = FetchMorePopularTv;

  // Event untuk pull-to-refresh
  const factory PopularTvEvent.refreshTv() = RefreshTv;

}