import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetWatchlistTv(repository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(
      repository.getWatchlistTv(),
    ).thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
