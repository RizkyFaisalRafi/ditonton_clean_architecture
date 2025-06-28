import 'package:dartz/dartz.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = SearchTvSeries(repository);
  });

  final tTv = <TvSeries>[];
  final tQuery = 'Squid Game';

  test('should get list of tv from the repository', () async {
    // arrange
    when(repository.searchTvSeries(tQuery)).thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
}
