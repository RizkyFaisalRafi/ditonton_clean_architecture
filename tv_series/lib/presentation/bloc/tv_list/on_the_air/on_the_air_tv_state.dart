part of 'on_the_air_tv_bloc.dart';

@freezed
class OnTheAirTvState with _$OnTheAirTvState {
  const factory OnTheAirTvState.initialOtaTv() = InitialOtaTv;

  const factory OnTheAirTvState.loadingOtaTv() = LoadingOtaTv;

  const factory OnTheAirTvState.loadedOtaTv({
    // Data lists
    required List<TvSeries> onTheAir,

    // Pagination pages
    required int onTheAirPage,

    // Pagination flags
    required bool hasMoreOnTheAir,

    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = LoadedOtaTv;

  const factory OnTheAirTvState.errorOtaTv(String message) = ErrorOtaTv;
}
