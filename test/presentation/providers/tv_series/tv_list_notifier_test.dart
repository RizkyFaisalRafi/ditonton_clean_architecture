import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_airing_today_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_on_the_air_tv.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTv, GetOnTheAirTv])
void main() {
  late TvListNotifier provider;
  late MockGetAiringTodayTv mockGetAiringTodayTv;
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTv = MockGetAiringTodayTv();
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    provider = TvListNotifier(
      getAiringTodayTv: mockGetAiringTodayTv,
      getOnTheAirTv: mockGetOnTheAirTv,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tTvSeries = <TvSeries>[testTvSeries];

  group('Airing Today Tv', () {
    test('initialState should be Empty', () {
      expect(provider.airingTodayState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(
        mockGetAiringTodayTv.execute(),
      ).thenAnswer((_) async => Right(tTvSeries));
      // act
      provider.fetchTvSeriesAiringToday();
      // assert
      verify(mockGetAiringTodayTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(
        mockGetAiringTodayTv.execute(),
      ).thenAnswer((_) async => Right(tTvSeries));
      // act
      provider.fetchTvSeriesAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Loading);
    });

    test('should change tvSeries when data is gotten successfully', () async {
      // arrange
      when(
        mockGetAiringTodayTv.execute(),
      ).thenAnswer((_) async => Right(tTvSeries));
      // act
      await provider.fetchTvSeriesAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Loaded);
      expect(provider.airingTodayTvSeries, tTvSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(
        mockGetAiringTodayTv.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesAiringToday();
      // assert
      expect(provider.airingTodayState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('On The Air Tv', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(
        mockGetOnTheAirTv.execute(),
      ).thenAnswer((_) async => Right(tTvSeries));
      // act
      provider.fetchTvSeriesOnTheAir();
      // assert
      verify(mockGetOnTheAirTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(
        mockGetOnTheAirTv.execute(),
      ).thenAnswer((_) async => Right(tTvSeries));
      // act
      provider.fetchTvSeriesOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change tvSeries when data is gotten successfully', () async {
      // arrange
      when(
        mockGetOnTheAirTv.execute(),
      ).thenAnswer((_) async => Right(tTvSeries));
      // act
      await provider.fetchTvSeriesOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirTvSeries, tTvSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(
        mockGetOnTheAirTv.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesOnTheAir();
      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
