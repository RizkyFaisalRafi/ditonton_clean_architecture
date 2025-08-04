import 'dart:developer';
import '../../domain/entities/tv_detail.dart';
import '../../domain/usecases/get_tv_recommendations.dart';
import '../../domain/usecases/save_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_watchlist_status_tv.dart';
import '../../domain/usecases/remove_watchlist_tv.dart';
import 'package:core/module/core.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getTvRecommendations,
  });

  TvDetail? _tvDetail;

  TvDetail? get tvDetail => _tvDetail;

  RequestState _tvState = RequestState.empty;

  RequestState get tvState => _tvState;

  List<TvSeries> _tvRecommendations = [];

  List<TvSeries> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  bool _isAddedtoWatchlist = false;

  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _recommendationState = RequestState.loading;
        _tvDetail = tvSeries;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (tvRecommendations) {
            _recommendationState = RequestState.loaded;
            _tvRecommendations = tvRecommendations;
          },
        );

        _tvState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tvDetail) async {
    final result = await saveWatchlist.execute(tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
        log('Failure addWatchlist $_watchlistMessage');
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
        log('Success addWatchlist $_watchlistMessage');
      },
    );

    await loadWatchlistStatus(tvDetail.id!);
  }

  Future<void> removeFromWatchlist(TvDetail tvDetail) async {
    final result = await removeWatchlist.execute(tvDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
        log('Failure removeFromWatchlist $_watchlistMessage');
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
        log('Success removeFromWatchlist $_watchlistMessage');
      },
    );

    await loadWatchlistStatus(tvDetail.id!);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);

    result.fold(
      (failure) {
        // fallback jika gagal
        _isAddedtoWatchlist = false;
      },
      (isAdded) {
        _isAddedtoWatchlist = isAdded;
      },
    );

    // _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
