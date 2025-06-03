import 'dart:convert';
import 'package:ditonton_clean_architecture/data/models/movies/movie_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../json_reader.dart';

void main() {
  var tMovieModel = MovieModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2025-05-05",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  var tMovieResponseModel = MovieResponse(movieList: <MovieModel>[tMovieModel]);

  group('MovieResponse', () {
    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // arrange
        final jsonMap = json.decode(readJson('dummy_data/now_playing.json'));

        // act
        final result = MovieResponse.fromJson(jsonMap);

        // assert
        expect(result, tMovieResponseModel);
      });

      test('should filter out movies with null posterPath', () {
        // arrange
        final jsonMap = {
          "results": [
            {
              "adult": false,
              "backdrop_path": "/path.jpg",
              "genre_ids": [1, 2, 3, 4],
              "id": 1,
              "original_title": "Original Title",
              "overview": "Overview",
              "popularity": 1.0,
              "poster_path": null, // Null posterPath
              "release_date": "2025-05-05",
              "title": "Title",
              "video": false,
              "vote_average": 1.0,
              "vote_count": 1,
            },
            {
              "adult": false,
              "backdrop_path": "/path.jpg",
              "genre_ids": [1, 2, 3, 4],
              "id": 2,
              "original_title": "Original Title 2",
              "overview": "Overview 2",
              "popularity": 1.0,
              "poster_path": "/path2.jpg", // Valid posterPath
              "release_date": "2025-05-05",
              "title": "Title 2",
              "video": false,
              "vote_average": 1.0,
              "vote_count": 1,
            },
          ],
        };

        // act
        final result = MovieResponse.fromJson(jsonMap);

        // assert
        expect(result.movieList.length, 1);
        expect(result.movieList[0].id, 2);
      });

      test('should return empty list when results is empty', () {
        // arrange
        final jsonMap = {"results": []};

        // act
        final result = MovieResponse.fromJson(jsonMap);

        // assert
        expect(result.movieList, isEmpty);
      });

      test('should throw when results is missing', () {
        // arrange
        final Map<String, dynamic> jsonMap = {};

        // act & assert
        expect(
          () => MovieResponse.fromJson(jsonMap),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // act
        final result = tMovieResponseModel.toJson();

        // assert
        final expectedJsonMap = {
          "results": [
            {
              "adult": false,
              "backdrop_path": "/path.jpg",
              "genre_ids": [1, 2, 3, 4],
              "id": 1,
              "original_title": "Original Title",
              "overview": "Overview",
              "popularity": 1.0,
              "poster_path": "/path.jpg",
              "release_date": "2025-05-05",
              "title": "Title",
              "video": false,
              "vote_average": 1.0,
              "vote_count": 1,
            },
          ],
        };
        expect(result, expectedJsonMap);
      });

      test('should return empty results array when movieList is empty', () {
        // arrange
        const emptyResponse = MovieResponse(movieList: []);

        // act
        final result = emptyResponse.toJson();

        // assert
        expect(result, {"results": []});
      });
    });

    group('Equatable', () {
      test('props should contain movieList', () {
        // arrange
        var props = [
          [tMovieModel],
        ];

        // assert
        expect(tMovieResponseModel.props, equals(props));
      });

      test('should be equal when movieList is same', () {
        // arrange
        var sameResponse = MovieResponse(movieList: [tMovieModel]);

        // assert
        expect(tMovieResponseModel, equals(sameResponse));
      });

      test('should not be equal when movieList is different', () {
        // arrange
        var differentMovie = MovieModel(
          adult: false,
          backdropPath: "/different.jpg",
          genreIds: [1, 2, 3, 4],
          id: 2,
          originalTitle: "Different Title",
          overview: "Different Overview",
          popularity: 1.0,
          posterPath: "/different.jpg",
          releaseDate: "2025-05-05",
          title: "Different Title",
          video: false,
          voteAverage: 1.0,
          voteCount: 1,
        );
        var differentResponse = MovieResponse(movieList: [differentMovie]);

        // assert
        expect(tMovieResponseModel, isNot(equals(differentResponse)));
      });
    });
  });
}
