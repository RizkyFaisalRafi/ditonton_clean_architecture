part of 'see_more_popular_tv_bloc.dart';

@freezed
class SeeMorePopularTvEvent with _$SeeMorePopularTvEvent {
  // Event untuk memuat data pertama kali
  const factory SeeMorePopularTvEvent.fetchInitialPopularSeeMoreTv() =
      FetchInitialPopularSeeMoreTv;

  // Event untuk infinite scroll
  const factory SeeMorePopularTvEvent.fetchMorePopularSeeMoreTv() =
      FetchMorePopularSeeMoreTv;

  // Event untuk pull-to-refresh
  const factory SeeMorePopularTvEvent.refreshPopularTv() = RefreshPopularTv;
}
