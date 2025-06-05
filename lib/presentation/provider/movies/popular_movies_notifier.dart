import 'dart:developer';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  RefreshController refreshC = RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();

  int _popularPage = 1; // Halaman saat ini

  bool _hasMorePopular =
      true; // Indikator apakah masih ada data yang bisa dimuat

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  PopularMoviesNotifier({required this.getPopularMovies}) {
    _init();
  }

  /// Inisialisasi saat objek dibuat
  void _init() {
    loadMovies(); // Load awal semua movie

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMorePopular) {
        loadMoreMoviePopular();
      }
    });
  }

  /// Menangani infinite scroll
  Future<void> loadMoreMoviePopular() async {
    if (_isFetching || !_hasMorePopular) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchPopularMovies();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isFetching = false;
    }
  }

  // Handle Refresh
  Future<void> onRefresh() async {
    log('Calling onRefresh (clears list)');
    try {
      _popularPage = 1;

      _hasMorePopular = true;

      // Clear data lama
      _movies.clear();

      // Jalankan semua secara paralel
      await fetchPopularMovies();

      refreshC.refreshCompleted(); // Beritahu UI Bahwa Refresh Completed
    } catch (e) {
      _message = e.toString();
      log('Catch onRefresh: $_message');
      refreshC.refreshFailed(); // Beritahu UI Bahwa Refresh Gagal
    }
  }

  Future<void> fetchPopularMovies() async {
    log('Calling fetchPopularMovies with page $_popularPage');

    // _state = RequestState.Loading;
    // notifyListeners();

    final result = await getPopularMovies.execute(_popularPage);

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
        log('failure fetchPopularMovies: $_message');
      },
      (moviesData) {
        _state = RequestState.Loaded;
        log('fetchPopularMovies State: $_state');

        if (moviesData.isNotEmpty) {
          if (_popularPage == 1) {
            _movies = moviesData; // reset di page 1
          } else {
            _movies.addAll(moviesData);
          }
          _popularPage++;
        } else {
          _hasMorePopular = false;
        }

        notifyListeners();
      },
    );
  }

  /// Load awal saat widget pertama kali dibuka
  Future<void> loadMovies() async {
    _state = RequestState.Loading;
    log('Load Movies _popularMoviesState: $_state');

    notifyListeners();
    try {
      await onRefresh(); // Pakai fungsi refresh
    } catch (e) {
      // Jika gagal, tampilkan error
      _state = RequestState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
