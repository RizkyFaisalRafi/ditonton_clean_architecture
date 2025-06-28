import 'package:dartz/dartz.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = SaveWatchlistTv(repository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(
      repository.saveWatchlist(testTvDetail),
    ).thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(repository.saveWatchlist(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
