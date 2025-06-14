part of 'on_the_air_tv_bloc.dart';

@freezed
class OnTheAirTvState with _$OnTheAirTvState {
  const factory OnTheAirTvState.initial() = Initial;

  const factory OnTheAirTvState.loading() = Loading;

  const factory OnTheAirTvState.loaded({
    // Data lists
    required List<TvSeries> onTheAir,

    // Pagination pages
    required int onTheAirPage,

    // Pagination flags
    required bool hasMoreOnTheAir,

    // Opsional: untuk menampilkan error minor tanpa mengubah seluruh state jadi error
    String? minorError,
  }) = Loaded;

  const factory OnTheAirTvState.error(String message) = Error;

}
