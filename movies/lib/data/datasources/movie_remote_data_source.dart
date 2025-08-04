import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../module/movies.dart';
import 'package:core/module/core.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies({required int page});

  Future<List<MovieModel>> getPopularMovies({required int page});

  Future<List<MovieModel>> getTopRatedMovies({required int page});

  Future<List<MovieModel>> getUpComingMovies({required int page});

  Future<MovieDetailResponse> getMovieDetail(int id);

  Future<List<MovieModel>> getMovieRecommendations(int id);

  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies({
    int page = 1, // Default value
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/movie/now_playing?$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final url = Uri.parse('$baseUrl/movie/$id?$apiKey');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        return MovieDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'),
      );

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies({
    int page = 1, // Default value
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/movie/popular?$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies({
    int page = 1, // Default value
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/movie/top_rated?$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getUpComingMovies({
    int page = 1, // Default value
  }) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/movie/upcoming?$apiKey&page=$page'),
      );

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(jsonDecode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'),
      );

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
