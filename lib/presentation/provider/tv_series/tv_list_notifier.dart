import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_airing_today_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_on_the_air_tv.dart';
import 'package:flutter/cupertino.dart';

class TvListNotifier extends ChangeNotifier {
  var _airingTodayTvSeries = <TvSeries>[];

  List<TvSeries> get airingTodayTvSeries => _airingTodayTvSeries;

  var _onTheAirTvSeries = <TvSeries>[];
  List<TvSeries> get onTheAirTvSeries => _onTheAirTvSeries;

  RequestState _airingTodayState = RequestState.Empty;

  RequestState get airingTodayState => _airingTodayState;

  RequestState _onTheAirState = RequestState.Empty;

  RequestState get onTheAirState => _onTheAirState;

  String _message = '';

  String get message => _message;

  final GetAiringTodayTv getAiringTodayTv;
  final GetOnTheAirTv getOnTheAirTv;

  TvListNotifier({required this.getAiringTodayTv, required this.getOnTheAirTv});

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
}
