import 'dart:convert';

import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_detail_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.dart';
import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  // Helper function to test TV series list endpoints
  void testTvListEndpoint(
    String description,
    Future<List<TvModel>> Function() methodUnderTest,
    String endpointPath,
    String jsonFile,
  ) {
    group(description, () {
      final tTvList =
          TvResponse.fromJson(json.decode(readJson(jsonFile))).tvList;

      test(
        'should return list of TV series when response code is 200',
        () async {
          // arrange
          when(
            mockHttpClient.get(Uri.parse('$baseUrl$endpointPath?$apiKey')),
          ).thenAnswer((_) async => http.Response(readJson(jsonFile), 200));
          // act
          final result = await methodUnderTest();
          // assert
          expect(result, equals(tTvList));
          verify(
            mockHttpClient.get(Uri.parse('$baseUrl$endpointPath?$apiKey')),
          );
        },
      );

      test(
        'should throw ServerException when response code is not 200',
        () async {
          // arrange
          when(
            mockHttpClient.get(Uri.parse('$baseUrl$endpointPath?$apiKey')),
          ).thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = methodUnderTest();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
          verify(
            mockHttpClient.get(Uri.parse('$baseUrl$endpointPath?$apiKey')),
          );
        },
      );

      test('should throw ServerException on network error', () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl$endpointPath?$apiKey')),
        ).thenThrow(http.ClientException('Network Error'));
        // act
        final call = methodUnderTest();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });

      test('should throw ServerException on malformed JSON', () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl$endpointPath?$apiKey')),
        ).thenAnswer((_) async => http.Response('{"invalid": "json"}', 200));
        // act
        final call = methodUnderTest();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  }

  // Test all TV series list endpoints using the helper
  testTvListEndpoint(
    'get Airing Today TV Series',
    () => dataSource.getAiringToday(),
    '/tv/airing_today',
    'dummy_data/airing_today.json',
  );

  testTvListEndpoint(
    'get On The Air TV Series',
    () => dataSource.getOnTheAir(),
    '/tv/on_the_air',
    'dummy_data/airing_today.json', // Using same file as example
  );

  testTvListEndpoint(
    'get Popular TV Series',
    () => dataSource.getPopularTv(),
    '/tv/popular',
    'dummy_data/airing_today.json', // Using same file as example
  );

  testTvListEndpoint(
    'get Top Rated TV Series',
    () => dataSource.getTopRatedTv(),
    '/tv/top_rated',
    'dummy_data/airing_today.json', // Using same file as example
  );

  group('get TV Detail', () {
    const tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
      json.decode(readJson('dummy_data/tv_detail.json')),
    );

    test('should return TV detail when response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')),
      ).thenAnswer(
        (_) async => http.Response(readJson('dummy_data/tv_detail.json'), 200),
      );
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
      verify(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')));
    });

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvDetail(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
        verify(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')));
      },
    );

    test('should throw ServerException on network error', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')),
      ).thenThrow(http.ClientException('Network Error'));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test('should throw ServerException on malformed JSON', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')),
      ).thenAnswer((_) async => http.Response('{"invalid": "json"}', 200));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() async => await call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV Recommendations', () {
    const tId = 1;
    final tTvList =
        TvResponse.fromJson(
          json.decode(readJson('dummy_data/tv_recommendations.json')),
        ).tvList;

    test('should return list of TV series when response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'),
        ),
      ).thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/tv_recommendations.json'), 200),
      );
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
      verify(
        mockHttpClient.get(
          Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'),
        ),
      );
    });

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvRecommendations(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );

    test('should throw ServerException on network error', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'),
        ),
      ).thenThrow(http.ClientException('Network Error'));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TV Series', () {
    const tQuery = 'Squid Game';
    final tSearchResult =
        TvResponse.fromJson(
          json.decode(readJson('dummy_data/search_squid_game_tv.json')),
        ).tvList;
    final endpointSearch = '$baseUrl/search/tv?$apiKey&query=$tQuery';

    test('should return list of TV series when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(endpointSearch))).thenAnswer(
        (_) async => mockJsonResponse('dummy_data/search_squid_game_tv.json'),
      );
      // act
      final result = await dataSource.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
      verify(mockHttpClient.get(Uri.parse(endpointSearch)));
    });

    test(
      'should throw ServerException when response code is not 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse(endpointSearch)),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.searchTvSeries(tQuery);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );

    test('should throw ServerException on empty query', () async {
      // act
      final call = dataSource.searchTvSeries('');
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test('should throw ServerException on network error', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse(endpointSearch)),
      ).thenThrow(http.ClientException('Network Error'));
      // act
      final call = dataSource.searchTvSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
