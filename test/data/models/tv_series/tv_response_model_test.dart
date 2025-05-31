import 'dart:convert';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ["DE"],
    originalLanguage: 'Original Language',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1,
    posterPath: 'Poster Path',
    firstAirDate: 'First Air Date',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvResponseModel =
  TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

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
            "origin_country": ['DE'],
            "original_language": "Original Language",
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "Poster Path",
            "first_air_date": "First Air Date",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });

}
