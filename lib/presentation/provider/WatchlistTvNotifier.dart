import 'package:ditonton_clean_architecture/domain/entities/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTv = <TvSeries>[];

  List<TvSeries> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.Empty;

  RequestState get watchlistState => _watchlistState;

  String _message = '';

  String get message => _message;

  final GetWatchlistTv getWatchlistTv;

  WatchlistTvNotifier({required this.getWatchlistTv});

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTv = moviesData;
        notifyListeners();
      },
    );
  }
}
