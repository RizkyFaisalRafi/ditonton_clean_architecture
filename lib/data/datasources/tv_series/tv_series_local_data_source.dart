import 'package:ditonton_clean_architecture/data/models/tv_series/tv_series_table.dart';
import '../../../common/exception.dart';
import '../db/database_helper.dart';

abstract class TvSeriesLocalDatasource {
  Future<void> cacheAiringTodayTvSeries(List<TvSeriesTable> tv);

  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tv);

  Future<List<TvSeriesTable>> getCachedAiringTodayTv();

  Future<List<TvSeriesTable>> getCachedOnTheAirTv();

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
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<void> cacheAiringTodayTvSeries(List<TvSeriesTable> tv) async {
    await databaseHelper.clearCacheTvSeries('airing today');
    await databaseHelper.insertCacheTransactionTvSeries(tv, 'airing today');
  }

  @override
  Future<List<TvSeriesTable>> getCachedAiringTodayTv() async {
    final result = await databaseHelper.getCacheTvSeries('airing today');
    if (result.length > 0) {
      return result.map((data) => TvSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<void> cacheOnTheAirTvSeries(List<TvSeriesTable> tv) async {
    await databaseHelper.clearCacheTvSeries('on the air');
    await databaseHelper.insertCacheTransactionTvSeries(tv, 'on the air');
  }

  @override
  Future<List<TvSeriesTable>> getCachedOnTheAirTv() async {
    final result = await databaseHelper.getCacheTvSeries('on the air');
    if (result.length > 0) {
      return result.map((data) => TvSeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
