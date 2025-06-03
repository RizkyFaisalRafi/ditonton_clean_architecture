import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDatasourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvSeriesLocalDatasourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('Watchlist Operations', () {
    group('insertWatchlist', () {
      test('should return success message when insert succeeds', () async {
        when(
          mockDatabaseHelper.insertWatchlistTv(testTvTable),
        ).thenAnswer((_) async => 1);

        final result = await dataSource.insertWatchlist(testTvTable);

        expect(result, 'Added to Watchlist');
        verify(mockDatabaseHelper.insertWatchlistTv(testTvTable));
      });

      test('should throw DatabaseException when insert fails', () async {
        when(
          mockDatabaseHelper.insertWatchlistTv(testTvTable),
        ).thenThrow(Exception('Database error'));

        final call = dataSource.insertWatchlist(testTvTable);

        await expectLater(() => call, throwsA(isA<DatabaseException>()));
        verify(mockDatabaseHelper.insertWatchlistTv(testTvTable));
      });
    });

    group('removeWatchlist', () {
      test('should return success message when remove succeeds', () async {
        when(
          mockDatabaseHelper.removeWatchlistTv(testTvTable),
        ).thenAnswer((_) async => 1);

        final result = await dataSource.removeWatchlist(testTvTable);

        expect(result, 'Removed from Watchlist');
        verify(mockDatabaseHelper.removeWatchlistTv(testTvTable));
      });

      test('should throw DatabaseException when remove fails', () async {
        when(
          mockDatabaseHelper.removeWatchlistTv(testTvTable),
        ).thenThrow(Exception('Database error'));

        final call = dataSource.removeWatchlist(testTvTable);

        await expectLater(() => call, throwsA(isA<DatabaseException>()));
        verify(mockDatabaseHelper.removeWatchlistTv(testTvTable));
      });
    });

    group('getTvSeriesById', () {
      const tId = 1;

      test('should return TvSeriesTable when data exists', () async {
        when(
          mockDatabaseHelper.getTvSeriesById(tId),
        ).thenAnswer((_) async => testTvMap);

        final result = await dataSource.getTvSeriesById(tId);

        expect(result, testTvTable);
        verify(mockDatabaseHelper.getTvSeriesById(tId));
      });

      test('should return null when data does not exist', () async {
        when(
          mockDatabaseHelper.getTvSeriesById(tId),
        ).thenAnswer((_) async => null);

        final result = await dataSource.getTvSeriesById(tId);

        expect(result, null);
        verify(mockDatabaseHelper.getTvSeriesById(tId));
      });

      test('should throw DatabaseException when query fails', () async {
        when(
          mockDatabaseHelper.getTvSeriesById(tId),
        ).thenThrow(Exception('Database error'));

        final call = dataSource.getTvSeriesById(tId);

        await expectLater(() => call, throwsA(isA<DatabaseException>()));
      });
    });

    group('getWatchlistTv', () {
      test('should return list of TvSeriesTable when data exists', () async {
        when(
          mockDatabaseHelper.getWatchlistTvSeries(),
        ).thenAnswer((_) async => [testTvMap]);

        final result = await dataSource.getWatchlistTv();

        expect(result, [testTvTable]);
        verify(mockDatabaseHelper.getWatchlistTvSeries());
      });

      test('should return empty list when no data exists', () async {
        when(
          mockDatabaseHelper.getWatchlistTvSeries(),
        ).thenAnswer((_) async => []);

        final result = await dataSource.getWatchlistTv();

        expect(result, isEmpty);
        verify(mockDatabaseHelper.getWatchlistTvSeries());
      });

      test('should throw DatabaseException when query fails', () async {
        when(
          mockDatabaseHelper.getWatchlistTvSeries(),
        ).thenThrow(Exception('Database error'));

        final call = dataSource.getWatchlistTv();

        await expectLater(() => call, throwsA(isA<DatabaseException>()));
      });
    });
  });

  group('Cache Operations', () {
    final tTvSeriesList = [testTvTable];

    void verifyCacheOperations(
      String category,
      Future<void> Function(List<TvSeriesTable>) cacheFunction,
      Future<List<TvSeriesTable>> Function() getCacheFunction,
    ) {
      group('$category tv series', () {
        test('should clear and insert cache successfully', () async {
          when(
            mockDatabaseHelper.clearCacheTvSeries(category),
          ).thenAnswer((_) async => 1);
          when(
            mockDatabaseHelper.insertCacheTransactionTvSeries(
              tTvSeriesList,
              category,
            ),
          ).thenAnswer((_) async {});

          await cacheFunction(tTvSeriesList);

          verifyInOrder([
            mockDatabaseHelper.clearCacheTvSeries(category),
            mockDatabaseHelper.insertCacheTransactionTvSeries(
              tTvSeriesList,
              category,
            ),
          ]);
        });

        test('should throw DatabaseException when clearCache fails', () async {
          when(
            mockDatabaseHelper.clearCacheTvSeries(category),
          ).thenThrow(Exception('Database error'));

          final call = cacheFunction(tTvSeriesList);

          await expectLater(() => call, throwsA(isA<DatabaseException>()));
        });

        test('should throw DatabaseException when insertCache fails', () async {
          when(
            mockDatabaseHelper.clearCacheTvSeries(category),
          ).thenAnswer((_) async => 1);
          when(
            mockDatabaseHelper.insertCacheTransactionTvSeries(
              tTvSeriesList,
              category,
            ),
          ).thenThrow(Exception('Database error'));

          final call = cacheFunction(tTvSeriesList);

          await expectLater(() => call, throwsA(isA<DatabaseException>()));
        });

        test('should return cached tv series when data exists', () async {
          when(
            mockDatabaseHelper.getCacheTvSeries(category),
          ).thenAnswer((_) async => [testTvMap]);

          final result = await getCacheFunction();

          expect(result, [testTvTable]);
          verify(mockDatabaseHelper.getCacheTvSeries(category));
        });

        test('should throw CacheException when cache is empty', () async {
          when(
            mockDatabaseHelper.getCacheTvSeries(category),
          ).thenAnswer((_) async => []);

          final call = getCacheFunction();

          await expectLater(() => call, throwsA(isA<CacheException>()));
          verify(mockDatabaseHelper.getCacheTvSeries(category));
        });

        test('should throw DatabaseException when getCache fails', () async {
          when(
            mockDatabaseHelper.getCacheTvSeries(category),
          ).thenThrow(Exception('Database error'));

          final call = getCacheFunction();

          await expectLater(() => call, throwsA(isA<DatabaseException>()));
        });
      });
    }

    verifyCacheOperations(
      'airing today',
      (tvSeries) => dataSource.cacheAiringTodayTvSeries(tvSeries),
      () => dataSource.getCachedAiringTodayTv(),
    );

    verifyCacheOperations(
      'on the air',
      (tvSeries) => dataSource.cacheOnTheAirTvSeries(tvSeries),
      () => dataSource.getCachedOnTheAirTv(),
    );

    verifyCacheOperations(
      'popular',
      (tvSeries) => dataSource.cachePopularTvSeries(tvSeries),
      () => dataSource.getCachedPopularTv(),
    );

    verifyCacheOperations(
      'top rated tv',
      (tvSeries) => dataSource.cacheTopRatedTvSeries(tvSeries),
      () => dataSource.getCachedTopRatedTv(),
    );
  });
}
