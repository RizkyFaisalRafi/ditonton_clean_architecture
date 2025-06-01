import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';
import '../../../common/failure.dart';

class SaveWatchlistTv {
  final TvSeriesRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
