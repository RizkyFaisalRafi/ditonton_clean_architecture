import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/genre_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/cache/movie_detail_table.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_detail_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/cache/movie_table.dart';
import 'package:ditonton_clean_architecture/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/genre.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockDatabaseHelper mockDatabaseHelper;

  // Test models
  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = tMovieModel.toEntity();
  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];
  const tPage = 1;

  // Movie detail test data
  final tId = 1;
  final tMovieResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 100,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "https://google.com",
    id: 1,
    imdbId: 'imdb1',
    originalLanguage: 'en',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 12000,
    runtime: 120,
    status: 'Status',
    tagline: 'Tagline',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );


  final tMovieDetail = MovieDetail.watchlist(
    id: 1,
    title: 'Spider-Man: No Way Home',
    overview: 'Peter Parker is unmasked...',
    posterPath: '/poster.jpg',
    runtime: 142,
    voteAverage: 8.7,
    releaseDate: '1994-09-23',
    genres: [Genre(id: 1, name: 'Comedy')],
  );

  final tMovieDetailTable = MovieDetailTable.fromEntity(tMovieDetail);

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
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockDatabaseHelper = MockDatabaseHelper();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  // Helper function to test cache operations
  void testCacheOperations(
    String cacheType,
    Future<void> Function(List<MovieTable>) cacheFunction,
    Future<List<MovieTable>> Function() getCacheFunction,
    Future<Either<Failure, List<Movie>>> Function(int) repositoryFunction,
  ) {
    group('cache $cacheType movies', () {
      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
      });

      test('should call database helper to save data', () async {
        when(
          mockDatabaseHelper.clearCache(cacheType),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], cacheType),
        ).thenAnswer((_) async => {});

        await cacheFunction([testMovieCache]);

        verify(mockDatabaseHelper.clearCache(cacheType));
        verify(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], cacheType),
        );
      });

      test('should return list of movies from db when data exist', () async {
        when(
          mockDatabaseHelper.getCacheMovies(cacheType),
        ).thenAnswer((_) async => [testMovieCacheMap]);

        final result = await getCacheFunction();
        expect(result, [testMovieCache]);
      });

      test(
        'should throw CacheException when cache data is not exist',
        () async {
          when(
            mockDatabaseHelper.getCacheMovies(cacheType),
          ).thenAnswer((_) async => []);
          final call = getCacheFunction();
          expect(() => call, throwsA(isA<CacheException>()));
        },
      );
    });
  }

  // Helper function to test online/offline scenarios
  void testMovieListScenarios(
    String description,
    Future<Either<Failure, List<Movie>>> Function(int) repositoryFunction,
    Future<List<MovieModel>> Function(int) remoteFunction,
    Future<void> Function(List<MovieTable>) cacheFunction,
    Future<List<MovieTable>> Function() getCacheFunction,
  ) {
    group(description, () {
      runTestsOnline(() {
        test('should check if the device is online', () async {
          when(remoteFunction(tPage)).thenAnswer((_) async => []);
          await repositoryFunction(tPage);
          verify(mockNetworkInfo.isConnected);
        });

        test(
          'should return movie list when call to data source is successful',
          () async {
            when(
              remoteFunction(tPage),
            ).thenAnswer((_) async => tMovieModelList);
            final result = await repositoryFunction(tPage);
            verify(remoteFunction(tPage));
            expect(result.getOrElse(() => []), tMovieList);
          },
        );

        test(
          'should cache data when call to remote data source is successful',
          () async {
            when(
              remoteFunction(tPage),
            ).thenAnswer((_) async => tMovieModelList);
            await repositoryFunction(tPage);
            verify(remoteFunction(tPage));
            verify(cacheFunction([testMovieCache]));
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
        test('should return cached data when available', () async {
          when(getCacheFunction()).thenAnswer((_) async => [testMovieCache]);
          final result = await repositoryFunction(tPage);
          verify(getCacheFunction());
          expect(result.getOrElse(() => []), [testMovieFromCache]);
        });

        test('should return CacheFailure when no cache exists', () async {
          when(getCacheFunction()).thenThrow(CacheException('No Cache'));
          final result = await repositoryFunction(tPage);
          verify(getCacheFunction());
          expect(result, Left(CacheFailure('No Cache')));
        });

        test('should not call remote data source when offline', () async {
          when(getCacheFunction()).thenAnswer((_) async => [testMovieCache]);
          await repositoryFunction(tPage);
          verifyNever(remoteFunction(tPage));
        });

        test('should handle partial cache data', () async {
          final partialCache = MovieTable(
            id: 1,
            title: 'Partial Movie',
            posterPath: '/path.jpg',
            overview: 'Overview',
          );
          when(getCacheFunction()).thenAnswer((_) async => [partialCache]);
          final result = await repositoryFunction(tPage);
          expect(result.getOrElse(() => []), isNotEmpty);
        });
      });
    });
  }

  /// Test cache operations for different movie types
  testCacheOperations(
    'now playing',
    (movies) => MovieLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    ).cacheNowPlayingMovies(movies),
    () =>
        MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        ).getCachedNowPlayingMovies(),
    (page) => repository.getNowPlayingMovies(page: page),
  );

  testCacheOperations(
    'popular',
    (movies) => MovieLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    ).cachePopularMovies(movies),
    () =>
        MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        ).getCachedPopularMovies(),
    (page) => repository.getPopularMovies(page: page),
  );

  testCacheOperations(
    'top rated',
    (movies) => MovieLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    ).cacheTopRatedMovies(movies),
    () =>
        MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        ).getCachedTopRatedMovies(),
    (page) => repository.getTopRatedMovies(page: page),
  );

  testCacheOperations(
    'up coming',
    (movies) => MovieLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    ).cacheUpComingMovies(movies),
    () =>
        MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        ).getCachedUpComingMovies(),
    (page) => repository.getUpComingMovies(page: page),
  );

  // Test scenarios for different movie list types
  testMovieListScenarios(
    'Now Playing Movies',
    (page) => repository.getNowPlayingMovies(page: page),
    (page) => mockRemoteDataSource.getNowPlayingMovies(page: page),
    (movies) => mockLocalDataSource.cacheNowPlayingMovies(movies),
    () => mockLocalDataSource.getCachedNowPlayingMovies(),
  );

  testMovieListScenarios(
    'Popular Movies',
    (page) => repository.getPopularMovies(page: page),
    (page) => mockRemoteDataSource.getPopularMovies(page: page),
    (movies) => mockLocalDataSource.cachePopularMovies(movies),
    () => mockLocalDataSource.getCachedPopularMovies(),
  );

  testMovieListScenarios(
    'Top Rated Movies',
    (page) => repository.getTopRatedMovies(page: page),
    (page) => mockRemoteDataSource.getTopRatedMovies(page: page),
    (movies) => mockLocalDataSource.cacheTopRatedMovies(movies),
    () => mockLocalDataSource.getCachedTopRatedMovies(),
  );

  testMovieListScenarios(
    'Up Coming Movies',
    (page) => repository.getUpComingMovies(page: page),
    (page) => mockRemoteDataSource.getUpComingMovies(page: page),
    (movies) => mockLocalDataSource.cacheUpComingMovies(movies),
    () => mockLocalDataSource.getCachedUpComingMovies(),
  );

  group('Get Movie Detail', () {
    runTestsOnline(() {
      test('should check if the device is online', () async {
        when(
          mockRemoteDataSource.getMovieDetail(tId),
        ).thenAnswer((_) async => tMovieResponse);
        await repository.getMovieDetail(tId);
        verify(mockNetworkInfo.isConnected);
      });

      test('should return MovieDetail data when the call to remote data source is successful', () async {
        when(
          mockRemoteDataSource.getMovieDetail(tId),
        ).thenAnswer((_) async => tMovieResponse);
        final result = await repository.getMovieDetail(tId);
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, Right(testMovieDetail));
      });

      test('should return Server Failure when the call to remote data source is unsuccessful', () async {
        when(
          mockRemoteDataSource.getMovieDetail(tId),
        ).thenThrow(ServerException());
        final result = await repository.getMovieDetail(tId);
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, Left(ServerFailure('Server Failure')));
      });

      test('should handle invalid movie ID', () async {
        when(
          mockRemoteDataSource.getMovieDetail(-1),
        ).thenThrow(ServerException());
        final result = await repository.getMovieDetail(-1);
        expect(result, Left(ServerFailure('Server Failure')));
      });

      test('should handle malformed response data', () async {
        final malformedResponse = MovieDetailResponse(
          adult: false,
          backdropPath: '',
          budget: 0,
          genres: [],
          homepage: '',
          id: tId,
          imdbId: '',
          originalLanguage: '',
          originalTitle: '',
          overview: '',
          popularity: 0,
          posterPath: '',
          releaseDate: '',
          revenue: 0,
          runtime: 0,
          status: '',
          tagline: '',
          title: '',
          video: false,
          voteAverage: 0,
          voteCount: 0,
        );
        when(
          mockRemoteDataSource.getMovieDetail(tId),
        ).thenAnswer((_) async => malformedResponse);
        final result = await repository.getMovieDetail(tId);
        expect(result.getOrElse(() => throw Exception()), isA<MovieDetail>());
      });
    });

    runTestsOffline(() {
      test(
        'should return cached data when the device is offline and data is available in cache',
        () async {
          // Arrange: Atur mock untuk mengembalikan data dari cache lokal
          when(
            mockLocalDataSource.getCachedMovieDetail(tId),
          ).thenAnswer((_) async => tMovieDetailTable);

          // Act: Panggil fungsi yang diuji
          final result = await repository.getMovieDetail(tId);

          // Assert: Verifikasi hasilnya
          verifyZeroInteractions(
            mockRemoteDataSource,
          ); // Pastikan tidak ada interaksi dengan remote
          verify(mockLocalDataSource.getCachedMovieDetail(tId));
          expect(result, equals(Right(tMovieDetail)));
        },
      );

      test(
        'should return CacheFailure when data is not available in cache',
        () async {
          // Arrange: Atur mock untuk melempar CacheException dari lokal
          when(
            mockLocalDataSource.getCachedMovieDetail(tId),
          ).thenThrow(CacheException('No movie detail cache'));

          // Act: Panggil fungsi yang diuji
          final result = await repository.getMovieDetail(tId);

          // Assert: Verifikasi hasilnya adalah CacheFailure
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCachedMovieDetail(tId));
          // Membandingkan dengan objek Left yang spesifik
          expect(result, equals(Left(CacheFailure('No movie detail cache'))));
        },
      );

      test(
        'should return ConnectionFailure when device is offline and socket exception occurs',
        () async {
          // Arrange: Atur mock untuk melempar SocketException dari lokal (sesuai kode)
          when(mockLocalDataSource.getCachedMovieDetail(tId)).thenThrow(
            const SocketException('Failed to connect to the network'),
          );

          // Act
          final result = await repository.getMovieDetail(tId);

          // Assert
          expect(
            result,
            Left(ConnectionFailure('Failed to connect to the network')),
          );
        },
      );
    });
  });

  group('Get Movie Recommendations', () {
    test('should return data when the call is successful', () async {
      when(
        mockRemoteDataSource.getMovieRecommendations(tId),
      ).thenAnswer((_) async => tMovieModelList);
      final result = await repository.getMovieRecommendations(tId);
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result.getOrElse(() => []), tMovieList);
    });

    test('should return server failure when call is unsuccessful', () async {
      when(
        mockRemoteDataSource.getMovieRecommendations(tId),
      ).thenThrow(ServerException());
      final result = await repository.getMovieRecommendations(tId);
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, Left(ServerFailure('Server Failure')));
    });

    test('should return connection failure when no internet', () async {
      when(
        mockRemoteDataSource.getMovieRecommendations(tId),
      ).thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getMovieRecommendations(tId);
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(
        result,
        Left(ConnectionFailure('Failed to connect to the network')),
      );
    });

    test('should return empty list when no recommendations', () async {
      when(
        mockRemoteDataSource.getMovieRecommendations(tId),
      ).thenAnswer((_) async => []);
      final result = await repository.getMovieRecommendations(tId);
      expect(result.getOrElse(() => []), isEmpty);
    });

    test('should handle invalid movie recommendation ID', () async {
      when(
        mockRemoteDataSource.getMovieRecommendations(-1),
      ).thenThrow(ServerException());
      final result = await repository.getMovieRecommendations(-1);
      expect(result, Left(ServerFailure('Server Failure')));
    });

    test('should handle partial recommendation data', () async {
      final partialModel = MovieModel(
        adult: false,
        backdropPath: '',
        genreIds: [],
        id: 1,
        originalTitle: 'Partial',
        overview: '',
        popularity: 0,
        posterPath: '',
        releaseDate: '',
        title: 'Partial',
        video: false,
        voteAverage: 0,
        voteCount: 0,
      );
      when(
        mockRemoteDataSource.getMovieRecommendations(tId),
      ).thenAnswer((_) async => [partialModel]);
      final result = await repository.getMovieRecommendations(tId);
      expect(result.getOrElse(() => []), isNotEmpty);
    });
  });

  group('Search Movies', () {
    const tQuery = 'spiderman';
    const tEmptyQuery = '';
    const tSpecialCharQuery = 'spider-man';
    final tLongQuery = 'a' * 1000;
    const tNonEnglishQuery = '蜘蛛侠'; // Chinese for Spider-Man

    runTestsOnline(() {
      test('should return movie list when call is successful', () async {
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenAnswer((_) async => tMovieModelList);
        final result = await repository.searchMovies(tQuery);
        expect(result.getOrElse(() => []), tMovieList);
      });

      test('should return ServerFailure when call is unsuccessful', () async {
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenThrow(ServerException());
        final result = await repository.searchMovies(tQuery);
        expect(result, Left(ServerFailure('Server Failure')));
      });

      test('should handle empty query', () async {
        when(
          mockRemoteDataSource.searchMovies(tEmptyQuery),
        ).thenAnswer((_) async => []);
        final result = await repository.searchMovies(tEmptyQuery);
        expect(result.getOrElse(() => []), isEmpty);
      });

      test('should handle special characters in query', () async {
        when(
          mockRemoteDataSource.searchMovies(tSpecialCharQuery),
        ).thenAnswer((_) async => tMovieModelList);
        final result = await repository.searchMovies(tSpecialCharQuery);
        expect(result.getOrElse(() => []), isNotEmpty);
      });

      test('should handle very long queries', () async {
        when(
          mockRemoteDataSource.searchMovies(tLongQuery),
        ).thenAnswer((_) async => tMovieModelList);
        final result = await repository.searchMovies(tLongQuery);
        expect(result.getOrElse(() => []), isNotEmpty);
      });

      test('should handle non-English queries', () async {
        when(
          mockRemoteDataSource.searchMovies(tNonEnglishQuery),
        ).thenAnswer((_) async => tMovieModelList);
        final result = await repository.searchMovies(tNonEnglishQuery);
        expect(result.getOrElse(() => []), isNotEmpty);
      });

      test('should handle whitespace-only queries', () async {
        when(
          mockRemoteDataSource.searchMovies('   '),
        ).thenAnswer((_) async => []);
        final result = await repository.searchMovies('   ');
        expect(result.getOrElse(() => []), isEmpty);
      });

      test(
        'searchMovies should return same results regardless of query case',
        () async {
          when(
            mockRemoteDataSource.searchMovies('SPIDERMAN'),
          ).thenAnswer((_) async => tMovieModelList);
          final result = await repository.searchMovies('SPIDERMAN');
          expect(result.getOrElse(() => []), isNotEmpty);
        },
      );
    });

    runTestsOffline(() {
      test('should return ConnectionFailure when no internet', () async {
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenThrow(SocketException('Failed to connect to the network'));
        final result = await repository.searchMovies(tQuery);
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      });
    });
  });

  group('Watchlist Operations', () {
    final invalidMovie = MovieDetail(
      adult: false,
      backdropPath: '',
      genres: [],
      id: -1,
      originalTitle: '',
      overview: '',
      posterPath: '',
      releaseDate: '',
      runtime: 0,
      title: '',
      voteAverage: 0,
      voteCount: 0,
    );

    final nonExistentMovie = MovieDetail(
      adult: false,
      backdropPath: '',
      genres: [],
      id: -999,
      originalTitle: '',
      overview: '',
      posterPath: '',
      releaseDate: '',
      runtime: 0,
      title: '',
      voteAverage: 0,
      voteCount: 0,
    );

    final corruptedTable = MovieTable(
      id: 1,
      title: 'Corrupted',
      posterPath: '',
      overview: '',
    );

    group('save watchlist', () {
      test('should return success message when saving successful', () async {
        when(
          mockLocalDataSource.insertWatchlist(testMovieTable),
        ).thenAnswer((_) async => 'Added to Watchlist');
        final result = await repository.saveWatchlist(testMovieDetail);
        expect(result, Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving unsuccessful', () async {
        when(
          mockLocalDataSource.insertWatchlist(testMovieTable),
        ).thenThrow(DatabaseException('Failed to add watchlist'));
        final result = await repository.saveWatchlist(testMovieDetail);
        expect(result, Left(DatabaseFailure('Failed to add watchlist')));
      });

      test('should handle null movie detail', () async {
        final result = await repository.saveWatchlist(null);
        expect(result, isA<Left<Failure, String>>());
        expect(result, Left(DatabaseFailure("Can not be null")));
      });

      test('should handle invalid movie data', () async {
        when(
          mockLocalDataSource.insertWatchlist(any),
        ).thenThrow(DatabaseException('Invalid data'));
        final result = await repository.saveWatchlist(invalidMovie);
        expect(result, isA<Left<Failure, String>>());
      });

      test('should handle duplicate movie save', () async {
        when(
          mockLocalDataSource.insertWatchlist(testMovieTable),
        ).thenThrow(DatabaseException('Movie already in watchlist'));
        final result = await repository.saveWatchlist(testMovieDetail);
        expect(result, Left(DatabaseFailure('Movie already in watchlist')));
      });
    });

    group('remove watchlist', () {
      test('should return success message when remove successful', () async {
        when(
          mockLocalDataSource.removeWatchlist(testMovieTable),
        ).thenAnswer((_) async => 'Removed from watchlist');
        final result = await repository.removeWatchlist(testMovieDetail);
        expect(result, Right('Removed from watchlist'));
      });

      test('should return DatabaseFailure when remove unsuccessful', () async {
        when(
          mockLocalDataSource.removeWatchlist(testMovieTable),
        ).thenThrow(DatabaseException('Failed to remove watchlist'));
        final result = await repository.removeWatchlist(testMovieDetail);
        expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
      });

      test('should handle removing non-existent movie', () async {
        when(
          mockLocalDataSource.removeWatchlist(any),
        ).thenThrow(DatabaseException('Movie not in watchlist'));
        final result = await repository.removeWatchlist(nonExistentMovie);
        expect(result, isA<Left<Failure, String>>());
      });

      test('should handle removing already removed movie', () async {
        when(
          mockLocalDataSource.removeWatchlist(testMovieTable),
        ).thenThrow(DatabaseException('Movie not found'));
        final result = await repository.removeWatchlist(testMovieDetail);
        expect(result, Left(DatabaseFailure('Movie not found')));
      });
    });

    group('get watchlist status', () {
      test('should return false when data is not found', () async {
        when(
          mockLocalDataSource.getMovieById(tId),
        ).thenAnswer((_) async => null);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, Right(false));
      });

      test('should return true when data is found', () async {
        when(
          mockLocalDataSource.getMovieById(tId),
        ).thenAnswer((_) async => testMovieTable);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, Right(true));
      });

      test('should handle invalid movie ID', () async {
        when(
          mockLocalDataSource.getMovieById(-1),
        ).thenAnswer((_) async => null);
        final result = await repository.isAddedToWatchlist(-1);
        expect(result, Right(false));
      });

      test('should handle database errors', () async {
        when(
          mockLocalDataSource.getMovieById(tId),
        ).thenThrow(DatabaseException('Database error'));
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, Left(DatabaseFailure('Database error')));
      });

      test('should handle corrupted movie data', () async {
        when(
          mockLocalDataSource.getMovieById(tId),
        ).thenAnswer((_) async => corruptedTable);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, Right(true));
      });
    });

    group('get watchlist movies', () {
      test('should return list of Movies', () async {
        when(
          mockLocalDataSource.getWatchlistMovies(),
        ).thenAnswer((_) async => [testMovieTable]);
        final result = await repository.getWatchlistMovies();
        expect(result.getOrElse(() => []), [testWatchlistMovie]);
      });

      test('should return empty list when no watchlist', () async {
        when(
          mockLocalDataSource.getWatchlistMovies(),
        ).thenAnswer((_) async => []);
        final result = await repository.getWatchlistMovies();
        expect(result.getOrElse(() => []), isEmpty);
      });

      test('should handle database exception', () async {
        when(
          mockLocalDataSource.getWatchlistMovies(),
        ).thenThrow(DatabaseException('Database error'));
        final result = await repository.getWatchlistMovies();
        expect(result, Left(DatabaseFailure('Database error')));
      });

      test('should handle corrupted watchlist data', () async {
        when(
          mockLocalDataSource.getWatchlistMovies(),
        ).thenAnswer((_) async => [corruptedTable]);
        final result = await repository.getWatchlistMovies();
        expect(result.getOrElse(() => []), isNotEmpty);
      });

      test('should handle multiple watchlist items', () async {
        final anotherMovieTable = MovieTable(
          id: 2,
          title: 'Another Movie',
          posterPath: '/another.jpg',
          overview: 'Another overview',
        );
        when(
          mockLocalDataSource.getWatchlistMovies(),
        ).thenAnswer((_) async => [testMovieTable, anotherMovieTable]);
        final result = await repository.getWatchlistMovies();
        expect(result.getOrElse(() => []).length, 2);
      });
    });
  });
}
