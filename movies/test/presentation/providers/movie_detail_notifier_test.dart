import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import '../../helpers/test_helper_movie.mocks.dart';

// @GenerateMocks([
//   GetMovieDetail,
//   GetMovieRecommendations,
//   GetWatchListStatus,
//   SaveWatchlist,
//   RemoveWatchlist,
// ])
void main() {
  late MovieDetailNotifier provider;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;
  final tId = 1;
  final tMovies = <Movie>[testMovie];

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = MovieDetailNotifier(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  tearDown(() {
    reset(mockGetMovieDetail);
    reset(mockGetMovieRecommendations);
    reset(mockGetWatchlistStatus);
    reset(mockSaveWatchlist);
    reset(mockRemoveWatchlist);
  });

  void arrangeUsecasesSuccess() {
    when(
      mockGetMovieDetail.execute(tId),
    ).thenAnswer((_) async => Right(testMovieDetail));
    when(
      mockGetMovieRecommendations.execute(tId),
    ).thenAnswer((_) async => Right(tMovies));
  }

  group('Fetch Movie Detail', () {
    test('should initialize with empty state', () {
      expect(provider.movieState, RequestState.Empty);
      expect(provider.recommendationState, RequestState.Empty);
      expect(provider.movie, isNull);
      expect(provider.movieRecommendations, isEmpty);
    });

    test('should call correct usecases', () async {
      // Arrange
      arrangeUsecasesSuccess();

      // Act
      await provider.fetchMovieDetail(tId);

      // Assert
      verify(mockGetMovieDetail.execute(tId));
      verify(mockGetMovieRecommendations.execute(tId));
    });

    test('should change state to Loading when starting', () async {
      // Arrange
      arrangeUsecasesSuccess();

      // Act
      provider.fetchMovieDetail(tId);

      // Assert
      expect(provider.movieState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test(
      'should update movie detail and recommendations when success',
      () async {
        // Arrange
        arrangeUsecasesSuccess();

        // Act
        await provider.fetchMovieDetail(tId);

        // Assert
        expect(provider.movieState, RequestState.Loaded);
        expect(provider.recommendationState, RequestState.Loaded);
        expect(provider.movie, testMovieDetail);
        expect(provider.movieRecommendations, tMovies);
        expect(
          listenerCallCount,
          3,
        ); // Loading -> Detail Loaded -> Recommendations Loaded
      },
    );

    test('should handle error when fetching detail fails', () async {
      // Arrange
      when(
        mockGetMovieDetail.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Error')));
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tMovies));

      // Act
      await provider.fetchMovieDetail(tId);

      // Assert
      expect(provider.movieState, RequestState.Error);
      expect(provider.message, 'Server Error');
      expect(listenerCallCount, 2); // Loading -> Error
    });

    test('should handle error when fetching recommendations fails', () async {
      // Arrange
      when(
        mockGetMovieDetail.execute(tId),
      ).thenAnswer((_) async => Right(testMovieDetail));
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Recommendation Error')));

      // Act
      await provider.fetchMovieDetail(tId);

      // Assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Recommendation Error');
      expect(provider.movieState, RequestState.Loaded); // Detail still loaded
      expect(
        listenerCallCount,
        3,
      ); // Loading -> Detail Loaded -> Recommendation Error
    });
  });

  group('Watchlist Operations', () {
    test('should get watchlist status correctly', () async {
      // Arrange
      when(
        mockGetWatchlistStatus.execute(tId),
      ).thenAnswer((_) async => Right(true));

      // Act
      await provider.loadWatchlistStatus(tId);

      // Assert
      expect(provider.isAddedToWatchlist, true);
      verify(mockGetWatchlistStatus.execute(tId));
    });

    test('should handle watchlist status failure', () async {
      // Arrange
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer(
        (_) async => Right(false),
      ); // or throw error if your implementation does

      // Act
      await provider.loadWatchlistStatus(tId);

      // Assert
      expect(provider.isAddedToWatchlist, false);
    });

    test('should add to watchlist successfully', () async {
      // Arrange
      when(
        mockSaveWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Right('Added to Watchlist'));
      when(
        mockGetWatchlistStatus.execute(testMovieDetail.id),
      ).thenAnswer((_) async => Right(true));

      // Act
      await provider.addWatchlist(testMovieDetail);

      // Assert
      verify(mockSaveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should handle add watchlist failure', () async {
      // Arrange
      when(
        mockSaveWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Left(DatabaseFailure('Failed to add')));
      when(
        mockGetWatchlistStatus.execute(testMovieDetail.id),
      ).thenAnswer((_) async => Right(false));

      // Act
      await provider.addWatchlist(testMovieDetail);

      // Assert
      expect(provider.isAddedToWatchlist, false);
      expect(provider.watchlistMessage, 'Failed to add');
    });

    test('should remove from watchlist successfully', () async {
      // Arrange
      when(
        mockRemoveWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Right('Removed from Watchlist'));
      when(
        mockGetWatchlistStatus.execute(testMovieDetail.id),
      ).thenAnswer((_) async => Right(false));

      // Act
      await provider.removeFromWatchlist(testMovieDetail);

      // Assert
      verify(mockRemoveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      expect(provider.isAddedToWatchlist, false);
      expect(provider.watchlistMessage, 'Removed from Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should handle remove watchlist failure', () async {
      // Arrange
      when(
        mockRemoveWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Left(DatabaseFailure('Failed to remove')));
      when(
        mockGetWatchlistStatus.execute(testMovieDetail.id),
      ).thenAnswer((_) async => Right(true));

      // Act
      await provider.removeFromWatchlist(testMovieDetail);

      // Assert
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Failed to remove');
    });
  });
}
