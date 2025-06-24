part of 'see_more_popular_tv_bloc.dart';

@freezed
class SeeMorePopularTvEvent with _$SeeMorePopularTvEvent {
  // Event untuk memuat data pertama kali
  const factory SeeMorePopularTvEvent.fetchInitialPopularTv() =
      FetchInitialPopularTv;

  // Event untuk infinite scroll
  const factory SeeMorePopularTvEvent.fetchMorePopularTv() = FetchMorePopularTv;

  // Event untuk pull-to-refresh
  const factory SeeMorePopularTvEvent.refreshTv() = RefreshTv;
}
