import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([GetAiringTodayTv, GetOnTheAirTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListNotifier provider;
  late MockGetAiringTodayTv mockGetAiringTodayTv;
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTv = MockGetAiringTodayTv();
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();

    provider = TvListNotifier(
      getAiringTodayTv: mockGetAiringTodayTv,
      getOnTheAirTv: mockGetOnTheAirTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
      autoInit: false,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  tearDown(() {
    provider.dispose();
  });

  final tTvSeries = <TvSeries>[testTvSeries];
  const tPage = 1;

  group('Initial State', () {
    test('should have initial empty state', () {
      expect(provider.airingTodayState, RequestState.Empty);
      expect(provider.onTheAirState, RequestState.Empty);
      expect(provider.popularTvState, RequestState.Empty);
      expect(provider.topRatedTvState, RequestState.Empty);
      expect(provider.airingTodayTvSeries, isEmpty);
      expect(provider.onTheAirTvSeries, isEmpty);
      expect(provider.popularTvSeries, isEmpty);
      expect(provider.topRatedTvSeries, isEmpty);
    });
  });

  group('Airing Today TV', () {
    test('should update data when success', () async {
      // arrange
      when(
        mockGetAiringTodayTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));

      // act
      await provider.fetchTvSeriesAiringToday();

      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTvSeries, tTvSeries);
      expect(listenerCallCount, 1);
    });

    test('should update page when success', () async {
      // arrange
      when(
        mockGetAiringTodayTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));

      // act
      await provider.fetchTvSeriesAiringToday();

      // assert
      expect(provider.airingTodayTvSeries.length, tTvSeries.length);
    });

    test('should handle error', () async {
      // arrange
      when(
        mockGetAiringTodayTv.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.fetchTvSeriesAiringToday();

      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Error');
      expect(listenerCallCount, 1);
    });
  });

  group('On The Air TV', () {
    test('should update data when success', () async {
      // arrange
      when(
        mockGetOnTheAirTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));

      // act
      await provider.fetchTvSeriesOnTheAir();

      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirTvSeries, tTvSeries);
      expect(listenerCallCount, 1);
    });

    test('should handle error', () async {
      // arrange
      when(
        mockGetOnTheAirTv.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.fetchTvSeriesOnTheAir();

      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Error');
      expect(listenerCallCount, 1);
    });
  });

  group('Popular TV', () {
    test('should update data when success', () async {
      // arrange
      when(
        mockGetPopularTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));

      // act
      await provider.fetchTvSeriesPopularTv();

      // assert
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvSeries);
      expect(listenerCallCount, 1);
    });

    test('should handle error', () async {
      // arrange
      when(
        mockGetPopularTv.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.fetchTvSeriesPopularTv();

      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Error');
      expect(listenerCallCount, 1);
    });
  });

  group('Top Rated TV', () {
    test('should update data when success', () async {
      // arrange
      when(
        mockGetTopRatedTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));

      // act
      await provider.fetchTvSeriesTopRatedTv();

      // assert
      expect(provider.topRatedTvState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, tTvSeries);
      expect(listenerCallCount, 1);
    });

    test('should handle error', () async {
      // arrange
      when(
        mockGetTopRatedTv.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.fetchTvSeriesTopRatedTv();

      // assert
      expect(provider.topRatedTvState, RequestState.Error);
      expect(provider.message, 'Error');
      expect(listenerCallCount, 1);
    });
  });

  group('Refresh', () {
    test('should reset all data when refreshed', () async {
      // arrange
      when(
        mockGetAiringTodayTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));
      when(
        mockGetOnTheAirTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));
      when(
        mockGetPopularTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));
      when(
        mockGetTopRatedTv.execute(tPage),
      ).thenAnswer((_) async => Right(tTvSeries));

      // act
      await provider.onRefresh();

      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.topRatedTvState, RequestState.Loaded);
      expect(provider.refreshC.isRefresh, false);
    });

    test('should handle refresh error', () async {
      // arrange
      when(
        mockGetAiringTodayTv.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.onRefresh();

      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.refreshC.isRefresh, false);
    });
  });

  group('Load More', () {
    test('should load more airing today TV', () async {
      // arrange
      final tTvSeries2 = <TvSeries>[testTvSeries, testTvSeries];

      // Stub untuk mencegah error unexpected call
      when(
        mockGetAiringTodayTv.execute(1),
      ).thenAnswer((_) async => Right(<TvSeries>[]));

      provider.airingTodayTvSeries = tTvSeries2;
      provider.airingTodayPage = 2;
      when(
        mockGetAiringTodayTv.execute(2),
      ).thenAnswer((_) async => Right(tTvSeries2));

      // act
      await provider.loadMoreTvAiringToday();

      // assert
      expect(provider.airingTodayTvSeries.length, tTvSeries.length * 2);
      verify(mockGetAiringTodayTv.execute(2));
    });

    test('should not load more when fetching', () async {
      // arrange
      provider.isFetching = true;

      // act
      await provider.loadMoreTvAiringToday();

      // assert
      verifyNever(mockGetAiringTodayTv.execute(any));
    });
  });
}
