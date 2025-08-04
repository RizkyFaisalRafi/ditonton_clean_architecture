import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([
//   GetTvDetail,
//   GetTvRecommendations,
//   GetWatchListStatusTv,
//   SaveWatchlistTv,
//   RemoveWatchlistTv,
// ])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  const tId = 1;
  final tTvSeries = <TvSeries>[testTvSeries];

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();

    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getWatchListStatus: mockGetWatchListStatusTv,
      saveWatchlist: mockSaveWatchlistTv,
      removeWatchlist: mockRemoveWatchlistTv,
      getTvRecommendations: mockGetTvRecommendations,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  tearDown(() {
    reset(mockGetTvDetail);
    reset(mockGetTvRecommendations);
    reset(mockGetWatchListStatusTv);
    reset(mockSaveWatchlistTv);
    reset(mockRemoveWatchlistTv);
  });

  void arrangeUsecasesSuccess() {
    when(
      mockGetTvDetail.execute(tId),
    ).thenAnswer((_) async => Right(testTvDetail));
    when(
      mockGetTvRecommendations.execute(tId),
    ).thenAnswer((_) async => Right(tTvSeries));
  }

  group('Fetch TV Detail', () {
    test('should initialize with empty state', () {
      expect(provider.tvState, RequestState.empty);
      expect(provider.recommendationState, RequestState.empty);
      expect(provider.tvDetail, isNull);
      expect(provider.tvRecommendations, isEmpty);
    });

    test('should call correct usecases', () async {
      // Arrange
      arrangeUsecasesSuccess();

      // Act
      await provider.fetchTvDetail(tId);

      // Assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when starting', () async {
      // Arrange
      arrangeUsecasesSuccess();

      // Act
      provider.fetchTvDetail(tId);

      // Assert
      expect(provider.tvState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should update tv detail and recommendations when success', () async {
      // Arrange
      arrangeUsecasesSuccess();

      // Act
      await provider.fetchTvDetail(tId);

      // Assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.tvDetail, testTvDetail);
      expect(provider.tvRecommendations, tTvSeries);
      expect(
        listenerCallCount,
        3,
      ); // Loading -> Detail Loaded -> Recommendations Loaded
    });

    test('should handle error when fetching detail fails', () async {
      // Arrange
      when(
        mockGetTvDetail.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Error')));
      when(
        mockGetTvRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tTvSeries));

      // Act
      await provider.fetchTvDetail(tId);

      // Assert
      expect(provider.tvState, RequestState.error);
      expect(provider.message, 'Server Error');
      expect(listenerCallCount, 2); // Loading -> Error
    });

    test('should handle error when fetching recommendations fails', () async {
      // Arrange
      when(
        mockGetTvDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTvDetail));
      when(
        mockGetTvRecommendations.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Recommendation Error')));

      // Act
      await provider.fetchTvDetail(tId);

      // Assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Recommendation Error');
      expect(provider.tvState, RequestState.loaded); // Detail still loaded
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
        mockGetWatchListStatusTv.execute(tId),
      ).thenAnswer((_) async => Right(true));

      // Act
      await provider.loadWatchlistStatus(tId);

      // Assert
      expect(provider.isAddedToWatchlist, true);
      verify(mockGetWatchListStatusTv.execute(tId));
    });

    test('should handle watchlist status failure', () async {
      // Arrange
      when(mockGetWatchListStatusTv.execute(tId)).thenAnswer(
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
        mockSaveWatchlistTv.execute(testTvDetail),
      ).thenAnswer((_) async => Right('Added to Watchlist'));
      when(
        mockGetWatchListStatusTv.execute(testTvDetail.id!),
      ).thenAnswer((_) async => Right(true));

      // Act
      await provider.addWatchlist(testTvDetail);

      // Assert
      verify(mockSaveWatchlistTv.execute(testTvDetail));
      verify(mockGetWatchListStatusTv.execute(testTvDetail.id!));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should handle add watchlist failure', () async {
      // Arrange
      when(
        mockSaveWatchlistTv.execute(testTvDetail),
      ).thenAnswer((_) async => Left(DatabaseFailure('Failed to add')));
      when(
        mockGetWatchListStatusTv.execute(testTvDetail.id!),
      ).thenAnswer((_) async => Right(false));

      // Act
      await provider.addWatchlist(testTvDetail);

      // Assert
      expect(provider.isAddedToWatchlist, false);
      expect(provider.watchlistMessage, 'Failed to add');
    });

    test('should remove from watchlist successfully', () async {
      // Arrange
      when(
        mockRemoveWatchlistTv.execute(testTvDetail),
      ).thenAnswer((_) async => Right('Removed from Watchlist'));
      when(
        mockGetWatchListStatusTv.execute(testTvDetail.id!),
      ).thenAnswer((_) async => Right(false));

      // Act
      await provider.removeFromWatchlist(testTvDetail);

      // Assert
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
      verify(mockGetWatchListStatusTv.execute(testTvDetail.id!));
      expect(provider.isAddedToWatchlist, false);
      expect(provider.watchlistMessage, 'Removed from Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should handle remove watchlist failure', () async {
      // Arrange
      when(
        mockRemoveWatchlistTv.execute(testTvDetail),
      ).thenAnswer((_) async => Left(DatabaseFailure('Failed to remove')));
      when(
        mockGetWatchListStatusTv.execute(testTvDetail.id!),
      ).thenAnswer((_) async => Right(true));

      // Act
      await provider.removeFromWatchlist(testTvDetail);

      // Assert
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Failed to remove');
    });
  });
}
