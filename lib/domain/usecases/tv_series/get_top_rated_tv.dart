import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import '../../../common/failure.dart';
import '../../repositories/tv_series_repository.dart';

class GetTopRatedTv {
  final TvSeriesRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int page) {
    return repository.getTopRatedTv(page: page);
  }
}
