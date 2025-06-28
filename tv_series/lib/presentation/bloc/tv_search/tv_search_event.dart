part of 'tv_search_bloc.dart';

@freezed
class TvSearchEvent with _$TvSearchEvent {
  const factory TvSearchEvent.started() = _Started;

  /// Event yang dipicu setiap kali teks di field pencarian berubah.
  const factory TvSearchEvent.onQueryChangedTv(String query) = OnQueryChangedTv;
}