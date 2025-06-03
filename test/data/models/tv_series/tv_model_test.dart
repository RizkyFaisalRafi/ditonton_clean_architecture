import 'package:ditonton_clean_architecture/data/models/tv_series/tv_model.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvModel = TvModel(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    genreIds: [1, 2, 3],
    id: 12345,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview text',
    popularity: 78.5,
    posterPath: '/posterPath.jpg',
    firstAirDate: '2023-01-01',
    name: 'TV Series Name',
    voteAverage: 8.2,
    voteCount: 1500,
  );

  const tTvJson = {
    "adult": false,
    "backdrop_path": "/backdropPath.jpg",
    "genre_ids": [1, 2, 3],
    "id": 12345,
    "origin_country": ["US"],
    "original_language": "en",
    "original_name": "Original Name",
    "overview": "Overview text",
    "popularity": 78.5,
    "poster_path": "/posterPath.jpg",
    "first_air_date": "2023-01-01",
    "name": "TV Series Name",
    "vote_average": 8.2,
    "vote_count": 1500,
  };

  var tTv = TvSeries(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    genreIds: [1, 2, 3],
    id: 12345,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview text',
    popularity: 78.5,
    posterPath: '/posterPath.jpg',
    firstAirDate: '2023-01-01',
    name: 'TV Series Name',
    voteAverage: 8.2,
    voteCount: 1500,
  );

  group('TvModel', () {
    test('should be a subclass of TvSeries entity', () {
      final result = tTvModel.toEntity();
      expect(result, equals(tTv));
    });

    test('should return a valid model from JSON', () {
      final result = TvModel.fromJson(tTvJson);
      expect(result, equals(tTvModel));
    });

    test('should return a JSON map containing proper data', () {
      final result = tTvModel.toJson();
      expect(result, equals(tTvJson));
    });

    test('should handle null values in JSON correctly', () {
      final jsonWithNulls = {
        ...tTvJson,
        "backdrop_path": null,
        "poster_path": null,
        "first_air_date": null,
      };

      final result = TvModel.fromJson(jsonWithNulls);

      expect(result.backdropPath, isNull);
      expect(result.posterPath, isNull);
      expect(result.firstAirDate, isNull);
    });

    test('should handle empty arrays in JSON correctly', () {
      final jsonWithEmptyArrays = {
        ...tTvJson,
        "genre_ids": [],
        "origin_country": [],
      };

      final result = TvModel.fromJson(jsonWithEmptyArrays);

      expect(result.genreIds, isEmpty);
      expect(result.originCountry, isEmpty);
    });

    test('props should contain all properties', () {
      const expectedProps = [
        false, // adult
        '/backdropPath.jpg', // backdropPath
        [1, 2, 3], // genreIds
        12345, // id
        ['US'], // originCountry
        'en', // originalLanguage
        'Original Name', // originalName
        'Overview text', // overview
        78.5, // popularity
        '/posterPath.jpg', // posterPath
        '2023-01-01', // firstAirDate
        'TV Series Name', // name
        8.2, // voteAverage
        1500, // voteCount
      ];

      expect(tTvModel.props, equals(expectedProps));
    });

    test('should be equal when properties are the same', () {
      const sameTvModel = TvModel(
        adult: false,
        backdropPath: '/backdropPath.jpg',
        genreIds: [1, 2, 3],
        id: 12345,
        originCountry: ['US'],
        originalLanguage: 'en',
        originalName: 'Original Name',
        overview: 'Overview text',
        popularity: 78.5,
        posterPath: '/posterPath.jpg',
        firstAirDate: '2023-01-01',
        name: 'TV Series Name',
        voteAverage: 8.2,
        voteCount: 1500,
      );

      expect(tTvModel, equals(sameTvModel));
    });

    test('should not be equal when properties are different', () {
      const differentTvModel = TvModel(
        adult: true,
        // Different
        backdropPath: '/backdropPath.jpg',
        genreIds: [1, 2, 3],
        id: 12345,
        originCountry: ['US'],
        originalLanguage: 'en',
        originalName: 'Original Name',
        overview: 'Overview text',
        popularity: 78.5,
        posterPath: '/posterPath.jpg',
        firstAirDate: '2023-01-01',
        name: 'TV Series Name',
        voteAverage: 8.2,
        voteCount: 1500,
      );

      expect(tTvModel, isNot(equals(differentTvModel)));
    });

    test('toJson should handle null values correctly', () {
      const tvModelWithNulls = TvModel(
        adult: false,
        backdropPath: null,
        genreIds: null,
        id: null,
        originCountry: null,
        originalLanguage: null,
        originalName: null,
        overview: null,
        popularity: null,
        posterPath: null,
        firstAirDate: null,
        name: null,
        voteAverage: null,
        voteCount: null,
      );

      final result = tvModelWithNulls.toJson();

      expect(result['backdrop_path'], isNull);
      expect(result['genre_ids'], isEmpty);
      expect(result['origin_country'], isEmpty);
    });
  });
}
