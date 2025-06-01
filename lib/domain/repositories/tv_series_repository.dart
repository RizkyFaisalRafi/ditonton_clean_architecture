import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringToday();

  Future<Either<Failure, TvDetail>> getTvDetail(int id);

  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id);

  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);

  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);

  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();

}
