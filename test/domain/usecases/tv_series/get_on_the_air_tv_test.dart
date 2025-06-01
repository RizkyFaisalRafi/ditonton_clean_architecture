import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_on_the_air_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetOnTheAirTv(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  group('GetOnTheAirTv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvSeriesRepository.getOnTheAir())
                .thenAnswer((_) async => Right(tTvSeries));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTvSeries));
          });
    });
  });

}
