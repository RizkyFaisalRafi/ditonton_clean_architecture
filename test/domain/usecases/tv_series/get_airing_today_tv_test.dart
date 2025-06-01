import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_airing_today_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetAiringTodayTv usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetAiringTodayTv(repository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(repository.getAiringToday()).thenAnswer((_) async => Right(tTvSeries));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(tTvSeries));
  });

  test('should return failure when repository returns error', () async {
    // arrange
    when(
      repository.getAiringToday(),
    ).thenAnswer((_) async => Left(ServerFailure('Server error')));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Left(ServerFailure('Server error')));
  });


}
