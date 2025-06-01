import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';
import '../../../common/failure.dart';
import '../../entities/tv/tv_detail.dart';

class RemoveWatchlistTv {
  final TvSeriesRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }
}