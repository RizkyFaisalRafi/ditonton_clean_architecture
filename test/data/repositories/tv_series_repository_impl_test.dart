import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/genre_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/created_by_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/episode_to_air_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/production_companies_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/season_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_detail_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_series_table.dart';
import 'package:ditonton_clean_architecture/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  // Set Up
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDatasource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    mockDatabaseHelper = MockDatabaseHelper();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvModel(
    adult: false,
    backdropPath: "/ottT2Yt0OfHiHp3PHJTLNVV8JPE.jpg",
    genreIds: [18, 10766],
    id: 13945,
    originCountry: ["DE"],
    originalLanguage: "de",
    originalName: "Gute Zeiten, schlechte Zeiten",
    overview:
        "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
    popularity: 677.2062,
    posterPath: "/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg",
    firstAirDate: "1992-05-11",
    name: "Gute Zeiten, schlechte Zeiten",
    voteAverage: 5.769,
    voteCount: 39,
  );

  final tId = 1;
  final tTvDetailResponse = TvDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    createdBy: [
      CreatedByModel(
        id: 1,
        creditId: "creditId",
        name: "name",
        originalName: "originalName",
        gender: 1,
        profilePath: "profilePath",
      ),
    ],
    episodeRunTime: [1],
    firstAirDate: 'firstAirDate',
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: tId,
    inProduction: false,
    languages: [],
    lastAirDate: 'lastAirDate',
    lastEpisodeToAir: EpisodeToAirModel(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1.0,
      voteCount: 1,
      airDate: 'airDate',
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    ),
    name: 'name',
    nextEpisodeToAir: EpisodeToAirModel(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1.0,
      voteCount: 1,
      airDate: 'airDate',
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    ),
    networks: [
      ProductionCompaniesModel(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      ),
    ],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2.0,
    posterPath: 'posterPath',
    productionCompanies: [
      ProductionCompaniesModel(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      ),
    ],
    seasons: [
      SeasonModel(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
        voteAverage: 1.0,
      ),
    ],
    status: 'status',
    tagline: 'tagline',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = tTvSeriesModel.toEntity();
  final tTvSeriesModelList = <TvModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  // Helper function to test cache operations
  void testCacheOperations(
    String cacheType,
    Future<void> Function(List<TvSeriesTable>) cacheFunction,
    Future<List<TvSeriesTable>> Function() getCacheFunction,
    Future<Either<Failure, List<TvSeries>>> Function() repositoryFunction,
  ) {
    group('cache $cacheType tv series', () {
      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
      });

      test('should call database helper to save data', () async {
        when(
          mockDatabaseHelper.clearCacheTvSeries(cacheType),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransactionTvSeries([
            testTvCache,
          ], cacheType),
        ).thenAnswer((_) async => {});

        await cacheFunction([testTvCache]);

        verify(mockDatabaseHelper.clearCacheTvSeries(cacheType));
        verify(
          mockDatabaseHelper.insertCacheTransactionTvSeries([
            testTvCache,
          ], cacheType),
        );
      });

      test(
        'should return list of tv series from db when data exists',
        () async {
          when(
            mockDatabaseHelper.getCacheTvSeries(cacheType),
          ).thenAnswer((_) async => [testTvCacheMap]);

          final result = await getCacheFunction();
          expect(result, [testTvCache]);
        },
      );

      test(
        'should throw CacheException when cache data does not exist',
        () async {
          when(
            mockDatabaseHelper.getCacheTvSeries(cacheType),
          ).thenAnswer((_) async => []);
          final call = getCacheFunction();
          expect(() => call, throwsA(isA<CacheException>()));
        },
      );
    });
  }

  // Helper function to test online/offline scenarios
  void testTvListScenarios(
    String description,
    Future<Either<Failure, List<TvSeries>>> Function() repositoryFunction,
    Future<List<TvModel>> Function() remoteFunction,
    Future<void> Function(List<TvSeriesTable>) cacheFunction,
    Future<List<TvSeriesTable>> Function() getCacheFunction,
  ) {
    group(description, () {
      group('when device is online', () {
        setUp(
          () => when(mockNetworkInfo.isConnected).thenAnswer((_) async => true),
        );

        test('should check if the device is online', () async {
          when(remoteFunction()).thenAnswer((_) async => []);
          await repositoryFunction();
          verify(mockNetworkInfo.isConnected);
        });

        test('should return tv series list when call is successful', () async {
          when(remoteFunction()).thenAnswer((_) async => tTvSeriesModelList);
          final result = await repositoryFunction();
          verify(remoteFunction());
          expect(result.getOrElse(() => []), tTvSeriesList);
        });

        test('should cache data when call is successful', () async {
          when(remoteFunction()).thenAnswer((_) async => tTvSeriesModelList);
          await repositoryFunction();
          verify(remoteFunction());
          verify(cacheFunction([testTvCache]));
        });

        test('should return server failure when call fails', () async {
          when(remoteFunction()).thenThrow(ServerException());
          final result = await repositoryFunction();
          expect(result, Left(ServerFailure('')));
        });
      });

      group('when device is offline', () {
        setUp(
          () =>
              when(mockNetworkInfo.isConnected).thenAnswer((_) async => false),
        );

        test('should return cached data when available', () async {
          when(getCacheFunction()).thenAnswer((_) async => [testTvCache]);
          final result = await repositoryFunction();
          verify(getCacheFunction());
          expect(result.getOrElse(() => []), [testTvFromCache]);
        });

        test('should return CacheFailure when no cache exists', () async {
          when(getCacheFunction()).thenThrow(CacheException('No Cache'));
          final result = await repositoryFunction();
          verify(getCacheFunction());
          expect(result, Left(CacheFailure('No Cache')));
        });
      });
    });
  }

  /// Test cache operations for different tv series types
  testCacheOperations(
    'airing today',
    (tvSeries) => TvSeriesLocalDatasourceImpl(
      databaseHelper: mockDatabaseHelper,
    ).cacheAiringTodayTvSeries(tvSeries),
    () =>
        TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        ).getCachedAiringTodayTv(),
    () => repository.getAiringToday(),
  );

  testCacheOperations(
    'on the air',
    (tvSeries) => TvSeriesLocalDatasourceImpl(
      databaseHelper: mockDatabaseHelper,
    ).cacheOnTheAirTvSeries(tvSeries),
    () =>
        TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        ).getCachedOnTheAirTv(),
    () => repository.getOnTheAir(),
  );

  testCacheOperations(
    'popular',
    (tvSeries) => TvSeriesLocalDatasourceImpl(
      databaseHelper: mockDatabaseHelper,
    ).cachePopularTvSeries(tvSeries),
    () =>
        TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        ).getCachedPopularTv(),
    () => repository.getPopularTv(),
  );

  testCacheOperations(
    'top rated tv',
    (tvSeries) => TvSeriesLocalDatasourceImpl(
      databaseHelper: mockDatabaseHelper,
    ).cacheTopRatedTvSeries(tvSeries),
    () =>
        TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        ).getCachedTopRatedTv(),
    () => repository.getTopRatedTv(),
  );

  // Test scenarios for different tv series list types
  testTvListScenarios(
    'Airing Today Tv Series',
    () => repository.getAiringToday(),
    () => mockRemoteDataSource.getAiringToday(),
    (tvSeries) => mockLocalDataSource.cacheAiringTodayTvSeries(tvSeries),
    () => mockLocalDataSource.getCachedAiringTodayTv(),
  );

  testTvListScenarios(
    'On The Air Tv Series',
    () => repository.getOnTheAir(),
    () => mockRemoteDataSource.getOnTheAir(),
    (tvSeries) => mockLocalDataSource.cacheOnTheAirTvSeries(tvSeries),
    () => mockLocalDataSource.getCachedOnTheAirTv(),
  );

  testTvListScenarios(
    'Popular Tv Series',
    () => repository.getPopularTv(),
    () => mockRemoteDataSource.getPopularTv(),
    (tvSeries) => mockLocalDataSource.cachePopularTvSeries(tvSeries),
    () => mockLocalDataSource.getCachedPopularTv(),
  );

  testTvListScenarios(
    'Top Rated Tv Series',
    () => repository.getTopRatedTv(),
    () => mockRemoteDataSource.getTopRatedTv(),
    (tvSeries) => mockLocalDataSource.cacheTopRatedTvSeries(tvSeries),
    () => mockLocalDataSource.getCachedTopRatedTv(),
  );

  /// Done
  group('Get Tv Detail', () {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      /// Memeriksa apakah aplikasi terhubung dengan internet?
      test('should check if the device is online', () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.getTvDetail(tId),
        ).thenAnswer((_) async => tTvDetailResponse);

        // Act
        await repository.getTvDetail(tId);

        // Assert
        verify(mockNetworkInfo.isConnected);
      });

      test(
        'should return TvDetail data when the call to remote data source is successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getTvDetail(tId),
          ).thenAnswer((_) async => tTvDetailResponse);
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(result, equals(Right(testTvDetail)));
        },
      );

      test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getTvDetail(tId),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        },
      );

      // Additional edge cases
      test('should handle invalid tv series ID', () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(-1)).thenThrow(ServerException());

        // act & assert
        final result = await repository.getTvDetail(-1);
        expect(result, Left(ServerFailure('')));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return connection failure when the device is not connected to internet',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getTvDetail(tId),
          ).thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(
            result,
            equals(Left(ConnectionFailure('Failed to connect to the network'))),
          );
        },
      );
    });
  });

  /// Done
  group('Get Tv Recommendations', () {
    test('should return data when the call is successful', () async {
      // arrange
      when(
        mockRemoteDataSource.getTvRecommendations(tId),
      ).thenAnswer((_) async => tTvSeriesModelList);

      // act & assert
      final result = await repository.getTvRecommendations(tId);
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return server failure when call fails', () async {
      // arrange
      when(
        mockRemoteDataSource.getTvRecommendations(tId),
      ).thenThrow(ServerException());

      // act & assert
      final result = await repository.getTvRecommendations(tId);
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, Left(ServerFailure('')));
    });

    test('should return connection failure when no internet', () async {
      // arrange
      when(
        mockRemoteDataSource.getTvRecommendations(tId),
      ).thenThrow(SocketException('Failed to connect to the network'));

      // act & assert
      final result = await repository.getTvRecommendations(tId);
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(
        result,
        Left(ConnectionFailure('Failed to connect to the network')),
      );
    });

    test('should return empty list when no recommendations', () async {
      when(
        mockRemoteDataSource.getTvRecommendations(tId),
      ).thenAnswer((_) async => []);
      final result = await repository.getTvRecommendations(tId);
      expect(result.getOrElse(() => []), isEmpty);
    });
  });

  /// Done
  group('Search TvSeries', () {
    final tQuery = 'gutezeiten';

    test('should return tv list when call is successful', () async {
      // arrange
      when(
        mockRemoteDataSource.searchTvSeries(tQuery),
      ).thenAnswer((_) async => tTvSeriesModelList);

      // act
      final result = await repository.searchTvSeries(tQuery);

      // assert
      expect(result.getOrElse(() => []), tTvSeriesList);
    });

    test('should return ServerFailure when call fails', () async {
      // arrange
      when(
        mockRemoteDataSource.searchTvSeries(tQuery),
      ).thenThrow(ServerException());

      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when no internet', () async {
      // arrange
      when(
        mockRemoteDataSource.searchTvSeries(tQuery),
      ).thenThrow(SocketException('Failed to connect to the network'));

      // act
      final result = await repository.searchTvSeries(tQuery);

      // assert
      expect(
        result,
        Left(ConnectionFailure('Failed to connect to the network')),
      );
    });

    test('should handle empty query', () async {
      when(mockRemoteDataSource.searchTvSeries('')).thenAnswer((_) async => []);
      final result = await repository.searchTvSeries('');
      expect(result.getOrElse(() => []), isEmpty);
    });

    test('should handle special characters in query', () async {
      when(
        mockRemoteDataSource.searchTvSeries('gute-zeiten'),
      ).thenAnswer((_) async => tTvSeriesModelList);
      final result = await repository.searchTvSeries('gute-zeiten');
      expect(result.getOrElse(() => []), isNotEmpty);
    });
  });

  /// Done
  group('Watchlist Operations', () {
    group('save watchlist', () {
      test('should return success message when saving successful', () async {
        when(
          mockLocalDataSource.insertWatchlist(testTvTable),
        ).thenAnswer((_) async => 'Added to Watchlist');
        final result = await repository.saveWatchlist(testTvDetail);
        expect(result, Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving fails', () async {
        when(
          mockLocalDataSource.insertWatchlist(testTvTable),
        ).thenThrow(DatabaseException('Failed to add watchlist'));
        final result = await repository.saveWatchlist(testTvDetail);
        expect(result, Left(DatabaseFailure('Failed to add watchlist')));
      });

      test('should handle null tv detail', () async {
        final result = await repository.saveWatchlist(null);
        expect(result, isA<Left<Failure, String>>());
      });
    });

    group('remove watchlist', () {
      test('should return success message when remove successful', () async {
        when(
          mockLocalDataSource.removeWatchlist(testTvTable),
        ).thenAnswer((_) async => 'Removed from watchlist');
        final result = await repository.removeWatchlist(testTvDetail);
        expect(result, Right('Removed from watchlist'));
      });

      test('should return DatabaseFailure when remove fails', () async {
        when(
          mockLocalDataSource.removeWatchlist(testTvTable),
        ).thenThrow(DatabaseException('Failed to remove watchlist'));
        final result = await repository.removeWatchlist(testTvDetail);
        expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
      });
    });

    group('get watchlist status', () {
      final tId = 1;
      test('should return false when data is not found', () async {
        when(
          mockLocalDataSource.getTvSeriesById(tId),
        ).thenAnswer((_) async => null);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, false);
      });

      test('should return true when data is found', () async {
        when(
          mockLocalDataSource.getTvSeriesById(tId),
        ).thenAnswer((_) async => testTvTable);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, true);
      });

      test('should handle invalid tv series ID', () async {
        when(
          mockLocalDataSource.getTvSeriesById(-1),
        ).thenAnswer((_) async => null);
        final result = await repository.isAddedToWatchlist(-1);
        expect(result, false);
      });
    });

    group('get watchlist tv series', () {
      test('should return list of TvSeries', () async {
        when(
          mockLocalDataSource.getWatchlistTv(),
        ).thenAnswer((_) async => [testTvTable]);
        final result = await repository.getWatchlistTv();
        expect(result.getOrElse(() => []), [testWatchlistTv]);
      });

      test('should return empty list when no watchlist', () async {
        when(mockLocalDataSource.getWatchlistTv()).thenAnswer((_) async => []);
        final result = await repository.getWatchlistTv();
        expect(result.getOrElse(() => []), isEmpty);
      });

      test('should handle database exception', () async {
        when(
          mockLocalDataSource.getWatchlistTv(),
        ).thenThrow(DatabaseException('Database error'));
        final result = await repository.getWatchlistTv();
        expect(result, isA<Left<Failure, List<TvSeries>>>());
      });
    });
  });
}
