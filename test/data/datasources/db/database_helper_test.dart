import 'package:ditonton_clean_architecture/data/models/tv_series/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ditonton_clean_architecture/data/datasources/db/database_helper.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_table.dart';

void main() {
  late DatabaseHelper databaseHelper;

  /// Test Data
  final tMovieTable = MovieTable(
    id: 1,
    title: 'Test Movie',
    overview: 'Test Overview',
    posterPath: '/test.jpg',
  );

  final anotherTMovieTable = MovieTable(
    id: 2,
    title: 'Another Movie',
    overview: 'Another Overview',
    posterPath: '/another.jpg',
  );

  final tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'Test Movie',
    overview: 'Test Overview',
    posterPath: '/test.jpg',
  );

  final anotherTTvSeriesTable = TvSeriesTable(
    id: 2,
    name: 'Another Movie',
    overview: 'Another Overview',
    posterPath: '/another.jpg',
  );

  // Database Setup
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    databaseHelper = DatabaseHelper();
    await databaseHelper.database;
  });

  // Clean up after each test
  tearDown(() async {
    final db = await databaseHelper.database;
    await db!.delete('watchlist');
    await db.delete('cache');
    await db.delete('watchlistTv');
    await db.delete('cacheTv');
  });

  group('DatabaseHelper Tests', () {
    group('Watchlist Operations', () {
      group('Movies', () {
        test('insertWatchlist should return row id on success', () async {
          final result = await databaseHelper.insertWatchlist(tMovieTable);
          expect(result, isPositive);
        });

        // Memastikan data berhasil disimpan dan diambil byId (Movies)
        test('getMovieById should return correct movie when exists', () async {
          await databaseHelper.insertWatchlist(tMovieTable);
          final movie = await databaseHelper.getMovieById(tMovieTable.id);
          expect(movie, isNotNull);
          expect(movie!['title'], tMovieTable.title);
          expect(movie['overview'], tMovieTable.overview);
          expect(movie['posterPath'], tMovieTable.posterPath);
        });

        // Return null jika ID tidak ada (Movies)
        test('getMovieById should return null when movie not exists', () async {
          final movie = await databaseHelper.getMovieById(9999);
          expect(movie, isNull);
        });

        // Data dihapus (Movies)
        test('removeWatchlist should return 1 when movie is deleted', () async {
          await databaseHelper.insertWatchlist(tMovieTable);
          final result = await databaseHelper.removeWatchlist(tMovieTable);
          expect(result, 1);
        });

        test('removeWatchlist should return 0 when movie not exists', () async {
          final result = await databaseHelper.removeWatchlist(tMovieTable);
          expect(result, 0);
        });

        test(
          'getWatchlistMovies should return empty list when no movies',
          () async {
            final result = await databaseHelper.getWatchlistMovies();
            expect(result, isEmpty);
          },
        );

        // Semua data watchlist berhasil diambil (Movies)
        test('getWatchlistMovies should return all inserted movies', () async {
          await databaseHelper.insertWatchlist(tMovieTable);
          await databaseHelper.insertWatchlist(anotherTMovieTable);
          final result = await databaseHelper.getWatchlistMovies();
          expect(result.length, 2);
          expect(result[0]['title'], tMovieTable.title);
          expect(result[1]['title'], anotherTMovieTable.title);
        });

        test('should not allow duplicate movie entries', () async {
          final firstInsert = await databaseHelper.insertWatchlist(tMovieTable);
          final secondInsert = await databaseHelper.insertWatchlist(
            tMovieTable,
          );
          expect(firstInsert, isPositive);
          expect(secondInsert, equals(firstInsert)); // Should return same id

          final movies = await databaseHelper.getWatchlistMovies();
          expect(movies.length, 1); // Only one entry despite two inserts
        });
      });

      group('Tv Series Database', () {
        test('insertWatchlistTv should return row id on success', () async {
          final result = await databaseHelper.insertWatchlistTv(tTvSeriesTable);
          expect(result, isPositive);
        });

        // Memastikan data berhasil disimpan dan diambil byId (TvSeries)
        test(
          'getTvSeriesById should return correct tv series when exists',
          () async {
            await databaseHelper.insertWatchlistTv(tTvSeriesTable);
            final tv = await databaseHelper.getTvSeriesById(tTvSeriesTable.id);
            expect(tv, isNotNull);
            expect(tv!['name'], tTvSeriesTable.name);
            expect(tv['overview'], tTvSeriesTable.overview);
            expect(tv['posterPath'], tTvSeriesTable.posterPath);
          },
        );

        // Return null jika ID tidak ada (TvSeries)
        test(
          'getTvSeriesById should return null when tv series not exists',
          () async {
            final tv = await databaseHelper.getTvSeriesById(9999);
            expect(tv, isNull);
          },
        );

        // Data dihapus (TvSeries)
        test(
          'removeWatchlistTv should return 1 when tv series is deleted',
          () async {
            await databaseHelper.insertWatchlistTv(tTvSeriesTable);
            final result = await databaseHelper.removeWatchlistTv(
              tTvSeriesTable,
            );
            expect(result, 1);
          },
        );

        test(
          'removeWatchlistTv should return 0 when tv series not exists',
          () async {
            final result = await databaseHelper.removeWatchlistTv(
              tTvSeriesTable,
            );
            expect(result, 0);
          },
        );

        test(
          'getWatchlistTvSeries should return empty list when no tv series',
          () async {
            final result = await databaseHelper.getWatchlistTvSeries();
            expect(result, isEmpty);
          },
        );

        // Semua data watchlist berhasil diambil (TvSeries)
        test(
          'getWatchlistTvSeries should return all inserted tv series',
          () async {
            await databaseHelper.insertWatchlistTv(tTvSeriesTable);
            await databaseHelper.insertWatchlistTv(anotherTTvSeriesTable);
            final result = await databaseHelper.getWatchlistTvSeries();
            expect(result.length, 2);
            expect(result[0]['name'], tTvSeriesTable.name);
            expect(result[1]['name'], anotherTTvSeriesTable.name);
          },
        );

        test('should not allow duplicate tv series entries', () async {
          final firstInsert = await databaseHelper.insertWatchlistTv(
            tTvSeriesTable,
          );
          final secondInsert = await databaseHelper.insertWatchlistTv(
            tTvSeriesTable,
          );
          expect(firstInsert, isPositive);
          expect(secondInsert, equals(firstInsert)); // Should return same id

          final tvSeries = await databaseHelper.getWatchlistTvSeries();
          expect(tvSeries.length, 1); // Only one entry despite two inserts
        });
      });
    });

    group('Cache Operations', () {
      const movieCategory = 'now_playing';
      const tvCategory = 'airing_today';

      group('Movies Cache', () {
        // Data berhasil disimpan dan diambil berdasarkan kategori
        test(
          'insertCacheTransaction should store movies with category',
          () async {
            await databaseHelper.insertCacheTransaction([
              tMovieTable,
            ], movieCategory);
            final cached = await databaseHelper.getCacheMovies(movieCategory);
            expect(cached.length, 1);
            expect(cached.first['category'], movieCategory);
          },
        );

        test(
          'getCacheMovies should return empty list for non-existent category',
          () async {
            final cached = await databaseHelper.getCacheMovies('nonexistent');
            expect(cached, isEmpty);
          },
        );

        // Replace data lama jika ID sama (test kestabilan caching)
        test('should replace existing movie when same id inserted', () async {
          final updatedMovie = MovieTable(
            id: tMovieTable.id,
            title: 'Updated Title',
            overview: 'Updated Overview',
            posterPath: '/updated.jpg',
          );

          await databaseHelper.insertCacheTransaction([
            tMovieTable,
          ], movieCategory);
          await databaseHelper.insertCacheTransaction([
            updatedMovie,
          ], movieCategory);

          final cached = await databaseHelper.getCacheMovies(movieCategory);
          expect(cached.length, 1);
          expect(cached.first['title'], 'Updated Title');
          expect(cached.first['overview'], 'Updated Overview');
          expect(cached.first['posterPath'], '/updated.jpg');
        });

        // Cache dibersihkan berdasarkan kategori
        test('clearCache should return number of deleted rows', () async {
          await databaseHelper.insertCacheTransaction([
            tMovieTable,
          ], movieCategory);
          final deleted = await databaseHelper.clearCache(movieCategory);
          expect(deleted, 1);
        });

        test('clearCache should return 0 when no rows to delete', () async {
          final deleted = await databaseHelper.clearCache(movieCategory);
          expect(deleted, 0);
        });

        test('should store multiple movies with same category', () async {
          await databaseHelper.insertCacheTransaction([
            tMovieTable,
            anotherTMovieTable,
          ], movieCategory);
          final cached = await databaseHelper.getCacheMovies(movieCategory);
          expect(cached.length, 2);
          expect(cached[0]['category'], movieCategory);
          expect(cached[1]['category'], movieCategory);
        });

        test(
          'should store movies with different categories separately',
          () async {
            const anotherCategory = 'popular';
            await databaseHelper.insertCacheTransaction([
              tMovieTable,
            ], movieCategory);
            await databaseHelper.insertCacheTransaction([
              anotherTMovieTable,
            ], anotherCategory);

            final cached1 = await databaseHelper.getCacheMovies(movieCategory);
            final cached2 = await databaseHelper.getCacheMovies(
              anotherCategory,
            );

            expect(cached1.length, 1);
            expect(cached2.length, 1);
            expect(cached1.first['id'], tMovieTable.id);
            expect(cached2.first['id'], anotherTMovieTable.id);
          },
        );
      });

      group('TV Series Cache', () {
        // Data berhasil disimpan dan diambil berdasarkan kategori
        test(
          'insertCacheTransactionTvSeries should store tv series with category',
          () async {
            await databaseHelper.insertCacheTransactionTvSeries([
              tTvSeriesTable,
            ], tvCategory);
            final cached = await databaseHelper.getCacheTvSeries(tvCategory);
            expect(cached.length, 1);
            expect(cached.first['category'], tvCategory);
          },
        );

        test(
          'getCacheTvSeries should return empty list for non-existent category',
          () async {
            final cached = await databaseHelper.getCacheTvSeries('nonexistent');
            expect(cached, isEmpty);
          },
        );

        // Replace data lama jika ID sama (test kestabilan caching)
        test(
          'should replace existing tv series when same id inserted (conflictAlgorithm: replace)',
          () async {
            final updatedTv = TvSeriesTable(
              id: tTvSeriesTable.id,
              name: 'Updated Name',
              overview: 'Updated Overview',
              posterPath: '/updated.jpg',
            );

            await databaseHelper.insertCacheTransactionTvSeries([
              tTvSeriesTable,
            ], tvCategory);
            await databaseHelper.insertCacheTransactionTvSeries([
              updatedTv,
            ], tvCategory);

            final cached = await databaseHelper.getCacheTvSeries(tvCategory);
            expect(cached.length, 1);
            expect(cached.first['name'], 'Updated Name');
            expect(cached.first['overview'], 'Updated Overview');
            expect(cached.first['posterPath'], '/updated.jpg');
          },
        );

        // Cache dibersihkan berdasarkan kategori
        test(
          'clearCacheTvSeries should return number of deleted rows',
          () async {
            await databaseHelper.insertCacheTransactionTvSeries([
              tTvSeriesTable,
            ], tvCategory);
            final deleted = await databaseHelper.clearCacheTvSeries(tvCategory);
            expect(deleted, 1);
          },
        );

        test(
          'clearCacheTvSeries should return 0 when no rows to delete',
          () async {
            final deleted = await databaseHelper.clearCacheTvSeries(tvCategory);
            expect(deleted, 0);
          },
        );

        test('should store multiple tv series with same category', () async {
          await databaseHelper.insertCacheTransactionTvSeries([
            tTvSeriesTable,
            anotherTTvSeriesTable,
          ], tvCategory);
          final cached = await databaseHelper.getCacheTvSeries(tvCategory);
          expect(cached.length, 2);
          expect(cached[0]['category'], tvCategory);
          expect(cached[1]['category'], tvCategory);
        });

        test(
          'should store tv series with different categories separately',
          () async {
            const anotherCategory = 'popular';
            await databaseHelper.insertCacheTransactionTvSeries([
              tTvSeriesTable,
            ], tvCategory);
            await databaseHelper.insertCacheTransactionTvSeries([
              anotherTTvSeriesTable,
            ], anotherCategory);

            final cached1 = await databaseHelper.getCacheTvSeries(tvCategory);
            final cached2 = await databaseHelper.getCacheTvSeries(
              anotherCategory,
            );

            expect(cached1.length, 1);
            expect(cached2.length, 1);
            expect(cached1.first['id'], tTvSeriesTable.id);
            expect(cached2.first['id'], anotherTTvSeriesTable.id);
          },
        );
      });
    });

    group('Database Initialization', () {
      test('should initialize database only once', () async {
        final firstInstance = await databaseHelper.database;
        final secondInstance = await databaseHelper.database;
        expect(firstInstance, same(secondInstance));
      });

      test('should create all required tables', () async {
        final db = await databaseHelper.database;
        final tables = await db!.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;",
        );

        final tableNames = tables.map((t) => t['name'] as String).toList();
        expect(tableNames, contains('watchlist'));
        expect(tableNames, contains('cache'));
        expect(tableNames, contains('watchlistTv'));
        expect(tableNames, contains('cacheTv'));
      });
    });
  });
}
