import 'dart:developer';

import 'package:ditonton_clean_architecture/domain/entities/tv/created_by.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:flutter/cupertino.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';
import '../../domain/usecases/tv_series/get_tv_detail.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  List<TvSeries> _tvRecommendations = [];

  List<TvSeries> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;

  RequestState get recommendationState => _recommendationState;

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getTvRecommendations,
  });

  late TvDetail _tv_detail;

  TvDetail get tv_detail => _tv_detail;

  RequestState _tvState = RequestState.Empty;

  RequestState get tvState => _tvState;

  List<CreatedBy> _createdBy = [];

  List<CreatedBy> get createdBy => _createdBy;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;

    notifyListeners();

    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _recommendationState = RequestState.Loading;
        _tv_detail = tvSeries;
        notifyListeners();
        // Cek Log
        log(tvSeries.lastEpisodeToAir.toString());
        log(tvSeries.backdropPath.toString());
        log(tvSeries.id.toString());
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvRecommendations) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tvRecommendations;
          },
        );

        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
