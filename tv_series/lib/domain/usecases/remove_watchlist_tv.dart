import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import '../repositories/tv_series_repository.dart';
import '../entities/tv_detail.dart';

class RemoveWatchlistTv {
  final TvSeriesRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}