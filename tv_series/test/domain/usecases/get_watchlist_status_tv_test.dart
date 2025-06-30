import 'package:dartz/dartz.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetWatchListStatusTv usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetWatchListStatusTv(repository);
  });

  final tId = 1;

  test('should get watchlist status from repository', () async {
    // arrange
    when(
      repository.isAddedToWatchlist(tId),
    ).thenAnswer((_) async => Right(true));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(true));
  });
}
