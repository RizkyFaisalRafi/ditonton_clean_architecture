import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/search_movies.dart';
import 'package:flutter/foundation.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;

  MovieSearchNotifier({required this.searchMovies});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _searchResult = [];
  List<Movie> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  bool _isQueryValid(String query) {
    // Validasi Empty
    if (query.trim().isEmpty) {
      _message = 'Query cannot be empty';
      return false;
    }
    // Validasi karakter khusus
    if (RegExp(r'[!@#$%^&*(),.?"{}|<>]').hasMatch(query)) {
      _message = 'Query contains invalid characters';
      return false;
    }

    return true;
  }

  Future<void> fetchMovieSearch(String query) async {
    // Validasi
    if (!_isQueryValid(query)) {
      _state = RequestState.Error;
      notifyListeners();
      return;
    }

    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}