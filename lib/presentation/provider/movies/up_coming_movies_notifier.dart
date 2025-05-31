import 'package:ditonton_clean_architecture/domain/usecases/movies/get_up_coming_movies.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/movies/movie.dart';

class UpComingMoviesNotifier extends ChangeNotifier {
  final GetUpComingMovies getUpComingMovies;

  UpComingMoviesNotifier({required this.getUpComingMovies});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  Future<void> fetchUpComingMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getUpComingMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
