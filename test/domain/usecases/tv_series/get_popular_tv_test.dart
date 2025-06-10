import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
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

  const tPage = 1;

  group('GetPopularTv Tests', () {
    test('should get list of tv from the mockTvSeriesRepository', () async {
      // arrange
      when(
        mockTvSeriesRepository.getPopularTv(page: anyNamed('page')),
      ).thenAnswer((_) async => Right(tTvSeries));

      // act
      final result = await usecase.execute(tPage);

      // assert
      expect(result, Right(tTvSeries));
      verify(mockTvSeriesRepository.getPopularTv(page: tPage));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test(
      'should return ServerFailure when mockTvSeriesRepository call fails with server error',
          () async {
        // arrange
        when(
          mockTvSeriesRepository.getPopularTv(page: anyNamed('page')),
        ).thenAnswer((_) async => Left(ServerFailure('Server error')));

        // act
        final result = await usecase.execute(tPage);

        // assert
        expect(result, Left(ServerFailure('Server error')));
        verify(mockTvSeriesRepository.getPopularTv(page: tPage));
        verifyNoMoreInteractions(mockTvSeriesRepository);
      },
    );

    test(
      'should return ConnectionFailure when there is no internet connection',
          () async {
        // arrange
        when(
          mockTvSeriesRepository.getPopularTv(page: anyNamed('page')),
        ).thenAnswer((_) async => Left(ConnectionFailure('No internet')));

        // act
        final result = await usecase.execute(tPage);

        // assert
        expect(result, Left(ConnectionFailure('No internet')));
        verify(mockTvSeriesRepository.getPopularTv(page: tPage));
        verifyNoMoreInteractions(mockTvSeriesRepository);
      },
    );

    test(
      'should return CacheFailure when cached data is not available',
          () async {
        // arrange
        when(
          mockTvSeriesRepository.getPopularTv(page: anyNamed('page')),
        ).thenAnswer((_) async => Left(CacheFailure('Cache error')));

        // act
        final result = await usecase.execute(tPage);

        // assert
        expect(result, Left(CacheFailure('Cache error')));
        verify(mockTvSeriesRepository.getPopularTv(page: tPage));
        verifyNoMoreInteractions(mockTvSeriesRepository);
      },
    );

    test('should handle empty list of movies from mockTvSeriesRepository', () async {
      // arrange
      when(
        mockTvSeriesRepository.getPopularTv(page: anyNamed('page')),
      ).thenAnswer((_) async => Right<Failure, List<TvSeries>>([]));

      // act
      final result = await usecase.execute(tPage);

      // assert
      expect(result.getOrElse(() => []), isEmpty);
      verify(mockTvSeriesRepository.getPopularTv(page: tPage));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should handle invalid page numbers (negative or zero)', () async {
      // arrange
      when(
        mockTvSeriesRepository.getPopularTv(page: anyNamed('page')),
      ).thenAnswer((_) async => Left(ServerFailure('Invalid page')));

      // act
      final resultNegative = await usecase.execute(-1);
      final resultZero = await usecase.execute(0);

      // assert
      expect(resultNegative, Left(ServerFailure('Invalid page')));
      expect(resultZero, Left(ServerFailure('Invalid page')));
      verify(mockTvSeriesRepository.getPopularTv(page: -1));
      verify(mockTvSeriesRepository.getPopularTv(page: 0));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });

    test('should return error when page number is too large', () async {
      // arrange
      const largePage = 999999;
      final serverFailure = ServerFailure("Invalid page");

      when(
        mockTvSeriesRepository.getPopularTv(page: largePage),
      ).thenAnswer((_) async => Left(serverFailure));

      // act
      final result = await usecase.execute(largePage);

      // assert
      expect(result, Left(serverFailure));
      verify(mockTvSeriesRepository.getPopularTv(page: largePage));
      verifyNoMoreInteractions(mockTvSeriesRepository);
    });
  });
}
