import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_airing_today_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_on_the_air_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:flutter/cupertino.dart';

class TvListNotifier extends ChangeNotifier {
  var _airingTodayTvSeries = <TvSeries>[];

  List<TvSeries> get airingTodayTvSeries => _airingTodayTvSeries;

  var _onTheAirTvSeries = <TvSeries>[];

  List<TvSeries> get onTheAirTvSeries => _onTheAirTvSeries;

  var _popularTvSeries = <TvSeries>[];

  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState _airingTodayState = RequestState.Empty;

  RequestState get airingTodayState => _airingTodayState;

  RequestState _onTheAirState = RequestState.Empty;

  RequestState get onTheAirState => _onTheAirState;

  RequestState _popularTvState = RequestState.Empty;

  RequestState get popularTvState => _popularTvState;

  String _message = '';

  String get message => _message;

  final GetAiringTodayTv getAiringTodayTv;
  final GetOnTheAirTv getOnTheAirTv;
  final GetPopularTv getPopularTv;

  TvListNotifier({
    required this.getAiringTodayTv,
    required this.getOnTheAirTv,
    required this.getPopularTv,
  });

  /// Fetch Airing Today
  Future<void> fetchTvSeriesAiringToday() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTv.execute();
    result.fold(
      (failure) {
        _airingTodayState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  /// Fetch On The Air
  Future<void> fetchTvSeriesOnTheAir() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _onTheAirTvSeries = tvSeriesData;
        _onTheAirState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  /// Fetch Popular Tv
  Future<void> fetchTvSeriesPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularTvState = RequestState.Loaded;
        _popularTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
