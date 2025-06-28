import 'dart:developer';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_popular_tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:core/module/core.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTv getPopularTv;

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvSeries> _tvSeriesList = [];

  List<TvSeries> get tvSeriesList => _tvSeriesList;

  String _message = '';

  String get message => _message;

  RefreshController refreshC = RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();

  int _popularPage = 1; // Halaman saat ini

  // Indikator apakah masih ada data yang bisa dimuat
  bool _hasMorePopular = true;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  PopularTvNotifier({required this.getPopularTv}) {
    _init();
  }

  /// Inisialisasi saat objek dibuat
  void _init() {
    loadTvSeries(); // Load awal semua movie

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMorePopular) {
        loadMoreTvPopular();
      }
    });
  }

  /// Menangani infinite scroll
  Future<void> loadMoreTvPopular() async {
    if (_isFetching || !_hasMorePopular) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchTvSeriesPopular();
    } catch (e) {
      _message = e.toString();
    } finally {
      _isFetching = false;
    }
  }

  /// Load awal saat widget pertama kali dibuka
  Future<void> loadTvSeries() async {
    _state = RequestState.Loading;
    log('Load Tv Series State: $_state');

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

  // Handle Refresh
  Future<void> onRefresh() async {
    log('Calling onRefresh (clears list)');
    try {
      _popularPage = 1;

      _hasMorePopular = true;

      // Clear data lama
      _tvSeriesList.clear();

      await fetchTvSeriesPopular();

      refreshC.refreshCompleted(); // Beritahu UI Bahwa Refresh Completed
    } catch (e) {
      _message = e.toString();
      log('Catch onRefresh: $_message');
      refreshC.refreshFailed(); // Beritahu UI Bahwa Refresh Gagal
    }
  }

  /// Fetch On The Air
  Future<void> fetchTvSeriesPopular() async {
    // _onTheAirState = RequestState.Loading;
    // notifyListeners();

    final result = await getPopularTv.execute(_popularPage);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _state = RequestState.Loaded;
        log('fetchTvSeriesPopular State: $_state');

        if (tvSeriesData.isNotEmpty) {
          if (_popularPage == 1) {
            _tvSeriesList = tvSeriesData; // reset di page 1
          } else {
            _tvSeriesList.addAll(tvSeriesData);
          }
          _popularPage++;
        } else {
          _hasMorePopular = false;
        }

        notifyListeners();
      },
    );
  }
}
