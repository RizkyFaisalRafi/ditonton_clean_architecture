import 'dart:convert';

import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_detail_model.dart';
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

  group('Get Airing Today Tv Series', () {
    final tTvSeriesList =
        TvResponse.fromJson(
          json.decode(readJson('dummy_data/airing_today.json')),
        ).tvList;

    test(
      'should return list of Tv Model when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')),
        ).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/airing_today.json'), 200),
        );

        // act
        final result = await dataSource.getAiringToday();

        // assert
        expect(result, equals(tTvSeriesList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getAiringToday();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get On The Air Tv Series', () {
    final tTvSeriesList =
        TvResponse.fromJson(
          json.decode(readJson('dummy_data/airing_today.json')),
        ).tvList;

    test(
      'should return list of Tv Model when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')),
        ).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/airing_today.json'), 200),
        );

        // act
        final result = await dataSource.getOnTheAir();

        // assert
        expect(result, equals(tTvSeriesList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getOnTheAir();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get Popular Tv Series', () {
    final tTvSeriesList =
        TvResponse.fromJson(
          json.decode(readJson('dummy_data/airing_today.json')),
        ).tvList;

    test(
      'should return list of TvModel when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')),
        ).thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data/airing_today.json'), 200),
        );

        // act
        final result = await dataSource.getPopularTv();

        // assert
        expect(result, equals(tTvSeriesList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getPopularTv();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get Tv Detail', () {
    final tId = 1;
    final tTvSeriesDetail = TvDetailResponse.fromJson(
      json.decode(readJson('dummy_data/tv_detail.json')),
    );

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')),
      ).thenAnswer(
        (_) async => http.Response(readJson('dummy_data/tv_detail.json'), 200),
      );
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvSeriesDetail));
    });

    test(
      'should throw Server Exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')),
        ).thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvDetail(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Get Tv Recommendations', () {
    final tTvSeriesList =
        TvResponse.fromJson(
          json.decode(readJson('dummy_data/tv_recommendations.json')),
        ).tvList;
    final tId = 1;

    test(
      'should return list of Tv Model when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_recommendations.json'),
            200,
          ),
        );
        // act
        final result = await dataSource.getTvRecommendations(tId);
        // assert
        expect(result, equals(tTvSeriesList));
      },
    );

    test(
      'should throw Server Exception when the response code is 404 or other',
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
  });

  group('search TvSeries', () {
    final tSearchResult =
        TvResponse.fromJson(
          jsonDecode(readJson('dummy_data/search_squid_game_tv.json')),
        ).tvList;
    final tQuery = 'Squid Game';
    final endpointSearch = '$baseUrl/search/tv?$apiKey&query=$tQuery';

    test('should return list of tv when response code is 200', () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse(endpointSearch))).thenAnswer((_) async {
        return mockJsonResponse('dummy_data/search_squid_game_tv.json');
      });

      // Act
      final result = await dataSource.searchTvSeries(tQuery);
      // Assert
      expect(result, tSearchResult);
    });

    test(
      'should throw ServerException when response code is other than 200',
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
  });
}
