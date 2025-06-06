import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/movies/cache/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('Watchlist Operations', () {
    group('insertWatchlist', () {
      test('should return success message when insert succeeds', () async {
        when(
          mockDatabaseHelper.insertWatchlistMovie(testMovieTable),
        ).thenAnswer((_) async => 1);

        final result = await dataSource.insertWatchlist(testMovieTable);

        expect(result, 'Added to Watchlist');
        verify(mockDatabaseHelper.insertWatchlistMovie(testMovieTable));
      });

      test('should throw DatabaseException when insert fails', () async {
        when(
          mockDatabaseHelper.insertWatchlistMovie(testMovieTable),
        ).thenThrow(Exception('Database error'));

        final call = dataSource.insertWatchlist(testMovieTable);

        await expectLater(() => call, throwsA(isA<DatabaseException>()));
        verify(mockDatabaseHelper.insertWatchlistMovie(testMovieTable));
      });
    });

    group('removeWatchlist', () {
      test('should return success message when remove succeeds', () async {
        when(
          mockDatabaseHelper.removeWatchlistMovie(testMovieTable),
        ).thenAnswer((_) async => 1);

        final result = await dataSource.removeWatchlist(testMovieTable);

        expect(result, 'Removed from Watchlist');
        verify(mockDatabaseHelper.removeWatchlistMovie(testMovieTable));
      });

      test('should throw DatabaseException when remove fails', () async {
        when(
          mockDatabaseHelper.removeWatchlistMovie(testMovieTable),
        ).thenThrow(Exception('Database error'));

        final call = dataSource.removeWatchlist(testMovieTable);

        await expectLater(() => call, throwsA(isA<DatabaseException>()));
        verify(mockDatabaseHelper.removeWatchlistMovie(testMovieTable));
      });
    });

    group('getMovieById', () {
      const tId = 1;

      test('should return MovieTable when data exists', () async {
        when(
          mockDatabaseHelper.getMovieById(tId),
        ).thenAnswer((_) async => testMovieMap);

        final result = await dataSource.getMovieById(tId);

        expect(result, testMovieTable);
        verify(mockDatabaseHelper.getMovieById(tId));
      });

      test('should return null when data does not exist', () async {
        when(
          mockDatabaseHelper.getMovieById(tId),
        ).thenAnswer((_) async => null);

        final result = await dataSource.getMovieById(tId);

        expect(result, null);
        verify(mockDatabaseHelper.getMovieById(tId));
      });

      test('should throw DatabaseException when query fails', () async {
        when(
          mockDatabaseHelper.getMovieById(tId),
        ).thenThrow(DatabaseException('Database error'));

        final call = dataSource.getMovieById(tId);

        await expectLater(() => call, throwsA(isA<DatabaseException>()));
      });
    });

    group('getWatchlistMovies', () {
      test('should return list of MovieTable when data exists', () async {
        when(
          mockDatabaseHelper.getWatchlistMovies(),
        ).thenAnswer((_) async => [testMovieMap]);

        final result = await dataSource.getWatchlistMovies();

        expect(result, [testMovieTable]);
        verify(mockDatabaseHelper.getWatchlistMovies());
      });

      test('should return empty list when no data exists', () async {
        when(
          mockDatabaseHelper.getWatchlistMovies(),
        ).thenAnswer((_) async => []);

        final result = await dataSource.getWatchlistMovies();

        expect(result, isEmpty);
        verify(mockDatabaseHelper.getWatchlistMovies());
      });

      test('should throw DatabaseException when query fails', () async {
        when(
          mockDatabaseHelper.getWatchlistMovies(),
        ).thenThrow(DatabaseException('Database error'));

        final call = dataSource.getWatchlistMovies();

        await expectLater(() => call, throwsA(isA<DatabaseException>()));
      });
    });
  });

  group('Cache Operations', () {
    final tMovies = [testMovieTable];

    void verifyCacheOperations(
      String category,
      Future<void> Function(List<MovieTable>) cacheFunction,
      Future<List<MovieTable>> Function() getCacheFunction,
    ) {
      group('$category movies', () {
        test('should clear and insert cache successfully', () async {
          when(
            mockDatabaseHelper.clearCache(category),
          ).thenAnswer((_) async => 1);
          when(
            mockDatabaseHelper.insertCacheTransaction(tMovies, category),
          ).thenAnswer((_) async {});

          await cacheFunction(tMovies);

          verifyInOrder([
            mockDatabaseHelper.clearCache(category),
            mockDatabaseHelper.insertCacheTransaction(tMovies, category),
          ]);
        });

        test('should throw DatabaseException when clearCache fails', () async {
          when(
            mockDatabaseHelper.clearCache(category),
          ).thenThrow(Exception('Database error'));

          final call = cacheFunction(tMovies);

          await expectLater(() => call, throwsA(isA<DatabaseException>()));
        });

        test('should throw DatabaseException when insertCache fails', () async {
          when(
            mockDatabaseHelper.clearCache(category),
          ).thenAnswer((_) async => 1);
          when(
            mockDatabaseHelper.insertCacheTransaction(tMovies, category),
          ).thenThrow(Exception('Database error'));

          final call = cacheFunction(tMovies);

          await expectLater(() => call, throwsA(isA<DatabaseException>()));
        });

        test('should return cached movies when data exists', () async {
          when(
            mockDatabaseHelper.getCacheMovies(category),
          ).thenAnswer((_) async => [testMovieMap]);

          final result = await getCacheFunction();

          expect(result, [testMovieTable]);
          verify(mockDatabaseHelper.getCacheMovies(category));
        });

        test('should throw CacheException when cache is empty', () async {
          when(
            mockDatabaseHelper.getCacheMovies(category),
          ).thenAnswer((_) async => []);

          final call = getCacheFunction();

          await expectLater(() => call, throwsA(isA<CacheException>()));
          verify(mockDatabaseHelper.getCacheMovies(category));
        });

        test('should throw DatabaseException when getCache fails', () async {
          when(
            mockDatabaseHelper.getCacheMovies(category),
          ).thenThrow(Exception('Database error'));

          final call = getCacheFunction();

          await expectLater(() => call, throwsA(isA<DatabaseException>()));
        });
      });
    }

    verifyCacheOperations(
      'now playing',
      (movies) => dataSource.cacheNowPlayingMovies(movies),
      () => dataSource.getCachedNowPlayingMovies(),
    );

    verifyCacheOperations(
      'popular',
      (movies) => dataSource.cachePopularMovies(movies),
      () => dataSource.getCachedPopularMovies(),
    );

    verifyCacheOperations(
      'top rated',
      (movies) => dataSource.cacheTopRatedMovies(movies),
      () => dataSource.getCachedTopRatedMovies(),
    );

    verifyCacheOperations(
      'up coming',
      (movies) => dataSource.cacheUpComingMovies(movies),
      () => dataSource.getCachedUpComingMovies(),
    );
  });
}
