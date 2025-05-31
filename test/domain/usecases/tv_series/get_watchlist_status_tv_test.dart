import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

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
    when(repository.isAddedToWatchlist(tId)).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, true);
  });
}
