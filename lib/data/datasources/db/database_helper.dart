import 'dart:async';
import 'package:ditonton_clean_architecture/data/models/tv_series/cache/tv_series_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import '../../../common/encrypt.dart';
import '../../models/movies/cache/movie_detail_table.dart';
import '../../models/movies/cache/movie_table.dart';
import '../../models/tv_series/cache/tv_series_detail_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlistMovie = 'watchlist';
  static const String _tblWatchlistTv = 'watchlistTv';
  static const String _tblCacheMovie = 'cache';
  static const String _tblCacheTv = 'cacheTv';
  static const String _tblCacheMovieDetail = 'cacheMovieDetail';
  static const String _tblCacheTvDetail = 'cacheTvDetail';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    /**
     * database SQLite memiliki satu lapisan keamanan tambahan.
     * Password ini akan digunakan untuk mengenkripsi database.
     */
    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('databaseSecure301201'), // Enkripsi
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tblCacheMovieDetail (
      id INTEGER PRIMARY KEY,
      title TEXT,
      posterPath TEXT,
      overview TEXT,
      runtime INTEGER,
      voteAverage REAL,
      releaseDate TEXT,
      genres TEXT
    );
  ''');

    await db.execute('''
    CREATE TABLE $_tblCacheTvDetail (
      id INTEGER PRIMARY KEY, 
      name TEXT,
      posterPath TEXT,
      backdropPath TEXT,
      overview TEXT, 
      voteAverage REAL,
      genres TEXT, 
      popularity REAL,
      createdBy TEXT,
      seasons TEXT,
      lastEpisodeToAir TEXT,
      nextEpisodeToAir TEXT
    );
  ''');

    await db.execute('''
      CREATE TABLE  $_tblWatchlistMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblCacheMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblWatchlistTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblCacheTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }

  // Movies
  Future<void> insertCacheTransaction(
    List<MovieTable> movies,
    String category,
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;

        // Error DatabaseException(UNIQUE constraint failed: cache.id)
        // txn.insert(_tblCache, movieJson);

        // Data baru akan mengganti data lama jika memiliki id yang sama (sesuai ConflictAlgorithm.replace).
        // Aplikasi lebih stabil dan aman saat caching ulang.
        txn.insert(
          _tblCacheMovie,
          movieJson,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  // Insert cache MovieDetail
  Future<void> insertCacheMovieDetail(MovieDetailTable movieDetail) async {
    final db = await database;
    await db!.insert(
      _tblCacheMovieDetail,
      movieDetail.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Ambil cache MovieDetail by id
  Future<Map<String, dynamic>?> getCachedMovieDetail(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblCacheMovieDetail,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  // Insert cache TvDetail
  Future<void> insertCacheTvDetail(TvSeriesDetailTable tvDetail) async {
    final db = await database;
    await db!.insert(
      _tblCacheTvDetail,
      tvDetail.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Ambil cache TvDetail by id
  Future<Map<String, dynamic>?> getCachedTvDetail(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblCacheTvDetail,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getCacheMovies(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheMovie,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheMovie,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(
      _tblWatchlistMovie,
      movie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Data lama diganti baru
    );
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblWatchlistMovie,
    );

    return results;
  }

  /// TV Series
  Future<void> insertCacheTransactionTvSeries(
    List<TvSeriesTable> tvSeries,
    String category,
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final tv in tvSeries) {
        final movieJson = tv.toJson();
        movieJson['category'] = category;

        // Error DatabaseException(UNIQUE constraint failed: cache.id)
        // txn.insert(_tblCache, movieJson);

        // Data baru akan mengganti data lama jika memiliki id yang sama (sesuai ConflictAlgorithm.replace).
        // Aplikasi lebih stabil dan aman saat caching ulang.
        txn.insert(
          _tblCacheTv,
          movieJson,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTvSeries(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheTv,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCacheTvSeries(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheTv,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  // untuk insert TV Series ke watchlist
  Future<int> insertWatchlistTv(TvSeriesTable tvTable) async {
    final db = await database;
    return await db!.insert(
      _tblWatchlistTv,
      tvTable.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Data lama diganti baru
    );
  }

  // untuk menghapus TV Series dari watchlist
  Future<int> removeWatchlistTv(TvSeriesTable tvTable) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [tvTable.id],
    );
  }

  // untuk mendapatkan TV Series berdasarkan ID
  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  // untuk mengambil semua data watchlist TV Series
  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlistTv);
    return results;
  }
}
