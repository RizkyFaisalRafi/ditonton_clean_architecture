import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetOnTheAirTv {
  final TvSeriesRepository repository;

  GetOnTheAirTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int page) {
    return repository.getOnTheAir(page: page);
  }
}
