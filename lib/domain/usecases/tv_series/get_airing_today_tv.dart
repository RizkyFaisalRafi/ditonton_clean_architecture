import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';

class GetAiringTodayTv {
  final TvSeriesRepository repository;

  GetAiringTodayTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getAiringToday();
  }
}
