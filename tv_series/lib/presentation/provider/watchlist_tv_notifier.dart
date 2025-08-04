import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_watchlist_tv.dart';
import 'package:flutter/material.dart';
import 'package:core/module/core.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTv = <TvSeries>[];

  List<TvSeries> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  final GetWatchlistTv getWatchlistTv;

  WatchlistTvNotifier({required this.getWatchlistTv});

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.loaded;
        _watchlistTv = moviesData;
        notifyListeners();
      },
    );
  }
}
