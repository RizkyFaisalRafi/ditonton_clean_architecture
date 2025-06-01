import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetTvRecommendations(repository);
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(
      repository.getTvRecommendations(tId),
    ).thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvSeries));
  });
}
