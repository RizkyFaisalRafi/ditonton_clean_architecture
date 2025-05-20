import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringToday();

  Future<Either<Failure, TvDetail>> getTvDetail(int id);

  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id);
}
