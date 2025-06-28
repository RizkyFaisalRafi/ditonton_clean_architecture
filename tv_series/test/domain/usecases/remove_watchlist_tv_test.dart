import 'package:dartz/dartz.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTv(repository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(
      repository.removeWatchlist(testTvDetail),
    ).thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(repository.removeWatchlist(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
