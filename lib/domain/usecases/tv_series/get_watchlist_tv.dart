
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';

import '../../../common/failure.dart';

class GetWatchlistTv {
  final TvSeriesRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTv();
  }
}