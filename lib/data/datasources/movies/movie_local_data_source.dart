import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/data/datasources/db/database_helper.dart';
import 'package:ditonton_clean_architecture/data/models/movies/cache/movie_detail_table.dart';
import 'package:ditonton_clean_architecture/data/models/movies/cache/movie_table.dart';

/*
 * Sesuai namanya, data sources merupakan sumber data yang akan digunakan di dalam aplikasi.
 * Di sinilah kita banyak menggunakan package eksternal seperti sqflite, http,
 * shared_preferences, atau yang lainnya.
 */

abstract class MovieLocalDataSource {
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);

  Future<void> cachePopularMovies(List<MovieTable> movies);

  Future<void> cacheTopRatedMovies(List<MovieTable> movies);

  Future<void> cacheUpComingMovies(List<MovieTable> movies);

  Future<void> cacheMovieDetail(MovieDetailTable movie);

  Future<List<MovieTable>> getCachedNowPlayingMovies();

  Future<List<MovieTable>> getCachedPopularMovies();

  Future<List<MovieTable>> getCachedTopRatedMovies();

  Future<List<MovieTable>> getCachedUpComingMovies();

  Future<MovieDetailTable> getCachedMovieDetail(int id);

  Future<String> insertWatchlist(MovieTable movie);

  Future<String> removeWatchlist(MovieTable movie);

  Future<MovieTable?> getMovieById(int id);

  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlistMovie(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlistMovie(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  // @override
  // Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
  //   await databaseHelper.clearCache('now playing');
  //   await databaseHelper.insertCacheTransaction(movies, 'now playing');
  // }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    try {
      await databaseHelper.clearCache('now playing');
      await databaseHelper.insertCacheTransaction(movies, 'now playing');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  // @override
  // Future<List<MovieTable>> getCachedNowPlayingMovies() async {
  //   final result = await databaseHelper.getCacheMovies('now playing');
  //   return result.map((data) => MovieTable.fromMap(data)).toList();

  // tambahkan pengecekan jumlah data yang didapat dari database.
  // @override
  // Future<List<MovieTable>> getCachedNowPlayingMovies() async {
  //   final result = await databaseHelper.getCacheMovies('now playing');
  //   if (result.length > 0) {
  //     return result.map((data) => MovieTable.fromMap(data)).toList();
  //   } else {
  //     throw CacheException("Can't get the data :(");
  //   }
  // }

  @override
  Future<List<MovieTable>> getCachedNowPlayingMovies() async {
    try {
      final result = await databaseHelper.getCacheMovies('now playing');
      if (result.isNotEmpty) {
        return result.map((data) => MovieTable.fromMap(data)).toList();
      } else {
        throw CacheException("Can't get the data, Check your Connection :(");
      }
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      } else {
        throw DatabaseException(e.toString());
      }
    }
  }

  @override
  Future<void> cachePopularMovies(List<MovieTable> movies) async {
    try {
      await databaseHelper.clearCache('popular');
      await databaseHelper.insertCacheTransaction(movies, 'popular');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<MovieTable>> getCachedPopularMovies() async {
    try {
      final result = await databaseHelper.getCacheMovies('popular');
      if (result.length > 0) {
        return result.map((data) => MovieTable.fromMap(data)).toList();
      } else {
        throw CacheException("Can't get the data :(");
      }
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      } else {
        throw DatabaseException(e.toString());
      }
    }
  }

  @override
  Future<void> cacheTopRatedMovies(List<MovieTable> movies) async {
    try {
      await databaseHelper.clearCache('top rated');
      await databaseHelper.insertCacheTransaction(movies, 'top rated');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<MovieTable>> getCachedTopRatedMovies() async {
    try {
      final result = await databaseHelper.getCacheMovies('top rated');
      if (result.length > 0) {
        return result.map((data) => MovieTable.fromMap(data)).toList();
      } else {
        throw CacheException("Can't get the data :(");
      }
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      } else {
        throw DatabaseException(e.toString());
      }
    }
  }

  @override
  Future<void> cacheUpComingMovies(List<MovieTable> movies) async {
    try {
      await databaseHelper.clearCache('up coming');
      await databaseHelper.insertCacheTransaction(movies, 'up coming');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<MovieTable>> getCachedUpComingMovies() async {
    try {
      final result = await databaseHelper.getCacheMovies('up coming');
      if (result.length > 0) {
        return result.map((data) => MovieTable.fromMap(data)).toList();
      } else {
        throw CacheException("Can't get the data :(");
      }
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      } else {
        throw DatabaseException(e.toString());
      }
    }
  }

  @override
  Future<void> cacheMovieDetail(MovieDetailTable movieDetail) async {
    try {
      await databaseHelper.insertCacheMovieDetail(movieDetail);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieDetailTable> getCachedMovieDetail(int id) async {
    try {
      final result = await databaseHelper.getCachedMovieDetail(id);
      if (result != null) {
        return MovieDetailTable.fromMap(result);
      } else {
        throw CacheException("Movie detail not found, Please Check your Internet");
      }
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      } else {
        throw DatabaseException(e.toString());
      }
    }
  }
}
