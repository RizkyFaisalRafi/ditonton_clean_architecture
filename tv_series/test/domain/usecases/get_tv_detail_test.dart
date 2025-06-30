import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvSeriesRepository repository;

  setUp(() {
    repository = MockTvSeriesRepository();
    usecase = GetTvDetail(repository: repository);
  });

  final tId = 1;

  test('should get Tv detail from the repository', () async {
    // arrange
    when(
      repository.getTvDetail(tId),
    ).thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });

  test('should return failure when repository returns error', () async {
    // arrange
    when(
      repository.getTvDetail(tId),
    ).thenAnswer((_) async => Left(ServerFailure('Server error')));

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(result, Left(ServerFailure('Server error')));
  });
}
