
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = SaveWatchlistTv(repository);
  });

  test('should save tv series to the repository', () async {
    // arrange
    when(repository.saveWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(repository.saveWatchlist(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}