import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

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
