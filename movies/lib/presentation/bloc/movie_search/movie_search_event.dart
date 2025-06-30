part of 'movie_search_bloc.dart';

/**
 * SearchEvent berdasarkan event yang terjadi. Misalnya pada fitur pencarian
 * adalah perubahan query.
 */

@freezed
class MovieSearchEvent with _$MovieSearchEvent {
  const factory MovieSearchEvent.started() = _Started;

  /// Event yang dipicu setiap kali teks di field pencarian berubah.
  const factory MovieSearchEvent.onQueryChanged(String query) = OnQueryChanged;
}
