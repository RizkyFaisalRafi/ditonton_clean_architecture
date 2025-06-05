import 'package:dartz/dartz.dart';
import '../../../common/failure.dart';
import '../../entities/movies/movie.dart';
import '../../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(int page) {
    return repository.getNowPlayingMovies(page: page);
  }
}
