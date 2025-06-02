import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import '../../common/exception.dart';
import '../../common/network_info.dart';
import '../../domain/repositories/tv_series_repository.dart';
import '../models/tv_series/tv_series_table.dart';

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
  Future<Either<Failure, List<TvSeries>>> getAiringToday() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getAiringToday();

        // Memanggil cacheAiringTodayTvSeries
        localDataSource.cacheAiringTodayTvSeries(
          result.map((tv) => TvSeriesTable.fromDTO(tv)).toList(),
        );

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
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
  Future<Either<Failure, List<TvSeries>>> getOnTheAir() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getOnTheAir();

        // Memanggil cacheOnTheAirTvSeries
        localDataSource.cacheOnTheAirTvSeries(
          result.map((tv) => TvSeriesTable.fromDTO(tv)).toList(),
        );

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
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
  Future<Either<Failure, List<TvSeries>>> getPopularTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTv();

        // Memanggil cachePopularTvSeries
        localDataSource.cachePopularTvSeries(
          result.map((tv) => TvSeriesTable.fromDTO(tv)).toList(),
        );

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
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
  Future<Either<Failure, List<TvSeries>>> getTopRatedTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedTv();

        // Memanggil cacheTopRatedTvSeries
        localDataSource.cacheTopRatedTvSeries(
          result.map((tv) => TvSeriesTable.fromDTO(tv)).toList(),
        );

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
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
    networkInfo.isConnected;
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv) async {
    try {
      final result = await localDataSource.insertWatchlist(
        TvSeriesTable.fromEntity(tv),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
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
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
