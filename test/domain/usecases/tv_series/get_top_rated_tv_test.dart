import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTv(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  group('GetTopRatedTv Tests', () {
    group('execute', () {
      test(
        'should get list of tv from the repository when execute function is called',
        () async {
          // arrange
          when(
            mockTvSeriesRepository.getTopRatedTv(),
          ).thenAnswer((_) async => Right(tTvSeries));
          // act
          final result = await usecase.execute();
          // assert
          expect(result, Right(tTvSeries));
        },
      );
    });
  });
}
