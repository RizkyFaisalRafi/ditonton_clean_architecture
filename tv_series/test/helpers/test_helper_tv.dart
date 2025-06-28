import 'dart:convert';
import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../../core/test/json_reader.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

// Daftarkan kelas yang ingin di-mock
@GenerateMocks(
  [
    DatabaseHelper,
    TvSeriesRemoteDataSource,
    TvSeriesLocalDatasource,
    NetworkInfo,
    TvSeriesRepository,
    GetAiringTodayTv,
    GetOnTheAirTv,
    GetPopularTv,
    SearchTvSeries,
    GetTvDetail,
    GetTvRecommendations,
    GetWatchListStatusTv,
    SaveWatchlistTv,
    RemoveWatchlistTv,
    GetTopRatedTv,
    GetWatchlistTv,
    SeeMoreOnTheAirTvBloc,
    SeeMorePopularTvBloc,
    TvSearchBloc,
    SeeMoreTopRatedTvBloc,
    TvDetailBloc,
    AiringTodayTvBloc,
    OnTheAirTvBloc,
    PopularTvBloc,
    TopRatedTvBloc,
    NavigatorObserver,
    WatchlistTvBloc,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}

/// Helper untuk membuat http.Response mock dari file JSON.
http.Response mockJsonResponse(String path) {
  // Aman untuk semua karakter
  return http.Response.bytes(
    utf8.encode(readJson(path)),
    200,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}
