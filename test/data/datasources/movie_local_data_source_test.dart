import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test(
      'should return success message when insert to database is success',
      () async {
        // arrange
        when(
          mockDatabaseHelper.insertWatchlist(testMovieTable),
        ).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.insertWatchlist(testMovieTable);
        // assert
        expect(result, 'Added to Watchlist');
      },
    );

    test(
      'should throw DatabaseException when insert to database is failed',
      () async {
        // arrange
        when(
          mockDatabaseHelper.insertWatchlist(testMovieTable),
        ).thenThrow(Exception());
        // act
        final call = dataSource.insertWatchlist(testMovieTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('remove watchlist', () {
    test(
      'should return success message when remove from database is success',
      () async {
        // arrange
        when(
          mockDatabaseHelper.removeWatchlist(testMovieTable),
        ).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.removeWatchlist(testMovieTable);
        // assert
        expect(result, 'Removed from Watchlist');
      },
    );

    test(
      'should throw DatabaseException when remove from database is failed',
      () async {
        // arrange
        when(
          mockDatabaseHelper.removeWatchlist(testMovieTable),
        ).thenThrow(Exception());
        // act
        final call = dataSource.removeWatchlist(testMovieTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(
        mockDatabaseHelper.getMovieById(tId),
      ).thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(
        mockDatabaseHelper.getWatchlistMovies(),
      ).thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });

  group('cache now playing movies', () {
    test('should call DatabaseHelper to clear and insert cache', () async {
      // arrange
      when(
        mockDatabaseHelper.clearCache('now playing'),
      ).thenAnswer((_) async => 1);
      when(
        mockDatabaseHelper.insertCacheTransaction([
          testMovieTable,
        ], 'now playing'),
      ).thenAnswer((_) async {});
      // act
      await dataSource.cacheNowPlayingMovies([testMovieTable]);
      // assert
      verify(mockDatabaseHelper.clearCache('now playing'));
      verify(
        mockDatabaseHelper.insertCacheTransaction([
          testMovieTable,
        ], 'now playing'),
      );
    });
  });

  group('get cached now playing movies', () {
    test(
      'should return list of MovieTable when cache data is present',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheMovies('now playing'),
        ).thenAnswer((_) async => [testMovieMap]);
        // act
        final result = await dataSource.getCachedNowPlayingMovies();
        // assert
        expect(result, [testMovieTable]);
      },
    );

    test('should throw CacheException when cache data is empty', () async {
      // arrange
      when(
        mockDatabaseHelper.getCacheMovies('now playing'),
      ).thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache popular movies', () {
    test('should call DatabaseHelper to clear and insert cache', () async {
      // arrange
      when(mockDatabaseHelper.clearCache('popular')).thenAnswer((_) async => 1);
      when(
        mockDatabaseHelper.insertCacheTransaction([testMovieTable], 'popular'),
      ).thenAnswer((_) async {});
      // act
      await dataSource.cachePopularMovies([testMovieTable]);
      // assert
      verify(mockDatabaseHelper.clearCache('popular'));
      verify(
        mockDatabaseHelper.insertCacheTransaction([testMovieTable], 'popular'),
      );
    });
  });

  group('get cached popular movies', () {
    test(
      'should return list of MovieTable when cache data is present',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheMovies('popular'),
        ).thenAnswer((_) async => [testMovieMap]);
        // act
        final result = await dataSource.getCachedPopularMovies();
        // assert
        expect(result, [testMovieTable]);
      },
    );

    test('should throw CacheException when cache data is empty', () async {
      // arrange
      when(
        mockDatabaseHelper.getCacheMovies('popular'),
      ).thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedPopularMovies();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache top rated movies', () {
    test('should call DatabaseHelper to clear and insert cache', () async {
      // arrange
      when(
        mockDatabaseHelper.clearCache('top rated'),
      ).thenAnswer((_) async => 1);
      when(
        mockDatabaseHelper.insertCacheTransaction([
          testMovieTable,
        ], 'top rated'),
      ).thenAnswer((_) async {});
      // act
      await dataSource.cacheTopRatedMovies([testMovieTable]);
      // assert
      verify(mockDatabaseHelper.clearCache('top rated'));
      verify(
        mockDatabaseHelper.insertCacheTransaction([
          testMovieTable,
        ], 'top rated'),
      );
    });
  });

  group('get cached top rated movies', () {
    test(
      'should return list of MovieTable when cache data is present',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheMovies('top rated'),
        ).thenAnswer((_) async => [testMovieMap]);
        // act
        final result = await dataSource.getCachedTopRatedMovies();
        // assert
        expect(result, [testMovieTable]);
      },
    );

    test('should throw CacheException when cache data is empty', () async {
      // arrange
      when(
        mockDatabaseHelper.getCacheMovies('top rated'),
      ).thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cache upcoming movies', () {
    test('should call DatabaseHelper to clear and insert cache', () async {
      // arrange
      when(
        mockDatabaseHelper.clearCache('up coming'),
      ).thenAnswer((_) async => 1);
      when(
        mockDatabaseHelper.insertCacheTransaction([
          testMovieTable,
        ], 'up coming'),
      ).thenAnswer((_) async {});
      // act
      await dataSource.cacheUpComingMovies([testMovieTable]);
      // assert
      verify(mockDatabaseHelper.clearCache('up coming'));
      verify(
        mockDatabaseHelper.insertCacheTransaction([
          testMovieTable,
        ], 'up coming'),
      );
    });
  });

  group('get cached upcoming movies', () {
    test(
      'should return list of MovieTable when cache data is present',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheMovies('up coming'),
        ).thenAnswer((_) async => [testMovieMap]);
        // act
        final result = await dataSource.getCachedUpComingMovies();
        // assert
        expect(result, [testMovieTable]);
      },
    );

    test('should throw CacheException when cache data is empty', () async {
      // arrange
      when(
        mockDatabaseHelper.getCacheMovies('up coming'),
      ).thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedUpComingMovies();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
