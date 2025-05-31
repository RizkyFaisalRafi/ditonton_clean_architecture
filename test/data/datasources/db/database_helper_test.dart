import 'package:ditonton_clean_architecture/data/models/tv_series/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ditonton_clean_architecture/data/datasources/db/database_helper.dart';
import 'package:ditonton_clean_architecture/data/models/movie_table.dart';

void main() {
  late DatabaseHelper databaseHelper;

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

  setUpAll(() async {
    // Inisialisasi ffi untuk test
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Buat instance DatabaseHelper
    databaseHelper = DatabaseHelper();
    // inisialisasi databaseHelper
    await databaseHelper.database;
  });

  tearDown(() async {
    final db = await databaseHelper.database;
    await db!.delete('watchlist');
    await db.delete('cache');
    await db.delete('watchlistTv');
    await db.delete('cacheTv');
  });

  group('Watchlist Tests', () {
    group('Movies Database', () {
      // Memastikan data berhasil disimpan dan diambil byId (Movies)
      test('should insert and retrieve movie from watchlist', () async {
        await databaseHelper.insertWatchlist(tMovieTable);
        final movie = await databaseHelper.getMovieById(tMovieTable.id);
        expect(movie, isNotNull);
        expect(movie!['title'], tMovieTable.title);
      });

      // Return null jika ID tidak ada (Movies)
      test('should return null when movie is not in watchlist', () async {
        final movie = await databaseHelper.getMovieById(9999);
        expect(movie, isNull);
      });

      // Data dihapus (Movies)
      test('should remove movie from watchlist', () async {
        await databaseHelper.insertWatchlist(tMovieTable);
        final removed = await databaseHelper.removeWatchlist(tMovieTable);
        expect(removed, 1);
      });

      // Semua data watchlist berhasil diambil (Movies)
      test('should return list of movies in watchlist', () async {
        await databaseHelper.insertWatchlist(tMovieTable);
        await databaseHelper.insertWatchlist(anotherTMovieTable);
        final list = await databaseHelper.getWatchlistMovies();
        expect(list.length, 2);
      });
    });

    group('Tv Series Database', () {
      // Memastikan data berhasil disimpan dan diambil byId (TvSeries)
      test('should insert and retrieve tv series from watchlist', () async {
        await databaseHelper.insertWatchlistTv(tTvSeriesTable);
        final tv = await databaseHelper.getTvSeriesById(tTvSeriesTable.id);
        expect(tv, isNotNull);
        expect(tv!['name'], tTvSeriesTable.name);
      });

      // Return null jika ID tidak ada (TvSeries)
      test('should return null when tv series is not in watchlist', () async {
        final tv = await databaseHelper.getTvSeriesById(9999);
        expect(tv, isNull);
      });

      // Data dihapus (TvSeries)
      test('should remove tv series from watchlist', () async {
        await databaseHelper.insertWatchlistTv(tTvSeriesTable);
        final removed = await databaseHelper.removeWatchlistTv(tTvSeriesTable);
        expect(removed, 1);
      });

      // Semua data watchlist berhasil diambil (TvSeries)
      test('should return list of tv series in watchlist', () async {
        await databaseHelper.insertWatchlistTv(tTvSeriesTable);
        await databaseHelper.insertWatchlistTv(anotherTTvSeriesTable);
        final list = await databaseHelper.getWatchlistTvSeries();
        expect(list.length, 2);
      });
    });
  });


  group('Cache Tests', () {
    const category = 'now playing';
    const categoryTv = 'airing today';

    group('Cache Movies Database', () {
      // Data berhasil disimpan dan diambil berdasarkan kategori
      test('should insert and retrieve cache movies', () async {
        await databaseHelper.insertCacheTransaction([
          tMovieTable,
          anotherTMovieTable,
        ], category);
        final cached = await databaseHelper.getCacheMovies(category);
        expect(cached.length, 2);
        expect(cached.first['category'], category);
      });

      // Replace data lama jika ID sama (test kestabilan caching)
      test(
        'should replace movie if same ID inserted again (conflictAlgorithm: replace)',
        () async {
          final updatedMovie = MovieTable(
            id: tMovieTable.id,
            title: 'Updated Title',
            overview: tMovieTable.overview,
            posterPath: tMovieTable.posterPath,
          );

          await databaseHelper.insertCacheTransaction([tMovieTable], category);
          await databaseHelper.insertCacheTransaction([updatedMovie], category);

          final cached = await databaseHelper.getCacheMovies(category);
          expect(cached.length, 1);
          expect(cached.first['title'], 'Updated Title');
        },
      );

      // Cache dibersihkan berdasarkan kategori
      test('should clear cache by category', () async {
        await databaseHelper.insertCacheTransaction([tMovieTable], category);
        final deleted = await databaseHelper.clearCache(category);
        expect(deleted, 1);
      });
    });

    group('Cache Tv Series Database', () {
      // Data berhasil disimpan dan diambil berdasarkan kategori
      test('should insert and retrieve cache tv series', () async {
        await databaseHelper.insertCacheTransactionTvSeries([
          tTvSeriesTable,
          anotherTTvSeriesTable,
        ], categoryTv);
        final cached = await databaseHelper.getCacheTvSeries(categoryTv);
        expect(cached.length, 2);
        expect(cached.first['category'], categoryTv);
      });

      // Replace data lama jika ID sama (test kestabilan caching)
      test(
        'should replace tv series if same ID inserted again (conflictAlgorithm: replace)',
            () async {
          final updatedTv = TvSeriesTable(
            id: tTvSeriesTable.id,
            name: 'Updated Name',
            overview: tTvSeriesTable.overview,
            posterPath: tTvSeriesTable.posterPath,
          );

          await databaseHelper.insertCacheTransactionTvSeries([tTvSeriesTable], categoryTv);
          await databaseHelper.insertCacheTransactionTvSeries([updatedTv], categoryTv);

          final cached = await databaseHelper.getCacheTvSeries(categoryTv);
          expect(cached.length, 1);
          expect(cached.first['name'], 'Updated Name');
        },
      );

      // Cache dibersihkan berdasarkan kategori
      test('should clear cache by category', () async {
        await databaseHelper.insertCacheTransactionTvSeries([tTvSeriesTable], categoryTv);
        final deleted = await databaseHelper.clearCacheTvSeries(categoryTv);
        expect(deleted, 1);
      });
    });

  });
}
