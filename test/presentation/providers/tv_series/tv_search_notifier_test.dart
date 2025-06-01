import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSearchNotifier provider;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;
  const tQuery = 'GuteZeiten';

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    provider = TvSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  tearDown(() {
    reset(mockSearchTvSeries);
  });

  group('Query Validation', () {
    test('should reject empty query', () async {
      await provider.fetchTvSearch('');
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Query cannot be empty');
    });

    test('should reject special characters', () async {
      await provider.fetchTvSearch('query@123');
      expect(provider.state, RequestState.Error);
    });
  });

  group('search tv series', () {
    test('should call usecase with correct query', () async {
      when(
        mockSearchTvSeries.execute(tQuery),
      ).thenAnswer((_) async => Right(testTvList));

      await provider.fetchTvSearch(tQuery);

      verify(mockSearchTvSeries.execute(tQuery));
    });

    test('should change state to loading when usecase is called', () async {
      // arrange
      when(
        mockSearchTvSeries.execute(tQuery),
      ).thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test(
      'should change search result data when data is gotten successfully',
      () async {
        // arrange
        when(
          mockSearchTvSeries.execute(tQuery),
        ).thenAnswer((_) async => Right(testTvList));
        // act
        await provider.fetchTvSearch(tQuery);
        // assert
        expect(provider.state, RequestState.Loaded);
        expect(provider.searchResult, testTvList);
        expect(listenerCallCount, 2);
      },
    );

    test('should handle empty search result', () async {
      when(
        mockSearchTvSeries.execute(tQuery),
      ).thenAnswer((_) async => Right([]));

      await provider.fetchTvSearch(tQuery);

      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, isEmpty);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(
        mockSearchTvSeries.execute(tQuery),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

    test('should handle ConnectionFailure', () async {
      when(
        mockSearchTvSeries.execute(tQuery),
      ).thenAnswer((_) async => Left(ConnectionFailure('No Internet')));

      await provider.fetchTvSearch(tQuery);

      expect(provider.message, 'No Internet');
    });
  });
}
