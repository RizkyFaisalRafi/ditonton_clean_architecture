part of 'airing_today_tv_bloc.dart';

@freezed
class AiringTodayTvState with _$AiringTodayTvState {
  const factory AiringTodayTvState.initial() = Initial;

  const factory AiringTodayTvState.loading() = Loading;

  const factory AiringTodayTvState.loaded({
    // Data lists
    required List<TvSeries> airingToday,

    // Pagination pages
    required int airingTodayPage,

    // Pagination flags
    required bool hasMoreAiringToday,

    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = Loaded;

  const factory AiringTodayTvState.error(String message) = Error;
}
