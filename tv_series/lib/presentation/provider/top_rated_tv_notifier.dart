import 'dart:developer';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:core/module/core.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvSeries> _tvSeriesList = [];

  List<TvSeries> get tvSeriesList => _tvSeriesList;

  String _message = '';

  String get message => _message;

  RefreshController refreshC = RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();

  int _topRatedPage = 1; // Halaman saat ini

  // Indikator apakah masih ada data yang bisa dimuat
  bool _hasMoreTopRated = true;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  TopRatedTvNotifier({required this.getTopRatedTv}) {
    _init();
  }

  /// Inisialisasi saat objek dibuat
  void _init() {
    loadTvSeries(); // Load awal semua movie

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent &&
          !_isFetching &&
          _hasMoreTopRated) {
        loadMoreTvTopRated();
      }
    });
  }

  /// Menangani infinite scroll
  Future<void> loadMoreTvTopRated() async {
    if (_isFetching || !_hasMoreTopRated) return;
    _isFetching = true;

    try {
      // Tambahkan data baru
      await fetchTvSeriesTopRated();
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
      _topRatedPage = 1;

      _hasMoreTopRated = true;

      // Clear data lama
      _tvSeriesList.clear();

      await fetchTvSeriesTopRated();

      refreshC.refreshCompleted(); // Beritahu UI Bahwa Refresh Completed
    } catch (e) {
      _message = e.toString();
      log('Catch onRefresh: $_message');
      refreshC.refreshFailed(); // Beritahu UI Bahwa Refresh Gagal
    }
  }

  /// Fetch On The Air
  Future<void> fetchTvSeriesTopRated() async {

    final result = await getTopRatedTv.execute(_topRatedPage);
    result.fold(
          (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvSeriesData) {
        _state = RequestState.Loaded;
        log('fetchTvSeriesTopRated State: $_state');

        if (tvSeriesData.isNotEmpty) {
          if (_topRatedPage == 1) {
            _tvSeriesList = tvSeriesData; // reset di page 1
          } else {
            _tvSeriesList.addAll(tvSeriesData);
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
