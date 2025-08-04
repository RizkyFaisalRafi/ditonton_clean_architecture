import 'dart:developer';
import 'package:core/module/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../module/movies.dart';

class UpComingMoviesNotifier extends ChangeNotifier {
  final GetUpComingMovies getUpComingMovies;

  UpComingMoviesNotifier({required this.getUpComingMovies}) {
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

  int _upComingPage = 1;

  bool _hasMoreUpComing =
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
          _hasMoreUpComing) {
        loadMoreMovieUpComing();
      }
    });
  }

  /// Menangani infinite scroll
  Future<void> loadMoreMovieUpComing() async {
    if (_isFetching || !_hasMoreUpComing) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchUpComingMovies();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isFetching = false;
    }
  }

  /// Load awal saat widget pertama kali dibuka
  Future<void> loadMovies() async {
    _state = RequestState.loading;
    log('Load Movies _upComingMoviesState: $_state');

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
      _upComingPage = 1;

      _hasMoreUpComing = true;

      // Clear data lama
      _movies.clear();

      // Jalankan semua secara paralel
      await fetchUpComingMovies();

      refreshC.refreshCompleted(); // Beritahu UI Bahwa Refresh Completed
    } catch (e) {
      _message = e.toString();
      log('Catch onRefresh: $_message');
      refreshC.refreshFailed(); // Beritahu UI Bahwa Refresh Gagal
    }
  }

  Future<void> fetchUpComingMovies() async {
    log('Calling fetchUpComingMovies with page $_upComingPage');
    // _state = RequestState.Loading;
    // notifyListeners();

    final result = await getUpComingMovies.execute(_upComingPage);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
        log('failure fetchUpComingMovies: $_message');
      },
      (moviesData) {
        _state = RequestState.loaded;
        if (moviesData.isNotEmpty) {
          if (_upComingPage == 1) {
            _movies = moviesData; // reset di page 1
          } else {
            _movies.addAll(moviesData);
          }
          _upComingPage++;
        } else {
          _hasMoreUpComing = false;
        }

        notifyListeners();
      },
    );
  }
}
