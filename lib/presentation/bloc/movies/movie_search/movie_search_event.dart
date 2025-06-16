part of 'movie_search_bloc.dart';

/**
 * SearchEvent berdasarkan event yang terjadi. Misalnya pada fitur pencarian
 * adalah perubahan query.
 */

@freezed
class MovieSearchEvent with _$MovieSearchEvent {
  /// Event yang dipicu setiap kali teks di field pencarian berubah.
  const factory MovieSearchEvent.onQueryChanged(String query) = OnQueryChanged;
}
