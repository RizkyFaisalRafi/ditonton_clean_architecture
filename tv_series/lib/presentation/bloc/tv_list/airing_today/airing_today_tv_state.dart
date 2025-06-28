part of 'airing_today_tv_bloc.dart';

@freezed
class AiringTodayTvState with _$AiringTodayTvState {
  const factory AiringTodayTvState.initialAtTv() = InitialAtTv;

  const factory AiringTodayTvState.loadingAtTv() = LoadingAtTv;

  const factory AiringTodayTvState.loadedAtTv({
    // Data lists
    required List<TvSeries> airingToday,

    // Pagination pages
    required int airingTodayPage,

    // Pagination flags
    required bool hasMoreAiringToday,

    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = LoadedAtTv;

  const factory AiringTodayTvState.errorAtTv(String message) = ErrorAtTv;
}
