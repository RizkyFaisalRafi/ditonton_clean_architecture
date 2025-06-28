part of 'see_more_top_rated_tv_bloc.dart';

@freezed
class SeeMoreTopRatedTvEvent with _$SeeMoreTopRatedTvEvent {
  // Event untuk memuat data pertama kali
  const factory SeeMoreTopRatedTvEvent.fetchInitialTopRatedSeeMoreTv() =
      FetchInitialTopRatedSeeMoreTv;

  // Event untuk infinite scroll
  const factory SeeMoreTopRatedTvEvent.fetchMoreTopRatedSeeMoreTv() =
      FetchMoreTopRatedSeeMoreTv;

  // Event untuk pull-to-refresh
  const factory SeeMoreTopRatedTvEvent.refreshTopRatedTv() = RefreshTopRatedTv;
}
