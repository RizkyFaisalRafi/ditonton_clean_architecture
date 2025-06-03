import 'dart:convert';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../json_reader.dart';

void main() {
  const tTvModel = TvModel(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ["DE"],
    originalLanguage: 'Original Language',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: 'Poster Path',
    firstAirDate: '2025-01-01',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('TvResponse', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // arrange
        final jsonMap = json.decode(readJson('dummy_data/airing_today.json'));

        // act
        final result = TvResponse.fromJson(jsonMap);

        // assert
        expect(result, tTvResponseModel);
      });

      test('should filter out TV shows with null posterPath', () {
        // arrange
        final jsonMap = {
          "results": [
            {
              "adult": false,
              "backdrop_path": "/path.jpg",
              "genre_ids": [1, 2, 3],
              "id": 1,
              "origin_country": ["DE"],
              "original_language": "Original Language",
              "original_name": "Original Name",
              "overview": "Overview",
              "popularity": 1.0,
              "poster_path": null, // Null posterPath
              "first_air_date": "2023-01-01",
              "name": "Name",
              "vote_average": 8.5,
              "vote_count": 100,
            },
            {
              "adult": false,
              "backdrop_path": "/path2.jpg",
              "genre_ids": [1, 2, 3],
              "id": 2,
              "origin_country": ["US"],
              "original_language": "en",
              "original_name": "Original Name 2",
              "overview": "Overview 2",
              "popularity": 1.0,
              "poster_path": "/poster2.jpg", // Valid posterPath
              "first_air_date": "2023-01-02",
              "name": "Name 2",
              "vote_average": 8.5,
              "vote_count": 100,
            },
          ],
        };

        // act
        final result = TvResponse.fromJson(jsonMap);

        // assert
        expect(result.tvList.length, 1);
        expect(result.tvList[0].id, 2);
      });

      test('should return empty list when results is empty', () {
        // arrange
        final jsonMap = {"results": []};

        // act
        final result = TvResponse.fromJson(jsonMap);

        // assert
        expect(result.tvList, isEmpty);
      });

      test('should throw when results field is missing', () {
        // arrange
        final Map<String, dynamic> jsonMap = {};

        // act & assert
        expect(() => TvResponse.fromJson(jsonMap), throwsA(isA<TypeError>()));
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // act
        final result = tTvResponseModel.toJson();

        // assert
        final expectedJsonMap = {
          "results": [
            {
              "adult": false,
              "backdrop_path": "/path.jpg",
              "genre_ids": [1, 2, 3],
              "id": 1,
              "origin_country": ["DE"],
              "original_language": "Original Language",
              "original_name": "Original Name",
              "overview": "Overview",
              "popularity": 1.0,
              "poster_path": "Poster Path",
              "first_air_date": "2025-01-01",
              "name": "Name",
              "vote_average": 1.0,
              "vote_count": 1,
            },
          ],
        };
        expect(result, expectedJsonMap);
      });

      test('should return empty results array when tvList is empty', () {
        // arrange
        const emptyResponse = TvResponse(tvList: []);

        // act
        final result = emptyResponse.toJson();

        // assert
        expect(result, {"results": []});
      });
    });

    group('Equatable', () {
      test('props should contain tvList', () {
        // arrange
        const props = [
          [tTvModel],
        ];

        // assert
        expect(tTvResponseModel.props, equals(props));
      });

      test('should be equal when tvList is same', () {
        // arrange
        const sameResponse = TvResponse(tvList: [tTvModel]);

        // assert
        expect(tTvResponseModel, equals(sameResponse));
      });

      test('should not be equal when tvList is different', () {
        // arrange
        const differentTv = TvModel(
          adult: false,
          backdropPath: "/different.jpg",
          genreIds: [1, 2, 3],
          id: 2,
          originCountry: ["US"],
          originalLanguage: "en",
          originalName: "Different Name",
          overview: "Different Overview",
          popularity: 1.0,
          posterPath: "/different.jpg",
          firstAirDate: "2023-01-02",
          name: "Different Name",
          voteAverage: 8.5,
          voteCount: 100,
        );
        const differentResponse = TvResponse(tvList: [differentTv]);

        // assert
        expect(tTvResponseModel, isNot(equals(differentResponse)));
      });
    });
  });
}
