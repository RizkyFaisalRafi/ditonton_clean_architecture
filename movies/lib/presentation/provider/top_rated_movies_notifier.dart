import 'dart:developer';
import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../module/movies.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesNotifier({required this.getTopRatedMovies}) {
    _init();
  }

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  RefreshController refreshC = RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();

  int _topRatedPage = 1;

  bool _hasMoreTopRated =
      true; // Indikator apakah masih ada data yang bisa dimuat

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  /// Inisialisasi saat objek dibuat
  void _init() {
    loadMovies(); // Load awal semua movie

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreTopRated) {
        loadMoreMovieTopRated();
      }
    });
  }

  /// Menangani infinite scroll
  Future<void> loadMoreMovieTopRated() async {
    if (_isFetching || !_hasMoreTopRated) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchTopRatedMovies();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isFetching = false;
    }
  }

  /// Load awal saat widget pertama kali dibuka
  Future<void> loadMovies() async {
    _state = RequestState.loading;
    log('Load Movies _popularMoviesState: $_state');

    notifyListeners();
    try {
      await onRefresh(); // Pakai fungsi refresh
    } catch (e) {
      // Jika gagal, tampilkan error
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  // Handle Refresh
  Future<void> onRefresh() async {
    log('Calling onRefresh (clears list)');
    try {
      _topRatedPage = 1;

      _hasMoreTopRated = true;

      // Clear data lama
      _movies.clear();

      // Jalankan semua secara paralel
      await fetchTopRatedMovies();

      refreshC.refreshCompleted(); // Beritahu UI Bahwa Refresh Completed
    } catch (e) {
      _message = e.toString();
      log('Catch onRefresh: $_message');
      refreshC.refreshFailed(); // Beritahu UI Bahwa Refresh Gagal
    }
  }

  Future<void> fetchTopRatedMovies() async {
    log('Calling fetchTopRatedMovies with page $_topRatedPage');

    // _state = RequestState.Loading;
    // notifyListeners();

    final result = await getTopRatedMovies.execute(_topRatedPage);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
        log('failure fetchTopRatedMovies: $_message');
      },
      (moviesData) {
        _state = RequestState.loaded;
        log('fetchTopRatedMovies State: $_state');

        if (moviesData.isNotEmpty) {
          if (_topRatedPage == 1) {
            _movies = moviesData; // reset di page 1
          } else {
            _movies.addAll(moviesData);
          }
          _topRatedPage++;
        } else {
          _hasMoreTopRated = false;
        }

        notifyListeners();
      },
    );
  }
}
