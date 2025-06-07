import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';
import '../../../common/failure.dart';

class GetWatchListStatusTv {
  final TvSeriesRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<Either<Failure, bool>> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
