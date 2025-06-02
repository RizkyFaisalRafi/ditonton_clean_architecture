import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTv(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
        'should get list of tv from the repository when execute function is called',
        () async {
          // arrange
          when(
            mockTvSeriesRepository.getPopularTv(),
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
