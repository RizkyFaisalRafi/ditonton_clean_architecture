import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/repositories/movie_repository.dart';

class GetUpComingMovies {
  final MovieRepository movieRepository;

  GetUpComingMovies(this.movieRepository);

  Future<Either<Failure, List<Movie>>> execute(int page) {
    return movieRepository.getUpComingMovies(page: page);
  }
}
