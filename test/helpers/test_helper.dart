import 'dart:convert';

import 'package:ditonton_clean_architecture/common/network_info.dart';
import 'package:ditonton_clean_architecture/data/datasources/db/database_helper.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_remote_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:ditonton_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import '../json_reader.dart';

// Daftarkan kelas yang ingin di-mock pada sebuah fungsi main().
@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    DatabaseHelper,
    NetworkInfo,
    TvSeriesRepository,
    TvSeriesRemoteDataSource,
    TvSeriesLocalDatasource,
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
