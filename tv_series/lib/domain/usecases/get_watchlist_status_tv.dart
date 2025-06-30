import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import '../repositories/tv_series_repository.dart';

class GetWatchListStatusTv {
  final TvSeriesRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<Either<Failure, bool>> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
