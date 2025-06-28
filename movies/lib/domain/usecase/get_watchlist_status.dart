import 'package:dartz/dartz.dart';
import '../repositories/movie_repository.dart';
import 'package:core/module/core.dart';

class GetWatchListStatus {
  final MovieRepository repository;

  GetWatchListStatus(this.repository);

  Future<Either<Failure, bool>> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
