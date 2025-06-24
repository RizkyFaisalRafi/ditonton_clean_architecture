part of 'see_more_top_rated_tv_bloc.dart';

@freezed
class SeeMoreTopRatedTvEvent with _$SeeMoreTopRatedTvEvent {
  // Event untuk memuat data pertama kali
  const factory SeeMoreTopRatedTvEvent.fetchInitialTopRatedTv() =
      FetchInitialTopRatedTv;

  // Event untuk infinite scroll
  const factory SeeMoreTopRatedTvEvent.fetchMoreTopRatedTv() =
      FetchMoreTopRatedTv;

  // Event untuk pull-to-refresh
  const factory SeeMoreTopRatedTvEvent.refreshTv() = RefreshTv;
}
