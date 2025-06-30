import 'dart:io';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  // Set Up
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDatasource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockDatabaseHelper mockDatabaseHelper;

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

  final tTvSeries = tTvSeriesModel.toEntity();
  final tTvSeriesModelList = <TvModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];
  const tPage = 1;

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

  final tTvDetail = TvDetail.watchlist(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    backdropPath: 'backdropPath',
    overview: 'overview',
    voteAverage: 9.0,
    genres: [Genre(id: 1, name: 'Action')],
    popularity: 8.0,
    createdBy: [
      CreatedBy(
        id: 1211936,
        creditId: '52532f8a19c2957940006873',
        name: 'Robert D. Cardona',
        originalName: 'Robert D. Cardona',
        gender: 2,
        profilePath: '/profilePath.jpg',
      ),
    ],
    seasons: [
      Season(
        airDate: '1989-04-04',
        episodeCount: 13,
        id: 1,
        name: 'Season 1',
        overview: 'overview',
        posterPath: '/posterPath.jpg',
        seasonNumber: 1,
        voteAverage: 8.0,
      ),
    ],
    lastEpisodeToAir: EpisodeToAir(
      id: 1,
      name: 'Bigg Freeze',
      overview: 'overview',
      voteAverage: 7.9,
      voteCount: 9,
      airDate: '1989-06-27',
      episodeNumber: 13,
      episodeType: 'finale',
      productionCode: 'productionCode',
      runtime: 15,
      seasonNumber: 1,
      showId: 23,
      stillPath: 'stillPath',
    ),
    nextEpisodeToAir: EpisodeToAir(
      id: 2,
      name: 'Bigg Freeze',
      overview: 'overview',
      voteAverage: 7.9,
      voteCount: 9,
      airDate: '1989-06-27',
      episodeNumber: 13,
      episodeType: 'finale',
      productionCode: 'productionCode',
      runtime: 15,
      seasonNumber: 1,
      showId: 23,
      stillPath: 'stillPath',
    ),
  );

  final tTvDetailTable = TvSeriesDetailTable.fromEntity(tTvDetail);

  // Fungsi untuk menjalankan pengujian saat online
  void runTestsOnline(Function body) {
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  // Fungsi untuk menjalankan pengujian saat offline
  void runTestsOffline(Function body) {
    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

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

  // Helper function to test cache operations
  void testCacheOperations(
    String cacheType,
    Future<void> Function(List<TvSeriesTable>) cacheFunction,
    Future<List<TvSeriesTable>> Function() getCacheFunction,
    Future<Either<Failure, List<TvSeries>>> Function(int) repositoryFunction,
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
    Future<Either<Failure, List<TvSeries>>> Function(int) repositoryFunction,
    Future<List<TvModel>> Function(int) remoteFunction,
    Future<void> Function(List<TvSeriesTable>) cacheFunction,
    Future<List<TvSeriesTable>> Function() getCacheFunction,
  ) {
    group(description, () {
      runTestsOnline(() {
        test('should check if the device is online', () async {
          when(remoteFunction(tPage)).thenAnswer((_) async => []);
          await repositoryFunction(tPage);
          verify(mockNetworkInfo.isConnected);
        });

        test(
          'should return tv series list when call to data source is successful',
          () async {
            when(
              remoteFunction(tPage),
            ).thenAnswer((_) async => tTvSeriesModelList);
            final result = await repositoryFunction(tPage);
            verify(remoteFunction(tPage));
            expect(result.getOrElse(() => []), tTvSeriesList);
          },
        );

        test(
          'should cache data when call to remote data source is successful',
          () async {
            when(
              remoteFunction(tPage),
            ).thenAnswer((_) async => tTvSeriesModelList);
            await repositoryFunction(tPage);
            verify(remoteFunction(tPage));
            verify(cacheFunction([testTvCache]));
          },
        );

        test(
          'should return server failure when call is unsuccessful',
          () async {
            when(remoteFunction(tPage)).thenThrow(ServerException());
            final result = await repositoryFunction(tPage);
            expect(result, Left(ServerFailure('Server Failure')));
          },
        );

        test('should handle empty response from server', () async {
          when(remoteFunction(tPage)).thenAnswer((_) async => []);
          final result = await repositoryFunction(tPage);
          expect(result.getOrElse(() => []), isEmpty);
        });
      });

      runTestsOffline(() {
        // Memastikan bahwa data cache tersedia
        test('should return cached data when available', () async {
          when(getCacheFunction()).thenAnswer((_) async => [testTvCache]);
          final result = await repositoryFunction(tPage);
          verify(getCacheFunction());
          expect(result.getOrElse(() => []), [testTvFromCache]);
        });

        // Memastikan bahwa tidak ada data cache -> error bertipe CacheFailure.
        test('should return CacheFailure when no cache exists', () async {
          when(getCacheFunction()).thenThrow(CacheException('No Cache'));
          final result = await repositoryFunction(tPage);
          verify(getCacheFunction());
          expect(result, Left(CacheFailure('No Cache')));
        });

        // Memastikan bahwa saat offline (fungsi tidak memanggil sumber data dari remote (API))
        test('should not call remote data source when offline', () async {
          when(getCacheFunction()).thenAnswer((_) async => [testTvCache]);
          await repositoryFunction(tPage);
          verifyNever(remoteFunction(tPage));
        });

        // menangani data cache yang sebagian (partial cache), yaitu data yang hanya berisi sebagian data cache
        test('should handle partial cache data', () async {
          final partialCache = TvSeriesTable(
            id: 1,
            name: 'Partial Movie',
            posterPath: null,
            overview: 'Overview',
          );
          when(getCacheFunction()).thenAnswer((_) async => [partialCache]);
          final result = await repositoryFunction(tPage);
          expect(result.getOrElse(() => []), isNotEmpty);
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
    (page) => repository.getAiringToday(page: page),
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
    (page) => repository.getOnTheAir(page: page),
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
    (page) => repository.getPopularTv(page: page),
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
    (page) => repository.getTopRatedTv(page: page),
  );

  // Test scenarios for different tv series list types
  testTvListScenarios(
    'Airing Today Tv Series',
    (page) => repository.getAiringToday(page: page),
    (page) => mockRemoteDataSource.getAiringToday(page: page),
    (tvSeries) => mockLocalDataSource.cacheAiringTodayTvSeries(tvSeries),
    () => mockLocalDataSource.getCachedAiringTodayTv(),
  );

  testTvListScenarios(
    'On The Air Tv Series',
    (page) => repository.getOnTheAir(page: page),
    (page) => mockRemoteDataSource.getOnTheAir(page: page),
    (tvSeries) => mockLocalDataSource.cacheOnTheAirTvSeries(tvSeries),
    () => mockLocalDataSource.getCachedOnTheAirTv(),
  );

  testTvListScenarios(
    'Popular Tv Series',
    (page) => repository.getPopularTv(page: page),
    (page) => mockRemoteDataSource.getPopularTv(page: page),
    (tvSeries) => mockLocalDataSource.cachePopularTvSeries(tvSeries),
    () => mockLocalDataSource.getCachedPopularTv(),
  );

  testTvListScenarios(
    'Top Rated Tv Series',
    (page) => repository.getTopRatedTv(page: page),
    (page) => mockRemoteDataSource.getTopRatedTv(page: page),
    (tvSeries) => mockLocalDataSource.cacheTopRatedTvSeries(tvSeries),
    () => mockLocalDataSource.getCachedTopRatedTv(),
  );

  group('Get Tv Detail', () {
    runTestsOnline(() {
      /// Memeriksa apakah aplikasi terhubung dengan internet?
      test('should check if the device is online', () async {
        // Arrange
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
          expect(result, Left(ServerFailure('Server Failure')));
        },
      );

      // Additional edge cases
      test('should handle invalid tv series ID', () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(-1)).thenThrow(ServerException());

        // act & assert
        final result = await repository.getTvDetail(-1);
        expect(result, Left(ServerFailure('Server Failure')));
      });

      test('should handle malformed response data', () async {
        final malformedResponse = TvDetailResponse(
          adult: false,
          backdropPath: '',
          createdBy: [],
          episodeRunTime: [],
          firstAirDate: '',
          genres: [],
          homepage: '',
          id: tId,
          inProduction: true,
          languages: [],
          lastAirDate: '',
          lastEpisodeToAir: EpisodeToAirModel(
            id: 1,
            name: 'Bigg Freeze',
            overview: 'overview',
            voteAverage: 7.9,
            voteCount: 9,
            airDate: '1989-06-27',
            episodeNumber: 13,
            episodeType: 'finale',
            productionCode: 'productionCode',
            runtime: 15,
            seasonNumber: 1,
            showId: 23,
            stillPath: 'stillPath',
          ),
          name: '',
          nextEpisodeToAir: EpisodeToAirModel(
            id: 1,
            name: 'Bigg Freeze',
            overview: 'overview',
            voteAverage: 7.9,
            voteCount: 9,
            airDate: '1989-06-27',
            episodeNumber: 13,
            episodeType: 'finale',
            productionCode: 'productionCode',
            runtime: 15,
            seasonNumber: 1,
            showId: 23,
            stillPath: 'stillPath',
          ),
          networks: [],
          numberOfEpisodes: 0,
          numberOfSeasons: 0,
          originCountry: [],
          originalLanguage: '',
          originalName: '',
          overview: '',
          popularity: 0,
          posterPath: '',
          productionCompanies: [],
          seasons: [],
          status: '',
          tagline: '',
          voteAverage: 0,
          voteCount: 0,
        );
        when(
          mockRemoteDataSource.getTvDetail(tId),
        ).thenAnswer((_) async => malformedResponse);
        final result = await repository.getTvDetail(tId);
        expect(result.getOrElse(() => throw Exception()), isA<TvDetail>());
      });
    });

    runTestsOffline(() {
      test(
        'should return cached data when the device is offline and data is available in cache',
        () async {
          // Arrange: Atur mock untuk mengembalikan data dari cache lokal
          when(
            mockLocalDataSource.getCachedTvDetail(tId),
          ).thenAnswer((_) async => tTvDetailTable);

          // Act: Panggil fungsi yang diuji
          final result = await repository.getTvDetail(tId);

          // Assert: Verifikasi hasilnya
          verifyZeroInteractions(
            mockRemoteDataSource,
          ); // Pastikan tidak ada interaksi dengan remote
          verify(mockLocalDataSource.getCachedTvDetail(tId));
          expect(result, equals(Right(tTvDetail)));
        },
      );

      test(
        'should return CacheFailure when data is not available in cache',
        () async {
          // Arrange: Atur mock untuk melempar CacheException dari lokal
          when(
            mockLocalDataSource.getCachedTvDetail(tId),
          ).thenThrow(CacheException('No tv detail cache'));

          // Act: Panggil fungsi yang diuji
          final result = await repository.getTvDetail(tId);

          // Assert: Verifikasi hasilnya adalah CacheFailure
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedTvDetail(tId));
          // Membandingkan dengan objek Left yang spesifik
          expect(result, equals(Left(CacheFailure('No tv detail cache'))));
        },
      );

      test(
        'should return ConnectionFailure when device is offline and socket exception occurs',
        () async {
          // Arrange: Atur mock untuk melempar SocketException dari lokal (sesuai kode)
          when(mockLocalDataSource.getCachedTvDetail(tId)).thenThrow(
            const SocketException('Failed to connect to the network'),
          );

          // Act
          final result = await repository.getTvDetail(tId);

          // Assert
          expect(
            result,
            Left(ConnectionFailure('Failed to connect to the network')),
          );
        },
      );

      // test(
      //   'should return connection failure when the device is not connected to internet',
      //   () async {
      //     // arrange
      //     when(
      //       mockRemoteDataSource.getTvDetail(tId),
      //     ).thenThrow(SocketException('Failed to connect to the network'));
      //     // act
      //     final result = await repository.getTvDetail(tId);
      //     // assert
      //     verify(mockRemoteDataSource.getTvDetail(tId));
      //     expect(
      //       result,
      //       equals(Left(ConnectionFailure('Failed to connect to the network'))),
      //     );
      //   },
      // );
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

    test('should return server failure when call is unsuccessful', () async {
      // arrange
      when(
        mockRemoteDataSource.getTvRecommendations(tId),
      ).thenThrow(ServerException());

      // act & assert
      final result = await repository.getTvRecommendations(tId);
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, Left(ServerFailure('Server Failure')));
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

    test('should handle invalid tv recommendation ID', () async {
      when(
        mockRemoteDataSource.getTvRecommendations(-1),
      ).thenThrow(ServerException());
      final result = await repository.getTvRecommendations(-1);
      expect(result, Left(ServerFailure('Server Failure')));
    });

    test('should handle partial recommendation data', () async {
      final partialModel = TvModel(
        adult: false,
        backdropPath: '',
        genreIds: [],
        id: tId,
        originCountry: [],
        originalLanguage: '',
        originalName: '',
        overview: '',
        popularity: 0,
        posterPath: '',
        firstAirDate: '',
        name: '',
        voteAverage: 0,
        voteCount: 0,
      );
      when(
        mockRemoteDataSource.getTvRecommendations(tId),
      ).thenAnswer((_) async => [partialModel]);
      final result = await repository.getTvRecommendations(tId);
      expect(result.getOrElse(() => []), isNotEmpty);
    });
  });

  /// Done
  group('Search TvSeries', () {
    final tQuery = 'gutezeiten';
    const tEmptyQuery = '';
    const tSpecialCharQuery = 'gute-zeiten';
    final tLongQuery = 'a' * 1000;
    const tNonEnglishQuery = 'الأوقات الجميلة'; // Arabic for gute Zeiten

    runTestsOnline(() {
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

      test('should return ServerFailure when call is unsuccessful', () async {
        // arrange
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenThrow(ServerException());

        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        expect(result, Left(ServerFailure('Server Failure')));
      });

      test('should handle empty query', () async {
        when(
          mockRemoteDataSource.searchTvSeries(tEmptyQuery),
        ).thenAnswer((_) async => []);
        final result = await repository.searchTvSeries(tEmptyQuery);
        expect(result.getOrElse(() => []), isEmpty);
      });

      test('should handle special characters in query', () async {
        when(
          mockRemoteDataSource.searchTvSeries(tSpecialCharQuery),
        ).thenAnswer((_) async => tTvSeriesModelList);
        final result = await repository.searchTvSeries(tSpecialCharQuery);
        expect(result.getOrElse(() => []), isNotEmpty);
      });

      test('should handle very long queries', () async {
        when(
          mockRemoteDataSource.searchTvSeries(tLongQuery),
        ).thenAnswer((_) async => tTvSeriesModelList);
        final result = await repository.searchTvSeries(tLongQuery);
        expect(result.getOrElse(() => []), isNotEmpty);
      });

      test('should handle non-English queries', () async {
        when(
          mockRemoteDataSource.searchTvSeries(tNonEnglishQuery),
        ).thenAnswer((_) async => tTvSeriesModelList);
        final result = await repository.searchTvSeries(tNonEnglishQuery);
        expect(result.getOrElse(() => []), isNotEmpty);
      });

      test('should handle whitespace-only queries', () async {
        when(
          mockRemoteDataSource.searchTvSeries('   '),
        ).thenAnswer((_) async => []);
        final result = await repository.searchTvSeries('   ');
        expect(result.getOrElse(() => []), isEmpty);
      });

      test(
        'searchMovies should return same results regardless of query case',
        () async {
          when(
            mockRemoteDataSource.searchTvSeries('SPIDERMAN'),
          ).thenAnswer((_) async => tTvSeriesModelList);
          final result = await repository.searchTvSeries('SPIDERMAN');
          expect(result.getOrElse(() => []), isNotEmpty);
        },
      );
    });

    runTestsOffline(() {
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
    });
  });

  /// Not Yet
  group('Watchlist Operations', () {
    final tvDetail = TvDetail(
      adult: false,
      backdropPath: '',
      createdBy: [],
      episodeRunTime: [],
      firstAirDate: '',
      genres: [],
      homepage: '',
      id: -3,
      inProduction: false,
      lastAirDate: '',
      lastEpisodeToAir: EpisodeToAir(
        id: 0,
        name: '',
        overview: '',
        voteAverage: 0,
        voteCount: 0,
        airDate: '',
        episodeNumber: 0,
        episodeType: '',
        productionCode: '',
        runtime: 0,
        seasonNumber: 0,
        showId: 0,
        stillPath: '',
      ),
      name: '',
      nextEpisodeToAir: EpisodeToAir(
        id: 0,
        name: '',
        overview: '',
        voteAverage: 0,
        voteCount: 0,
        airDate: '',
        episodeNumber: 0,
        episodeType: '',
        productionCode: '',
        runtime: 0,
        seasonNumber: 0,
        showId: 0,
        stillPath: '',
      ),
      numberOfEpisodes: 0,
      numberOfSeasons: 0,
      overview: '',
      popularity: 0.0,
      posterPath: '',
      productionCompanies: [],
      seasons: [],
      status: '',
      voteAverage: 0.0,
      voteCount: 0,
    );

    // final nonExistentTv = TvDetail(
    //   adult: false,
    //   backdropPath: '',
    //   genres: [],
    //   id: -999,
    //   originalTitle: '',
    //   overview: '',
    //   posterPath: '',
    //   releaseDate: '',
    //   runtime: 0,
    //   title: '',
    //   voteAverage: 0,
    //   voteCount: 0,
    // );

    final corruptedTable = TvSeriesTable(
      id: 1,
      name: 'Corrupted',
      posterPath: '',
      overview: '',
    );

    group('save watchlist', () {
      test('should return success message when saving successful', () async {
        when(
          mockLocalDataSource.insertWatchlist(testTvTable),
        ).thenAnswer((_) async => 'Added to Watchlist');
        final result = await repository.saveWatchlist(testTvDetail);
        expect(result, Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving unsuccessful', () async {
        when(
          mockLocalDataSource.insertWatchlist(testTvTable),
        ).thenThrow(DatabaseException('Failed to add watchlist'));
        final result = await repository.saveWatchlist(testTvDetail);
        expect(result, Left(DatabaseFailure('Failed to add watchlist')));
      });

      test('should handle null tv detail', () async {
        final result = await repository.saveWatchlist(null);
        expect(result, isA<Left<Failure, String>>());
        expect(result, Left(DatabaseFailure("Can not be null")));
      });

      test('should handle invalid tv data', () async {
        when(
          mockLocalDataSource.insertWatchlist(any),
        ).thenThrow(DatabaseException('Invalid data'));
        final result = await repository.saveWatchlist(tvDetail);
        expect(result, isA<Left<Failure, String>>());
      });

      test('should handle duplicate tv save', () async {
        when(
          mockLocalDataSource.insertWatchlist(testTvTable),
        ).thenThrow(DatabaseException('TV already in watchlist'));
        final result = await repository.saveWatchlist(testTvDetail);
        expect(result, Left(DatabaseFailure('TV already in watchlist')));
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

      test('should return DatabaseFailure when remove unsuccessful', () async {
        when(
          mockLocalDataSource.removeWatchlist(testTvTable),
        ).thenThrow(DatabaseException('Failed to remove watchlist'));
        final result = await repository.removeWatchlist(testTvDetail);
        expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
      });

      test('should handle removing non-existent tv', () async {
        when(
          mockLocalDataSource.removeWatchlist(any),
        ).thenThrow(DatabaseException('TV not in watchlist'));
        final result = await repository.removeWatchlist(tvDetail);
        expect(result, isA<Left<Failure, String>>());
      });

      test('should handle removing already removed movie', () async {
        when(
          mockLocalDataSource.removeWatchlist(testTvTable),
        ).thenThrow(DatabaseException('TV not found'));
        final result = await repository.removeWatchlist(testTvDetail);
        expect(result, Left(DatabaseFailure('TV not found')));
      });
    });

    group('get watchlist status', () {
      test('should return false when data is not found', () async {
        when(
          mockLocalDataSource.getTvSeriesById(tId),
        ).thenAnswer((_) async => null);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, Right(false));
      });

      test('should return true when data is found', () async {
        when(
          mockLocalDataSource.getTvSeriesById(tId),
        ).thenAnswer((_) async => testTvTable);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, Right(true));
      });

      test('should handle invalid tv series ID', () async {
        when(
          mockLocalDataSource.getTvSeriesById(-1),
        ).thenAnswer((_) async => null);
        final result = await repository.isAddedToWatchlist(-1);
        expect(result, Right(false));
      });

      test('should handle database errors', () async {
        when(
          mockLocalDataSource.getTvSeriesById(tId),
        ).thenThrow(DatabaseException('Database error'));
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, Left(DatabaseFailure('Database error')));
      });

      test('should handle corrupted tv data', () async {
        when(
          mockLocalDataSource.getTvSeriesById(tId),
        ).thenAnswer((_) async => corruptedTable);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, Right(true));
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
        expect(result, Left(DatabaseFailure('Database error')));
      });

      test('should handle corrupted watchlist data', () async {
        when(
          mockLocalDataSource.getWatchlistTv(),
        ).thenAnswer((_) async => [corruptedTable]);
        final result = await repository.getWatchlistTv();
        expect(result.getOrElse(() => []), isNotEmpty);
      });

      test('should handle multiple watchlist items', () async {
        final anotherTvTable = TvSeriesTable(
          id: 2,
          name: 'Another TV',
          posterPath: '/another.jpg',
          overview: 'Another overview',
        );
        when(
          mockLocalDataSource.getWatchlistTv(),
        ).thenAnswer((_) async => [testTvTable, anotherTvTable]);
        final result = await repository.getWatchlistTv();
        expect(result.getOrElse(() => []).length, 2);
      });
    });
  });
}
