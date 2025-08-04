import 'dart:developer';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_airing_today_tv.dart';
import '../../domain/usecases/get_on_the_air_tv.dart';
import '../../domain/usecases/get_popular_tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:core/module/core.dart';

class TvListNotifier extends ChangeNotifier {
  var _airingTodayTvSeries = <TvSeries>[];
  List<TvSeries> get airingTodayTvSeries => _airingTodayTvSeries;
  set airingTodayTvSeries(List<TvSeries> value) {
    _airingTodayTvSeries = value;
    notifyListeners();
  }

  var _onTheAirTvSeries = <TvSeries>[];

  List<TvSeries> get onTheAirTvSeries => _onTheAirTvSeries;

  var _popularTvSeries = <TvSeries>[];

  List<TvSeries> get popularTvSeries => _popularTvSeries;

  var _topRatedTvSeries = <TvSeries>[];

  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _airingTodayState = RequestState.empty;

  RequestState get airingTodayState => _airingTodayState;

  RequestState _onTheAirState = RequestState.empty;

  RequestState get onTheAirState => _onTheAirState;

  RequestState _popularTvState = RequestState.empty;

  RequestState get popularTvState => _popularTvState;

  RequestState _topRatedTvState = RequestState.empty;

  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';

  String get message => _message;

  RefreshController refreshC = RefreshController(initialRefresh: false);

  final ScrollController airingTodayController = ScrollController();
  final ScrollController onTheAirController = ScrollController();
  final ScrollController popularController = ScrollController();
  final ScrollController topRatedController = ScrollController();

  int _airingTodayPage = 1;
  int get airingTodayPage => _airingTodayPage;
  set airingTodayPage(int value) {
    _airingTodayPage = value;
    notifyListeners();
  }

  int _onTheAirPage = 1;
  int _popularPage = 1;
  int _topRatedPage = 1;

  // Indikator apakah masih ada data yang bisa dimuat
  bool _hasMoreAiringToday = true;
  bool _hasMoreOnTheAir = true;
  bool _hasMorePopular = true;
  bool _hasMoreTopRated = true;

  bool get hasMoreAiringToday => _hasMoreAiringToday;

  set hasMoreAiringToday(bool value) {
    _hasMoreAiringToday = value;
    notifyListeners();
  }

  bool _isFetching = false;

  bool get isFetching => _isFetching;
  set isFetching(bool value) {
    _isFetching = value;
    notifyListeners();
  }


  TvListNotifier({
    required this.getAiringTodayTv,
    required this.getOnTheAirTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
    bool autoInit = true,
  }) {
    if (autoInit) init(); // Jalankan init() hanya jika autoInit true
    // init();
  }

  final GetAiringTodayTv getAiringTodayTv;
  final GetOnTheAirTv getOnTheAirTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  /// Inisialisasi saat objek dibuat
  void init() {
    loadTvSeries(); // Load awal semua movie

    airingTodayController.addListener(() {
      if (airingTodayController.position.pixels >=
              airingTodayController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreAiringToday) {
        loadMoreTvAiringToday(); // Trigger loadMore ketika scroll mencapai ujung
      }
    });

    onTheAirController.addListener(() {
      if (onTheAirController.position.pixels >=
              onTheAirController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreOnTheAir) {
        loadMoreTvOnTheAir();
      }
    });

    popularController.addListener(() {
      if (popularController.position.pixels >=
              popularController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMorePopular) {
        loadMoreTvPopular();
      }
    });

    topRatedController.addListener(() {
      if (topRatedController.position.pixels >=
              topRatedController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreTopRated) {
        loadMoreTvTopRated();
      }
    });
  }

  /// Load awal saat widget pertama kali dibuka
  Future<void> loadTvSeries() async {
    _airingTodayState = RequestState.loading;
    _onTheAirState = RequestState.loading;
    _popularTvState = RequestState.loading;
    _topRatedTvState = RequestState.loading;
    log('Load Movies _airingTodayState: $_airingTodayState');
    log('Load Movies _onTheAirState: $_onTheAirState');
    log('Load Movies _popularTvState: $_popularTvState');
    log('Load Movies _topRatedTvState: $_topRatedTvState');

    notifyListeners();
    try {
      await onRefresh(); // Pakai fungsi refresh
    } catch (e) {
      // Jika gagal, tampilkan error
      _airingTodayState = RequestState.error;
      _onTheAirState = RequestState.error;
      _popularTvState = RequestState.error;
      _topRatedTvState = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  /// Menangani infinite scroll
  Future<void> loadMoreTvAiringToday() async {
    if (_isFetching || !_hasMoreAiringToday) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchTvSeriesAiringToday();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isFetching = false;
    }
  }

  /// Menangani infinite scroll
  Future<void> loadMoreTvOnTheAir() async {
    if (_isFetching || !_hasMoreOnTheAir) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchTvSeriesOnTheAir();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isFetching = false;
    }
  }

  /// Menangani infinite scroll
  Future<void> loadMoreTvPopular() async {
    if (_isFetching || !_hasMorePopular) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchTvSeriesPopularTv();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isFetching = false;
    }
  }

  /// Menangani infinite scroll
  Future<void> loadMoreTvTopRated() async {
    if (_isFetching || !_hasMoreTopRated) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchTvSeriesTopRatedTv();
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
      _airingTodayPage = 1;
      _onTheAirPage = 1;
      _popularPage = 1;
      _topRatedPage = 1;

      _hasMoreAiringToday = true;
      _hasMoreOnTheAir = true;
      _hasMorePopular = true;
      _hasMoreTopRated = true;

      // Clear data lama
      _airingTodayTvSeries.clear();
      _onTheAirTvSeries.clear();
      _popularTvSeries.clear();
      _topRatedTvSeries.clear();

      // Set loading state
      _airingTodayState = RequestState.loading;
      _onTheAirState = RequestState.loading;
      _popularTvState = RequestState.loading;
      _topRatedTvState = RequestState.loading;
      notifyListeners();

      // Jalankan semua secara paralel
      await Future.wait([
        fetchTvSeriesAiringToday(),
        fetchTvSeriesOnTheAir(),
        fetchTvSeriesPopularTv(),
        fetchTvSeriesTopRatedTv(),
      ]);

      refreshC.refreshCompleted(); // Beritahu UI Bahwa Refresh Completed
    } catch (e) {
      _message = e.toString();
      log('Catch onRefresh: $_message');
      refreshC.refreshFailed(); // Beritahu UI Bahwa Refresh Gagal
    }
  }

  /// Fetch Airing Today
  Future<void> fetchTvSeriesAiringToday() async {
    // _airingTodayState = RequestState.Loading;
    // notifyListeners();

    final result = await getAiringTodayTv.execute(_airingTodayPage);
    result.fold(
      (failure) {
        _airingTodayState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _airingTodayState = RequestState.loaded;
        // _airingTodayTvSeries = tvSeriesData;

        if (tvSeriesData.isNotEmpty) {
          _airingTodayTvSeries.addAll(tvSeriesData);
          _airingTodayPage++;
        } else {
          _hasMoreAiringToday = false;
          _airingTodayState = RequestState.empty;
        }

        // if (tvSeriesData.isNotEmpty) {
        //   if (_airingTodayPage == 1) {
        //     _airingTodayTvSeries = tvSeriesData; // reset di page 1
        //   } else {
        //     _airingTodayTvSeries.addAll(tvSeriesData);
        //   }
        //   _airingTodayPage++;
        // } else {
        //   _hasMoreAiringToday = false;
        // }

        notifyListeners();
      },
    );
  }

  /// Fetch On The Air
  Future<void> fetchTvSeriesOnTheAir() async {
    // _onTheAirState = RequestState.Loading;
    // notifyListeners();

    final result = await getOnTheAirTv.execute(_onTheAirPage);
    result.fold(
      (failure) {
        _onTheAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _onTheAirState = RequestState.loaded;
        // _onTheAirTvSeries = tvSeriesData;
        if (tvSeriesData.isNotEmpty) {
          if (_onTheAirPage == 1) {
            _onTheAirTvSeries = tvSeriesData; // reset di page 1
          } else {
            _onTheAirTvSeries.addAll(tvSeriesData);
          }
          _onTheAirPage++;
        } else {
          _hasMoreOnTheAir = false;
        }

        notifyListeners();
      },
    );
  }

  /// Fetch Popular Tv
  Future<void> fetchTvSeriesPopularTv() async {
    // _popularTvState = RequestState.Loading;
    // notifyListeners();

    final result = await getPopularTv.execute(_popularPage);
    result.fold(
      (failure) {
        _popularTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularTvState = RequestState.loaded;
        // _popularTvSeries = tvSeriesData;

        if (tvSeriesData.isNotEmpty) {
          if (_popularPage == 1) {
            _popularTvSeries = tvSeriesData; // reset di page 1
          } else {
            _popularTvSeries.addAll(tvSeriesData);
          }
          _popularPage++;
        } else {
          _hasMorePopular = false;
        }

        notifyListeners();
      },
    );
  }

  /// Fetch Top Rated Tv
  Future<void> fetchTvSeriesTopRatedTv() async {
    // _topRatedTvState = RequestState.Loading;
    // notifyListeners();

    final result = await getTopRatedTv.execute(_topRatedPage);
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedTvState = RequestState.loaded;
        // _topRatedTvSeries = tvSeriesData;

        if (tvSeriesData.isNotEmpty) {
          if (_topRatedPage == 1) {
            _topRatedTvSeries = tvSeriesData; // reset di page 1
          } else {
            _topRatedTvSeries.addAll(tvSeriesData);
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
