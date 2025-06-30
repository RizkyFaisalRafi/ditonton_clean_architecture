import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetPopularTv {
  final TvSeriesRepository repository;

  GetPopularTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int page) {
    return repository.getPopularTv(page: page);
  }
}
