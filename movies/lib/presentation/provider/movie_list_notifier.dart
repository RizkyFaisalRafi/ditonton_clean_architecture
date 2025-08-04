import 'dart:developer';
import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../module/movies.dart';

class MovieListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  set nowPlayingMovies(List<Movie> value) {
    _nowPlayingMovies = value;
    notifyListeners();
  }

  RequestState _nowPlayingState = RequestState.empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];

  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.empty;

  RequestState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];

  var _upComingMovies = <Movie>[];

  List<Movie> get topRatedMovies => _topRatedMovies;

  List<Movie> get upComingMovies => _upComingMovies;

  RequestState _topRatedMoviesState = RequestState.empty;

  RequestState get topRatedMoviesState => _topRatedMoviesState;

  RequestState _upComingMoviesState = RequestState.empty;

  RequestState get upComingMoviesState => _upComingMoviesState;

  String _message = '';

  String get message => _message;

  RefreshController refreshC = RefreshController(initialRefresh: false);

  final ScrollController nowPlayingController = ScrollController();
  final ScrollController popularController = ScrollController();
  final ScrollController topRatedController = ScrollController();
  final ScrollController upComingController = ScrollController();

  int _nowPlayingPage = 1;

  int get nowPlayingPage => _nowPlayingPage;

  set nowPlayingPage(int value) {
    _nowPlayingPage = value;
    notifyListeners();
  }

  int _popularPage = 1;
  int _topRatedPage = 1;
  int _upComingPage = 1;

  // Indikator apakah masih ada data yang bisa dimuat
  bool _hasMoreNowPlaying = true;
  bool _hasMorePopular = true;
  bool _hasMoreTopRated = true;
  bool _hasMoreUpComing = true;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }

  MovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getUpComingMovies,
    bool autoInit = true,
  }) {
    if (autoInit) _init();
    // _init();
  }

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetUpComingMovies getUpComingMovies;

  /// Inisialisasi saat objek dibuat
  void _init() {
    loadMovies(); // Load awal semua movie

    nowPlayingController.addListener(() {
      if (nowPlayingController.position.pixels >=
              nowPlayingController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreNowPlaying) {
        loadMoreMovieNowPlaying(); // Trigger loadMore ketika scroll mencapai ujung
      }
    });

    popularController.addListener(() {
      if (popularController.position.pixels >=
              popularController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMorePopular) {
        loadMoreMoviePopular();
      }
    });

    topRatedController.addListener(() {
      if (topRatedController.position.pixels >=
              topRatedController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreTopRated) {
        loadMoreMovieTopRated();
      }
    });

    upComingController.addListener(() {
      if (upComingController.position.pixels >=
              upComingController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreUpComing) {
        loadMoreMovieUpComing();
      }
    });
  }

  /// Load awal saat widget pertama kali dibuka
  Future<void> loadMovies() async {
    _nowPlayingState = RequestState.loading;
    _popularMoviesState = RequestState.loading;
    _topRatedMoviesState = RequestState.loading;
    _upComingMoviesState = RequestState.loading;
    log('Load Movies _nowPlayingState: $_nowPlayingState');
    log('Load Movies _popularMoviesState: $_popularMoviesState');
    log('Load Movies _topRatedMoviesState: $_topRatedMoviesState');
    log('Load Movies _upComingMoviesState: $_upComingMoviesState');

    notifyListeners();
    try {
      await onRefresh(); // Pakai fungsi refresh
    } catch (e) {
      // Jika gagal, tampilkan error
      _nowPlayingState = RequestState.error;
      _popularMoviesState = RequestState.error;
      _topRatedMoviesState = RequestState.error;
      _upComingMoviesState = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  /// Menangani infinite scroll
  Future<void> loadMoreMovieNowPlaying() async {
    if (_isFetching || !_hasMoreNowPlaying) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchNowPlayingMovies();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isFetching = false;
    }
  }

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

  // Handle Refresh
  Future<void> onRefresh() async {
    log('Calling onRefresh (clears list)');
    try {
      _nowPlayingPage = 1;
      _popularPage = 1;
      _topRatedPage = 1;
      _upComingPage = 1;

      _hasMoreNowPlaying = true;
      _hasMorePopular = true;
      _hasMoreTopRated = true;
      _hasMoreUpComing = true;

      // Clear data lama
      _nowPlayingMovies.clear();
      _popularMovies.clear();
      _topRatedMovies.clear();
      _upComingMovies.clear();

      // Set loading state
      _nowPlayingState = RequestState.loading;
      _popularMoviesState = RequestState.loading;
      _topRatedMoviesState = RequestState.loading;
      _upComingMoviesState = RequestState.loading;
      notifyListeners();

      // Jalankan semua secara paralel
      await Future.wait([
        fetchNowPlayingMovies(),
        fetchPopularMovies(),
        fetchTopRatedMovies(),
        fetchUpComingMovies(),
      ]);

      refreshC.refreshCompleted(); // Beritahu UI Bahwa Refresh Completed
    } catch (e) {
      _message = e.toString();
      log('Catch onRefresh: $_message');
      refreshC.refreshFailed(); // Beritahu UI Bahwa Refresh Gagal
    }
  }

  Future<void> fetchNowPlayingMovies() async {
    log('Calling fetchNowPlayingMovies with page $_nowPlayingPage');
    // _nowPlayingState = RequestState.Loading;
    // notifyListeners();

    final result = await getNowPlayingMovies.execute(_nowPlayingPage);

    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.loaded;
        if (moviesData.isNotEmpty) {
          if (_nowPlayingPage == 1) {
            _nowPlayingMovies = moviesData; // reset di page 1
          } else {
            _nowPlayingMovies.addAll(moviesData);
          }
          _nowPlayingPage++;
        } else {
          _hasMoreNowPlaying = false;
        }

        // _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    log('Calling fetchPopularMovies with page $_popularPage');
    // _popularMoviesState = RequestState.Loading;
    // notifyListeners();

    final result = await getPopularMovies.execute(_popularPage);
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.loaded;
        if (moviesData.isNotEmpty) {
          if (_popularPage == 1) {
            _popularMovies = moviesData; // reset di page 1
          } else {
            _popularMovies.addAll(moviesData);
          }
          _popularPage++;
        } else {
          _hasMorePopular = false;
        }

        // _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    log('Calling fetchTopRatedMovies with page $_topRatedPage');
    // _topRatedMoviesState = RequestState.Loading;
    // notifyListeners();

    final result = await getTopRatedMovies.execute(_topRatedPage);
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.loaded;

        if (moviesData.isNotEmpty) {
          if (_topRatedPage == 1) {
            _topRatedMovies = moviesData; // reset di page 1
          } else {
            _topRatedMovies.addAll(moviesData);
          }
          _topRatedPage++;
        } else {
          _hasMoreTopRated = false;
        }

        // _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchUpComingMovies() async {
    log('Calling fetchUpComingMovies with page $_upComingPage');
    // _upComingMoviesState = RequestState.Loading;
    // notifyListeners();

    final result = await getUpComingMovies.execute(_upComingPage);
    result.fold(
      (failure) {
        _upComingMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _upComingMoviesState = RequestState.loaded;

        if (moviesData.isNotEmpty) {
          if (_upComingPage == 1) {
            _upComingMovies = moviesData; // reset di page 1
          } else {
            _upComingMovies.addAll(moviesData);
          }
          _upComingPage++;
        } else {
          _hasMoreUpComing = false;
        }

        // _upComingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    log('Movie List Notifier disposed');
    refreshC.dispose();
    nowPlayingController.dispose();
    popularController.dispose();
    topRatedController.dispose();
    upComingController.dispose();
    super.dispose();
  }
}
