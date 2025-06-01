import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
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

  group('save watchlist', () {
    test(
      'should return success message when insert to database is success',
      () async {
        // arrange
        when(
          mockDatabaseHelper.insertWatchlistTv(testTvTable),
        ).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.insertWatchlist(testTvTable);
        // assert
        expect(result, 'Added to Watchlist');
      },
    );

    test(
      'should throw DatabaseException when insert to database is failed',
      () async {
        // arrange
        when(
          mockDatabaseHelper.insertWatchlistTv(testTvTable),
        ).thenThrow(Exception());
        // act
        final call = dataSource.insertWatchlist(testTvTable);
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
          mockDatabaseHelper.removeWatchlistTv(testTvTable),
        ).thenAnswer((_) async => 1);
        // act
        final result = await dataSource.removeWatchlist(testTvTable);
        // assert
        expect(result, 'Removed from Watchlist');
      },
    );

    test(
      'should throw DatabaseException when remove from database is failed',
      () async {
        // arrange
        when(
          mockDatabaseHelper.removeWatchlistTv(testTvTable),
        ).thenThrow(Exception());
        // act
        final call = dataSource.removeWatchlist(testTvTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('get tv Detail by Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(
        mockDatabaseHelper.getTvSeriesById(tId),
      ).thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(
        mockDatabaseHelper.getTvSeriesById(tId),
      ).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(
        mockDatabaseHelper.getWatchlistTvSeries(),
      ).thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });

  group('cache airing today tv series', () {
    test('should call DatabaseHelper to clear and insert cache', () async {
      // arrange
      when(
        mockDatabaseHelper.clearCacheTvSeries('airing today'),
      ).thenAnswer((_) async => 1);
      when(
        mockDatabaseHelper.insertCacheTransactionTvSeries([
          testTvTable,
        ], 'airing today'),
      ).thenAnswer((_) async {});
      // act
      await dataSource.cacheAiringTodayTvSeries([testTvTable]);
      // assert
      verify(mockDatabaseHelper.clearCacheTvSeries('airing today'));
      verify(
        mockDatabaseHelper.insertCacheTransactionTvSeries([
          testTvTable,
        ], 'airing today'),
      );
    });
  });

  group('get cached airing today tv series', () {
    test(
      'should return list of TvSeriesTable when cache data is present',
      () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheTvSeries('airing today'),
        ).thenAnswer((_) async => [testTvMap]);
        // act
        final result = await dataSource.getCachedAiringTodayTv();
        // assert
        expect(result, [testTvTable]);
      },
    );

    test('should throw CacheException when cache data is empty', () async {
      // arrange
      when(
        mockDatabaseHelper.getCacheTvSeries('airing today'),
      ).thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedAiringTodayTv();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  // on the air tv series
  group('cache on the air tv series', () {
    test('should call DatabaseHelper to clear and insert cache', () async {
      // arrange
      when(
        mockDatabaseHelper.clearCacheTvSeries('on the air'),
      ).thenAnswer((_) async => 1);
      when(
        mockDatabaseHelper.insertCacheTransactionTvSeries([
          testTvTable,
        ], 'on the air'),
      ).thenAnswer((_) async {});
      // act
      await dataSource.cacheOnTheAirTvSeries([testTvTable]);
      // assert
      verify(mockDatabaseHelper.clearCacheTvSeries('on the air'));
      verify(
        mockDatabaseHelper.insertCacheTransactionTvSeries([
          testTvTable,
        ], 'on the air'),
      );
    });
  });

  group('get cached on the air tv series', () {
    test('should return list of TvTable when cache data is present', () async {
      // arrange
      when(
        mockDatabaseHelper.getCacheTvSeries('on the air'),
      ).thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getCachedOnTheAirTv();
      // assert
      expect(result, [testTvTable]);
    });

    test('should throw CacheException when cache data is empty', () async {
      // arrange
      when(
        mockDatabaseHelper.getCacheTvSeries('on the air'),
      ).thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedOnTheAirTv();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
