import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetTopRatedTv {
  final TvSeriesRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int page) {
    return repository.getTopRatedTv(page: page);
  }
}
