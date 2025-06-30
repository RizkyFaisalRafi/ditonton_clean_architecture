import 'dart:io';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import '../../module/tv_series.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;

  final TvSeriesLocalDatasource localDataSource;
  final NetworkInfo networkInfo;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getAiringToday({
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getAiringToday(page: page);

        // Memanggil cacheAiringTodayTvSeries
        localDataSource.cacheAiringTodayTvSeries(
          result.map((tv) => TvSeriesTable.fromDTO(tv)).toList(),
        );

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedAiringTodayTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getOnTheAir({
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getOnTheAir(page: page);

        // Memanggil cacheOnTheAirTvSeries
        localDataSource.cacheOnTheAirTvSeries(
          result.map((tv) => TvSeriesTable.fromDTO(tv)).toList(),
        );

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedOnTheAirTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTv({
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTv(page: page);

        // Memanggil cachePopularTvSeries
        localDataSource.cachePopularTvSeries(
          result.map((tv) => TvSeriesTable.fromDTO(tv)).toList(),
        );

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedPopularTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTv({
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedTv(page: page);

        // Memanggil cacheTopRatedTvSeries
        localDataSource.cacheTopRatedTvSeries(
          result.map((tv) => TvSeriesTable.fromDTO(tv)).toList(),
        );

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedTopRatedTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvDetail(id);

        // Simpan ke cache
        await localDataSource.cacheTvDetail(
          TvSeriesDetailTable.fromEntity(result.toEntity()),
        );

        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final cachedResult = await localDataSource.getCachedTvDetail(id);
        return Right(cachedResult.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure('Server Failure'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetail? tv) async {
    try {
      if (tv == null) {
        return Left(DatabaseFailure("Can not be null"));
      }
      final result = await localDataSource.insertWatchlist(
        TvSeriesTable.fromEntity(tv),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv) async {
    try {
      final result = await localDataSource.removeWatchlist(
        TvSeriesTable.fromEntity(tv),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTv() async {
    try {
      final result = await localDataSource.getWatchlistTv();
      return Right(result.map((data) => data.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isAddedToWatchlist(int id) async {
    try {
      final result = await localDataSource.getTvSeriesById(id);
      return Right(result != null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.searchTvSeries(query);
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
