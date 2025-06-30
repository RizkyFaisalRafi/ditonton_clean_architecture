import 'package:dartz/dartz.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';
import 'package:core/module/core.dart';

class GetUpComingMovies {
  final MovieRepository movieRepository;

  GetUpComingMovies(this.movieRepository);

  Future<Either<Failure, List<Movie>>> execute(int page) {
    return movieRepository.getUpComingMovies(page: page);
  }
}
