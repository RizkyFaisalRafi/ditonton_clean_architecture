import 'package:core/module/core.dart';
import '../../module/tv_series.dart';

abstract class TvSeriesLocalDatasource {
  Future<void> cacheAiringTodayTvSeries(List<TvSeriesTable> tv);

  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tv);

  Future<void> cachePopularTvSeries(List<TvSeriesTable> tv);

  Future<void> cacheTopRatedTvSeries(List<TvSeriesTable> tv);

  Future<void> cacheTvDetail(TvSeriesDetailTable tv);

  Future<List<TvSeriesTable>> getCachedAiringTodayTv();

  Future<List<TvSeriesTable>> getCachedOnTheAirTv();

  Future<List<TvSeriesTable>> getCachedPopularTv();

  Future<List<TvSeriesTable>> getCachedTopRatedTv();

  Future<TvSeriesDetailTable> getCachedTvDetail(int id);

  Future<String> insertWatchlist(TvSeriesTable tv);

  Future<String> removeWatchlist(TvSeriesTable tv);

  Future<TvSeriesTable?> getTvSeriesById(int id);

  Future<List<TvSeriesTable>> getWatchlistTv();
}

class TvSeriesLocalDatasourceImpl implements TvSeriesLocalDatasource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDatasourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvSeriesTable tv) async {
    try {
      await databaseHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTv() async {
    try {
      final result = await databaseHelper.getWatchlistTvSeries();
      return result.map((data) => TvSeriesTable.fromMap(data)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    try {
      final result = await databaseHelper.getTvSeriesById(id);
      if (result != null) {
        return TvSeriesTable.fromMap(result);
      } else {
        return null;
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> cacheAiringTodayTvSeries(List<TvSeriesTable> tv) async {
    try {
      await databaseHelper.clearCacheTvSeries('airing today');
      await databaseHelper.insertCacheTransactionTvSeries(tv, 'airing today');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvSeriesTable>> getCachedAiringTodayTv() async {
    try {
      final result = await databaseHelper.getCacheTvSeries('airing today');
      if (result.isNotEmpty) {
        return result.map((data) => TvSeriesTable.fromMap(data)).toList();
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
  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tv) async {
    try {
      await databaseHelper.clearCacheTvSeries('on the air');
      await databaseHelper.insertCacheTransactionTvSeries(tv, 'on the air');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvSeriesTable>> getCachedOnTheAirTv() async {
    try {
      final result = await databaseHelper.getCacheTvSeries('on the air');
      if (result.isNotEmpty) {
        return result.map((data) => TvSeriesTable.fromMap(data)).toList();
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
  Future<void> cachePopularTvSeries(List<TvSeriesTable> tv) async {
    try {
      await databaseHelper.clearCacheTvSeries('popular');
      await databaseHelper.insertCacheTransactionTvSeries(tv, 'popular');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvSeriesTable>> getCachedPopularTv() async {
    try {
      final result = await databaseHelper.getCacheTvSeries('popular');
      if (result.isNotEmpty) {
        return result.map((data) => TvSeriesTable.fromMap(data)).toList();
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
  Future<void> cacheTopRatedTvSeries(List<TvSeriesTable> tv) async {
    try {
      await databaseHelper.clearCacheTvSeries('top rated tv');
      await databaseHelper.insertCacheTransactionTvSeries(tv, 'top rated tv');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvSeriesTable>> getCachedTopRatedTv() async {
    try {
      final result = await databaseHelper.getCacheTvSeries('top rated tv');
      if (result.isNotEmpty) {
        return result.map((data) => TvSeriesTable.fromMap(data)).toList();
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
  Future<void> cacheTvDetail(TvSeriesDetailTable tv) async {
    try {
      await databaseHelper.insertCacheTvDetail(tv);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesDetailTable> getCachedTvDetail(int id) async {
    try {
      final result = await databaseHelper.getCachedTvDetail(id);
      if (result != null) {
        return TvSeriesDetailTable.fromMap(result);
      } else {
        throw CacheException("Tv detail not found, Please Check your Internet");
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
