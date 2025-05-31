import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_status_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;
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

  final tId = 1;

  // final tTv = TvSeries(
  //   adult: false,
  //   backdropPath: '/ottT2Yt0OfHiHp3PHJTLNVV8JPE.jpg',
  //   genreIds: [18, 10766],
  //   id: 13945,
  //   originCountry: ["DE"],
  //   originalLanguage: "de",
  //   originalName: "Gute Zeiten, schlechte Zeiten",
  //   overview:
  //   "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
  //   popularity: 677.2062,
  //   posterPath: "/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg",
  //   firstAirDate: "1992-05-11",
  //   name: "Gute Zeiten, schlechte Zeiten",
  //   voteAverage: 5.769,
  //   voteCount: 39,
  // );

  final tTvSeries = <TvSeries>[testTvSeries];

  void arrangeUsecase() {
    when(
      mockGetTvDetail.execute(tId),
    ).thenAnswer((_) async => Right(testTvDetail));
    when(
      mockGetTvRecommendations.execute(tId),
    ).thenAnswer((_) async => Right(tTvSeries));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvDetail when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvDetail, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test(
      'should change recommendation tv series when data is gotten successfully',
      () async {
        // arrange
        arrangeUsecase();
        // act
        await provider.fetchTvDetail(tId);
        // assert
        expect(provider.tvState, RequestState.Loaded);
        expect(provider.tvRecommendations, tTvSeries);
      },
    );
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTvSeries);
    });

    test(
      'should update recommendation state when data is gotten successfully',
      () async {
        // arrange
        arrangeUsecase();
        // act
        await provider.fetchTvDetail(tId);
        // assert
        expect(provider.recommendationState, RequestState.Loaded);
        expect(provider.tvRecommendations, tTvSeries);
      },
    );

    test('should update error message when request in successful', () async {
      // arrange
      when(
        mockGetTvDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTvDetail));
      when(
        mockGetTvRecommendations.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListStatusTv.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(
        mockSaveWatchlistTv.execute(testTvDetail),
      ).thenAnswer((_) async => Right('Success'));
      when(
        mockGetWatchListStatusTv.execute(testTvDetail.id),
      ).thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(
        mockRemoveWatchlistTv.execute(testTvDetail),
      ).thenAnswer((_) async => Right('Removed'));
      when(
        mockGetWatchListStatusTv.execute(testTvDetail.id),
      ).thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(
        mockSaveWatchlistTv.execute(testTvDetail),
      ).thenAnswer((_) async => Right('Added to Watchlist'));
      when(
        mockGetWatchListStatusTv.execute(testTvDetail.id),
      ).thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockGetWatchListStatusTv.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(
        mockSaveWatchlistTv.execute(testTvDetail),
      ).thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(
        mockGetWatchListStatusTv.execute(testTvDetail.id),
      ).thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(
        mockGetTvDetail.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(
        mockGetTvRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tTvSeries));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
