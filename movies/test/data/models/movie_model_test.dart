import 'package:movies/module/movies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: '2023-01-01',
    title: 'title',
    video: false,
    voteAverage: 8.5,
    voteCount: 100,
  );

  const tMovieJson = {
    "adult": false,
    "backdrop_path": "backdropPath",
    "genre_ids": [1, 2, 3],
    "id": 1,
    "original_title": "originalTitle",
    "overview": "overview",
    "popularity": 1.0,
    "poster_path": "posterPath",
    "release_date": "2023-01-01",
    "title": "title",
    "video": false,
    "vote_average": 8.5,
    "vote_count": 100,
  };

  var tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: '2023-01-01',
    title: 'title',
    video: false,
    voteAverage: 8.5,
    voteCount: 100,
  );

  group('MovieModel', () {
    test('should be a subclass of Movie entity', () {
      final result = tMovieModel.toEntity();
      expect(result, equals(tMovie));
    });

    test('should return a valid model from JSON', () {
      // Act
      final result = MovieModel.fromJson(tMovieJson);

      // Assert
      expect(result, equals(tMovieModel));
    });

    test('should return a JSON map containing proper data', () {
      // Act
      final result = tMovieModel.toJson();

      // Assert
      expect(result, equals(tMovieJson));
    });

    test('should handle null values in JSON correctly', () {
      // Arrange
      final jsonWithNulls = {
        ...tMovieJson,
        "backdrop_path": null,
        "poster_path": null,
        "release_date": null,
      };

      // Act
      final result = MovieModel.fromJson(jsonWithNulls);

      // Assert
      expect(result.backdropPath, isNull);
      expect(result.posterPath, isNull);
      expect(result.releaseDate, isNull);
    });

    test('props should contain all properties', () {
      // Arrange
      const expectedProps = [
        false, // adult
        'backdropPath', // backdropPath
        [1, 2, 3], // genreIds
        1, // id
        'originalTitle', // originalTitle
        'overview', // overview
        1.0, // popularity
        'posterPath', // posterPath
        '2023-01-01', // releaseDate
        'title', // title
        false, // video
        8.5, // voteAverage
        100, // voteCount
      ];

      // Assert
      expect(tMovieModel.props, equals(expectedProps));
    });

    test('should be equal when properties are the same', () {
      // Arrange
      var movieModel2 = MovieModel(
        adult: false,
        backdropPath: 'backdropPath',
        genreIds: [1, 2, 3],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        popularity: 1.0,
        posterPath: 'posterPath',
        releaseDate: '2023-01-01',
        title: 'title',
        video: false,
        voteAverage: 8.5,
        voteCount: 100,
      );

      // Assert
      expect(tMovieModel, equals(movieModel2));
    });

    test('should not be equal when properties are different', () {
      // Arrange
      var differentMovieModel = MovieModel(
        // Adult Different
        adult: true,
        backdropPath: 'backdropPath',
        genreIds: [1, 2, 3],
        id: 1,
        originalTitle: 'originalTitle',
        overview: 'overview',
        popularity: 1.0,
        posterPath: 'posterPath',
        releaseDate: '2023-01-01',
        title: 'title',
        video: false,
        voteAverage: 8.5,
        voteCount: 100,
      );

      // Assert
      expect(tMovieModel, isNot(equals(differentMovieModel)));
    });
  });
}
