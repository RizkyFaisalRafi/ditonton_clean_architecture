import 'dart:convert';
import 'package:core/module/core.dart';
import 'package:http/http.dart' as http;
import '../../module/tv_series.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvModel>> getAiringToday({required int page});

  Future<List<TvModel>> getOnTheAir({required int page});

  Future<List<TvModel>> getPopularTv({required int page});

  Future<List<TvModel>> getTopRatedTv({required int page});

  Future<TvDetailResponse> getTvDetail(int id);

  Future<List<TvModel>> getTvRecommendations(int id);

  Future<List<TvModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getAiringToday({
    int page = 1, // Default value
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/tv/airing_today?$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body)).tvList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getOnTheAir({
    int page = 1, // Default value
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/tv/on_the_air?$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body)).tvList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTv({
    int page = 1, // Default value
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/tv/popular?$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        return TvResponse.fromJson(jsonDecode(response.body)).tvList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv({
    int page = 1, // Default value
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/tv/top_rated?$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        return TvResponse.fromJson(jsonDecode(response.body)).tvList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final url = Uri.parse('$baseUrl/tv/$id?$apiKey');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        return TvDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'),
      );

      if (response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body)).tvList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvSeries(String query) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'),
      );

      if (response.statusCode == 200) {
        return TvResponse.fromJson(json.decode(response.body)).tvList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
