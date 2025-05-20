import 'dart:convert';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_detail_model.dart';

import '../../../common/exception.dart';
import '../../models/tv_series/tv_model.dart';
import 'package:http/http.dart' as http;
import '../../models/tv_series/tv_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvModel>> getAiringToday();

  Future<TvDetailResponse> getTvDetail(int id);

  Future<List<TvModel>> getTvRecommendations(int id);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getAiringToday() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
