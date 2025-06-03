import 'dart:convert';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_remote_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_detail_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_response.dart';
import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  // Helper function to test movie list endpoints
  void testMovieListEndpoint(
    String description,
    Future<List<MovieModel>> Function() methodUnderTest,
    String endpointPath,
    String jsonFile,
  ) {
    group(description, () {
      final tMovieList =
          MovieResponse.fromJson(json.decode(readJson(jsonFile))).movieList;

      test('should return list of movies when response code is 200', () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$BASE_URL$endpointPath?$API_KEY')),
        ).thenAnswer((_) async => http.Response(readJson(jsonFile), 200));
        // act
        final result = await methodUnderTest();
        // assert
        expect(result, equals(tMovieList));
        verify(
          mockHttpClient.get(Uri.parse('$BASE_URL$endpointPath?$API_KEY')),
        );
      });

      test(
        'should throw ServerException when response code is not 200',
        () async {
          // arrange
          when(
            mockHttpClient.get(Uri.parse('$BASE_URL$endpointPath?$API_KEY')),
          ).thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = methodUnderTest();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
          verify(
            mockHttpClient.get(Uri.parse('$BASE_URL$endpointPath?$API_KEY')),
          );
        },
      );

      test('should throw ServerException on network error', () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$BASE_URL$endpointPath?$API_KEY')),
        ).thenThrow(http.ClientException('Network Error'));
        // act
        final call = methodUnderTest();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });

      test('should throw ServerException on malformed JSON', () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$BASE_URL$endpointPath?$API_KEY')),
        ).thenAnswer((_) async => http.Response('{"invalid": "json"', 200));
        // act
        final call = methodUnderTest();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  }

  // Test all movie list endpoints using the helper
  testMovieListEndpoint(
    'get Now Playing Movies',
    () => dataSource.getNowPlayingMovies(),
    '/movie/now_playing',
    'dummy_data/now_playing.json',
  );

  testMovieListEndpoint(
    'get Popular Movies',
    () => dataSource.getPopularMovies(),
    '/movie/popular',
    'dummy_data/popular.json',
  );

  testMovieListEndpoint(
    'get Top Rated Movies',
    () => dataSource.getTopRatedMovies(),
    '/movie/top_rated',
    'dummy_data/top_rated.json',
  );

  testMovieListEndpoint(
    'get Upcoming Movies',
    () => dataSource.getUpComingMovies(),
    '/movie/upcoming',
    'dummy_data/upcoming.json',
  );

  group('get movie detail', () {
    const tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
      json.decode(readJson('dummy_data/movie_detail.json')),
    );

    test('should return movie detail when response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/movie_detail.json'), 200),
      );
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
      verify(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')));
    });

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getMovieDetail(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
        verify(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')));
      },
    );

    test('should throw ServerException on network error', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')),
      ).thenThrow(http.ClientException('Network Error'));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test('should throw ServerException on malformed JSON', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')),
      ).thenAnswer((_) async => http.Response('{"invalid": "json"}', 200));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    const tId = 1;
    final tMovieList =
        MovieResponse.fromJson(
          json.decode(readJson('dummy_data/movie_recommendations.json')),
        ).movieList;

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/movie_recommendations.json'),
          200,
        ),
      );
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
      verify(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY'),
        ),
      );
    });

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY'),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getMovieRecommendations(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );

    test('should throw ServerException on network error', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY'),
        ),
      ).thenThrow(http.ClientException('Network Error'));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    const tQuery = 'Spiderman';
    final tSearchResult =
        MovieResponse.fromJson(
          json.decode(readJson('dummy_data/search_spiderman_movie.json')),
        ).movieList;

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/search_spiderman_movie.json'),
          200,
        ),
      );
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
      verify(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery'),
        ),
      );
    });

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery'),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.searchMovies(tQuery);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );

    test('should throw ServerException on empty query', () async {
      // act
      final call = dataSource.searchMovies('');
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test('should throw ServerException on network error', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery'),
        ),
      ).thenThrow(http.ClientException('Network Error'));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
