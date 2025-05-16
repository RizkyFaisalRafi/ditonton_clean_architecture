import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/movie.dart';
import 'package:ditonton_clean_architecture/domain/entities/movie_detail.dart';

/*
 * Jika Anda ingat pada diagram arsitektur sebelumnya, repository termasuk
 * ke dalam layer domain dan data. Seperti yang sudah dijelaskan sebelumnya,
 *
 * semakin dalam layer, maka sifatnya semakin abstrak. Sehingga, repository pada
 * domain layer berisi abstract class yang merupakan kontrak di mana di dalamnya
 * terdapat fungsi yang akan dipanggil oleh use case dan nilai yang akan dikembalikan.
 *
 * tipe data Either yang berasal dari package dartz.
 * Dartz merupakan sebuah package functional programming untuk Dart. Saat ini,
 * kita menggunakan dartz untuk membawa dan mengembalikan dua tipe data sekaligus.
 * Perhatikan bahwa setiap kita melakukan sebuah operasi, akan selalu ada kemungkinan
 * proses tersebut mengalami eror atau exception, sehingga tidak dapat mengembalikan
 * tipe yang diharapkan, seperti List<Movie>. Untuk itulah tipe Either<L, R> sangat
 * membantu kita khususnya dalam menangani skenario kegagalan pada sebuah proses dengan lebih mudah.
 */

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, List<Movie>>> getUpComing();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}