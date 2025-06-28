import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_series_repository.dart';

class GetTvDetail {
  final TvSeriesRepository repository;

  GetTvDetail({required this.repository});

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
