import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movies/module/movies.dart';
import 'package:core/module/core.dart';
import '../../../core/test/json_reader.dart';

// Daftarkan kelas yang ingin di-mock
@GenerateMocks(
  [
    DatabaseHelper,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    NetworkInfo,
    MovieRepository,
    GetMovieDetail,
    GetMovieRecommendations,
    GetWatchListStatus,
    SaveWatchlist,
    RemoveWatchlist,
    GetNowPlayingMovies,
    GetTopRatedMovies,
    SearchMovies,
    GetPopularMovies,
    GetUpComingMovies,
    GetWatchlistMovies,
    MovieListBloc,
    NavigatorObserver,
    MovieDetailBloc,
    SeeMorePopularMovieBloc,
    MovieSearchBloc,
    SeeMoreTopRatedMovieBloc,
    SeeMoreUpcomingMovieBloc,
    WatchlistMovieBloc,
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