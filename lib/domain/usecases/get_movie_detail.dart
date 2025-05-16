import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

/*
 * Penjelasan Use Case
 * Use case merupakan kelas di mana logika bisnis dijalankan.
 * Karena merupakan logika bisnis, kelas use case umumnya diberi nama dengan
 * kata kerja seperti GetPopularMovies atau SearchMovies.
 *
 * Use case hanya memiliki satu function publik yaitu execute
 * yang bisa diakses oleh presentation layer.
 */

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
