import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../entities/movies/movie.dart';
import '../../repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(int page) {
    return repository.getPopularMovies(page: page);
  }
}