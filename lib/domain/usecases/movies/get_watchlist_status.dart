import 'package:dartz/dartz.dart';

import 'package:ditonton_clean_architecture/common/failure.dart';

import '../../repositories/movie_repository.dart';

class GetWatchListStatus {
  final MovieRepository repository;

  GetWatchListStatus(this.repository);

  Future<Either<Failure, bool>> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
