part of 'top_rated_tv_bloc.dart';

@freezed
class TopRatedTvEvent with _$TopRatedTvEvent {
  // Event untuk memuat data pertama kali
  const factory TopRatedTvEvent.fetchInitialTopRatedTv() =
      FetchInitialTopRatedTv;

  // Event untuk infinite scroll per kategori
  const factory TopRatedTvEvent.fetchMoreTopRatedTv() = FetchMoreTopRatedTv;

  // Event untuk pull-to-refresh
  const factory TopRatedTvEvent.refreshTvTr() = RefreshTvTr;
}
