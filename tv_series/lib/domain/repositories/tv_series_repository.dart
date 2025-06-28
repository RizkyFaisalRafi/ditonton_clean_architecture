import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_detail.dart';
import '../entities/tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringToday({required int page});

  Future<Either<Failure, List<TvSeries>>> getOnTheAir({required int page});

  Future<Either<Failure, List<TvSeries>>> getPopularTv({required int page});

  Future<Either<Failure, List<TvSeries>>> getTopRatedTv({required int page});

  Future<Either<Failure, TvDetail>> getTvDetail(int id);

  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id);

  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);

  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);

  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);

  Future<Either<Failure, bool>> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvSeries>>> getWatchlistTv();
}
