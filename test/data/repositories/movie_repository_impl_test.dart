import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/genre_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_detail_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_table.dart';
import 'package:ditonton_clean_architecture/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
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
    overview: 'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
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
      Future<Either<Failure, List<Movie>>> Function() repositoryFunction,
      ) {
    group('cache $cacheType movies', () {

      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
      });

      test('should call database helper to save data', () async {
        when(mockDatabaseHelper.clearCache(cacheType)).thenAnswer((_) async => 1);
        when(mockDatabaseHelper.insertCacheTransaction([testMovieCache], cacheType))
            .thenAnswer((_) async => {});

        await cacheFunction([testMovieCache]);

        verify(mockDatabaseHelper.clearCache(cacheType));
        verify(mockDatabaseHelper.insertCacheTransaction([testMovieCache], cacheType));
      });

      test('should return list of movies from db when data exist', () async {
        when(mockDatabaseHelper.getCacheMovies(cacheType))
            .thenAnswer((_) async => [testMovieCacheMap]);

        final result = await getCacheFunction();
        expect(result, [testMovieCache]);
      });

      test('should throw CacheException when cache data is not exist', () async {
        when(mockDatabaseHelper.getCacheMovies(cacheType)).thenAnswer((_) async => []);
        final call = getCacheFunction();
        expect(() => call, throwsA(isA<CacheException>()));
      });
    });
  }

  // Helper function to test online/offline scenarios
  void testMovieListScenarios(
      String description,
      Future<Either<Failure, List<Movie>>> Function() repositoryFunction,
      Future<List<MovieModel>> Function() remoteFunction,
      Future<void> Function(List<MovieTable>) cacheFunction,
      Future<List<MovieTable>> Function() getCacheFunction,
      ) {
    group(description, () {
      group('when device is online', () {
        setUp(() => when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));

        test('should check if the device is online', () async {
          when(remoteFunction()).thenAnswer((_) async => []);
          await repositoryFunction();
          verify(mockNetworkInfo.isConnected);
        });

        test('should return movie list when call to data source is successful', () async {
          when(remoteFunction()).thenAnswer((_) async => tMovieModelList);
          final result = await repositoryFunction();
          verify(remoteFunction());
          expect(result.getOrElse(() => []), tMovieList);
        });

        test('should cache data when call to remote data source is successful', () async {
          when(remoteFunction()).thenAnswer((_) async => tMovieModelList);
          await repositoryFunction();
          verify(remoteFunction());
          verify(cacheFunction([testMovieCache]));
        });

        test('should return server failure when call is unsuccessful', () async {
          when(remoteFunction()).thenThrow(ServerException());
          final result = await repositoryFunction();
          expect(result, Left(ServerFailure('')));
        });
      });

      group('when device is offline', () {
        setUp(() => when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

        test('should return cached data when available', () async {
          when(getCacheFunction()).thenAnswer((_) async => [testMovieCache]);
          final result = await repositoryFunction();
          verify(getCacheFunction());
          expect(result.getOrElse(() => []), [testMovieFromCache]);
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

  // Test cache operations for different movie types
  testCacheOperations(
    'now playing',
        (movies) => MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper).cacheNowPlayingMovies(movies),
        () => MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper).getCachedNowPlayingMovies(),
        () => repository.getNowPlayingMovies(),
  );

  testCacheOperations(
    'popular',
        (movies) => MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper).cachePopularMovies(movies),
        () => MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper).getCachedPopularMovies(),
        () => repository.getPopularMovies(),
  );

  testCacheOperations(
    'top rated',
        (movies) => MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper).cacheTopRatedMovies(movies),
        () => MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper).getCachedTopRatedMovies(),
        () => repository.getTopRatedMovies(),
  );

  testCacheOperations(
    'up coming',
        (movies) => MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper).cacheUpComingMovies(movies),
        () => MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper).getCachedUpComingMovies(),
        () => repository.getUpComingMovies(),
  );

  // Test scenarios for different movie list types
  testMovieListScenarios(
    'Now Playing Movies',
        () => repository.getNowPlayingMovies(),
        () => mockRemoteDataSource.getNowPlayingMovies(),
        (movies) => mockLocalDataSource.cacheNowPlayingMovies(movies),
        () => mockLocalDataSource.getCachedNowPlayingMovies(),
  );

  testMovieListScenarios(
    'Popular Movies',
        () => repository.getPopularMovies(),
        () => mockRemoteDataSource.getPopularMovies(),
        (movies) => mockLocalDataSource.cachePopularMovies(movies),
        () => mockLocalDataSource.getCachedPopularMovies(),
  );

  testMovieListScenarios(
    'Top Rated Movies',
        () => repository.getTopRatedMovies(),
        () => mockRemoteDataSource.getTopRatedMovies(),
        (movies) => mockLocalDataSource.cacheTopRatedMovies(movies),
        () => mockLocalDataSource.getCachedTopRatedMovies(),
  );

  testMovieListScenarios(
    'Up Coming Movies',
        () => repository.getUpComingMovies(),
        () => mockRemoteDataSource.getUpComingMovies(),
        (movies) => mockLocalDataSource.cacheUpComingMovies(movies),
        () => mockLocalDataSource.getCachedUpComingMovies(),
  );

  group('Get Movie Detail', () {
    group('when device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));

      test('should check if the device is online', () async {
        when(mockRemoteDataSource.getMovieDetail(tId)).thenAnswer((_) async => tMovieResponse);
        await repository.getMovieDetail(tId);
        verify(mockNetworkInfo.isConnected);
      });

      test('should return Movie data when call is successful', () async {
        when(mockRemoteDataSource.getMovieDetail(tId)).thenAnswer((_) async => tMovieResponse);
        final result = await repository.getMovieDetail(tId);
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, Right(testMovieDetail));
      });

      test('should return Server Failure when call is unsuccessful', () async {
        when(mockRemoteDataSource.getMovieDetail(tId)).thenThrow(ServerException());
        final result = await repository.getMovieDetail(tId);
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, Left(ServerFailure('')));
      });
    });

    group('when device is offline', () {
      setUp(() => when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));

      test('should return connection failure when not connected', () async {
        when(mockRemoteDataSource.getMovieDetail(tId))
            .thenThrow(SocketException('Failed to connect to the network'));
        final result = await repository.getMovieDetail(tId);
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, Left(ConnectionFailure('Failed to connect to the network')));
      });
    });

    // Additional edge cases
    test('should handle invalid movie ID', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getMovieDetail(-1)).thenThrow(ServerException());
      final result = await repository.getMovieDetail(-1);
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Get Movie Recommendations', () {
    test('should return data when the call is successful', () async {
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieModelList);
      final result = await repository.getMovieRecommendations(tId);
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result.getOrElse(() => []), tMovieList);
    });

    test('should return server failure when call is unsuccessful', () async {
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(ServerException());
      final result = await repository.getMovieRecommendations(tId);
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, Left(ServerFailure('')));
    });

    test('should return connection failure when no internet', () async {
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getMovieRecommendations(tId);
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    // Additional test case
    test('should return empty list when no recommendations', () async {
      when(mockRemoteDataSource.getMovieRecommendations(tId))
          .thenAnswer((_) async => []);
      final result = await repository.getMovieRecommendations(tId);
      expect(result.getOrElse(() => []), isEmpty);
    });
  });

  group('Search Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call is successful', () async {
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      final result = await repository.searchMovies(tQuery);
      expect(result.getOrElse(() => []), tMovieList);
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(ServerException());
      final result = await repository.searchMovies(tQuery);
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when no internet', () async {
      when(mockRemoteDataSource.searchMovies(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.searchMovies(tQuery);
      expect(result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    // Additional test cases
    test('should handle empty query', () async {
      when(mockRemoteDataSource.searchMovies(''))
          .thenAnswer((_) async => []);
      final result = await repository.searchMovies('');
      expect(result.getOrElse(() => []), isEmpty);
    });

    test('should handle special characters in query', () async {
      when(mockRemoteDataSource.searchMovies('spider-man'))
          .thenAnswer((_) async => tMovieModelList);
      final result = await repository.searchMovies('spider-man');
      expect(result.getOrElse(() => []), isNotEmpty);
    });
  });

  group('Watchlist Operations', () {
    group('save watchlist', () {
      test('should return success message when saving successful', () async {
        when(mockLocalDataSource.insertWatchlist(testMovieTable))
            .thenAnswer((_) async => 'Added to Watchlist');
        final result = await repository.saveWatchlist(testMovieDetail);
        expect(result, Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving unsuccessful', () async {
        when(mockLocalDataSource.insertWatchlist(testMovieTable))
            .thenThrow(DatabaseException('Failed to add watchlist'));
        final result = await repository.saveWatchlist(testMovieDetail);
        expect(result, Left(DatabaseFailure('Failed to add watchlist')));
      });

      // Additional test case
      test('should handle null movie detail', () async {
        final result = await repository.saveWatchlist(null);
        expect(result, isA<Left<Failure, String>>());
      });
    });

    group('remove watchlist', () {
      test('should return success message when remove successful', () async {
        when(mockLocalDataSource.removeWatchlist(testMovieTable))
            .thenAnswer((_) async => 'Removed from watchlist');
        final result = await repository.removeWatchlist(testMovieDetail);
        expect(result, Right('Removed from watchlist'));
      });

      test('should return DatabaseFailure when remove unsuccessful', () async {
        when(mockLocalDataSource.removeWatchlist(testMovieTable))
            .thenThrow(DatabaseException('Failed to remove watchlist'));
        final result = await repository.removeWatchlist(testMovieDetail);
        expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
      });
    });

    group('get watchlist status', () {
      test('should return false when data is not found', () async {
        when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, false);
      });

      test('should return true when data is found', () async {
        when(mockLocalDataSource.getMovieById(tId))
            .thenAnswer((_) async => testMovieTable);
        final result = await repository.isAddedToWatchlist(tId);
        expect(result, true);
      });

      // Additional test cases
      test('should handle invalid movie ID', () async {
        when(mockLocalDataSource.getMovieById(-1)).thenAnswer((_) async => null);
        final result = await repository.isAddedToWatchlist(-1);
        expect(result, false);
      });
    });

    group('get watchlist movies', () {
      test('should return list of Movies', () async {
        when(mockLocalDataSource.getWatchlistMovies())
            .thenAnswer((_) async => [testMovieTable]);
        final result = await repository.getWatchlistMovies();
        expect(result.getOrElse(() => []), [testWatchlistMovie]);
      });

      test('should return empty list when no watchlist', () async {
        when(mockLocalDataSource.getWatchlistMovies())
            .thenAnswer((_) async => []);
        final result = await repository.getWatchlistMovies();
        expect(result.getOrElse(() => []), isEmpty);
      });

      test('should handle database exception', () async {
        when(mockLocalDataSource.getWatchlistMovies())
            .thenThrow(DatabaseException('Database error'));
        final result = await repository.getWatchlistMovies();
        expect(result, isA<Left<Failure, List<Movie>>>());
      });
    });
  });
}