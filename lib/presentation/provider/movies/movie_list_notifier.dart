import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/movies/get_up_coming_movies.dart';

class MovieListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];

  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.Empty;

  RequestState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];

  var _upComingMovies = <Movie>[];

  List<Movie> get topRatedMovies => _topRatedMovies;

  List<Movie> get upComingMovies => _upComingMovies;

  RequestState _topRatedMoviesState = RequestState.Empty;

  RequestState get topRatedMoviesState => _topRatedMoviesState;

  RequestState _upComingMoviesState = RequestState.Empty;

  RequestState get upComingMoviesState => _upComingMoviesState;

  String _message = '';

  String get message => _message;

  MovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getUpComingMovies,
  });

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetUpComingMovies getUpComingMovies;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.Loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchUpComingMovies() async {
    _upComingMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getUpComingMovies.execute();
    result.fold(
      (failure) {
        _upComingMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _upComingMoviesState = RequestState.Loaded;
        _upComingMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
