import 'dart:developer';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_on_the_air_tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:core/module/core.dart';

class OnTheAirNotifier extends ChangeNotifier {
  final GetOnTheAirTv getOnTheAirTv;

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<TvSeries> _tvSeriesList = [];

  List<TvSeries> get tvSeriesList => _tvSeriesList;

  String _message = '';

  String get message => _message;

  RefreshController refreshC = RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();

  int _onTheAirPage = 1; // Halaman saat ini

  // Indikator apakah masih ada data yang bisa dimuat
  bool _hasMoreOnTheAir = true;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  OnTheAirNotifier({required this.getOnTheAirTv}) {
    _init();
  }

  /// Inisialisasi saat objek dibuat
  void _init() {
    loadTvSeries(); // Load awal semua movie

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreOnTheAir) {
        loadMoreTvOnTheAir();
      }
    });
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

  /// Load awal saat widget pertama kali dibuka
  Future<void> loadTvSeries() async {
    _state = RequestState.loading;
    log('Load Tv Series State: $_state');

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
      _onTheAirPage = 1;

      _hasMoreOnTheAir = true;

      // Clear data lama
      _tvSeriesList.clear();

      // Jalankan semua secara paralel
      await fetchTvSeriesOnTheAir();

      refreshC.refreshCompleted(); // Beritahu UI Bahwa Refresh Completed
    } catch (e) {
      _message = e.toString();
      log('Catch onRefresh: $_message');
      refreshC.refreshFailed(); // Beritahu UI Bahwa Refresh Gagal
    }
  }

  /// Fetch On The Air
  Future<void> fetchTvSeriesOnTheAir() async {
    // _onTheAirState = RequestState.Loading;
    // notifyListeners();

    final result = await getOnTheAirTv.execute(_onTheAirPage);
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _state = RequestState.loaded;
        log('fetchTvSeriesOnTheAir State: $_state');

        if (tvSeriesData.isNotEmpty) {
          if (_onTheAirPage == 1) {
            _tvSeriesList = tvSeriesData; // reset di page 1
          } else {
            _tvSeriesList.addAll(tvSeriesData);
          }
          _onTheAirPage++;
        } else {
          _hasMoreOnTheAir = false;
        }

        notifyListeners();
      },
    );
  }
}
