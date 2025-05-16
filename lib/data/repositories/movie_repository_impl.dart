import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/data/datasources/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/movie_table.dart';
import 'package:ditonton_clean_architecture/domain/entities/movie.dart';
import 'package:ditonton_clean_architecture/domain/entities/movie_detail.dart';
import 'package:ditonton_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';

import '../../common/network_info.dart';

/**
 * Repository pada data layer merupakan implementasi dari kontrak yang dibuat sebelumnya.
 * Repository akan bertugas untuk menyediakan data yang dibutuhkan oleh use case.
 * Bagian ini juga merupakan facade yang menggabungkan data dari sumber data (data source)
 * lokal maupun remote. Di sini kita bisa melakukan pengecekan apakah perangkat terhubung
 * dengan koneksi internet lalu menentukan data source mana yang akan digunakan.
 * Pada bagian ini kita mengonversi model menjadi domain model (entity).
 */
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
  //   networkInfo.isConnected;
  //   try {
  //     final result = await remoteDataSource.getNowPlayingMovies();
  //
  //     localDataSource.cacheNowPlayingMovies(
  //       result.map((movie) => MovieTable.fromDTO(movie)).toList(),
  //     );
  //
  //     return Right(result.map((model) => model.toEntity()).toList());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }

  /**
   * Penanganan untuk SocketException sudah tidak diperlukan lagi karena akan
   * terdeteksi pada NetworkInfo. Kita bisa menghapusnya untuk mengurangi duplikasi.
   */
  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingMovies();
        // Memanggil cacheNowPlayingMovies
        localDataSource.cacheNowPlayingMovies(
          result.map((movie) => MovieTable.fromDTO(movie)).toList(),
        );
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCachedNowPlayingMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    networkInfo.isConnected;
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  // @override
  // Future<Either<Failure, List<Movie>>> getPopularMovies() async {
  //   networkInfo.isConnected;
  //   try {
  //     final result = await remoteDataSource.getPopularMovies();
  //     return Right(result.map((model) => model.toEntity()).toList());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularMovies();
        // Memanggil cachePopularMovies
        localDataSource.cachePopularMovies(
          result.map((movie) => MovieTable.fromDTO(movie)).toList(),
        );
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCachedPopularMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    // networkInfo.isConnected;
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedMovies();
        // Memanggil cacheTopRatedMovies
        localDataSource.cacheTopRatedMovies(
          result.map((movie) => MovieTable.fromDTO(movie)).toList(),
        );
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedTopRatedMovies();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  // @override
  // Future<Either<Failure, List<Movie>>> getPopularMovies() async {
  //   networkInfo.isConnected;
  //   try {
  //     final result = await remoteDataSource.getPopularMovies();
  //     return Right(result.map((model) => model.toEntity()).toList());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }

  @override
  Future<Either<Failure, List<Movie>>> getUpComing() async {
    try {
      final result = await remoteDataSource.getUpComingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final result = await remoteDataSource.searchMovies(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    try {
      final result = await localDataSource.insertWatchlist(
        MovieTable.fromEntity(movie),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    try {
      final result = await localDataSource.removeWatchlist(
        MovieTable.fromEntity(movie),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
