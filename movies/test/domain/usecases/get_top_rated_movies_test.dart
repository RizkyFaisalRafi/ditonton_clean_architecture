import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/module/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper_movie.mocks.dart';

void main() {
  late GetTopRatedMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTopRatedMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  const tPage = 1;

  group('GetTopRatedMovies Tests', () {
    test(
      'should get top rated movies from the repository with correct page number',
          () async {
        // arrange
        when(
          mockMovieRepository.getTopRatedMovies(page: anyNamed('page')),
        ).thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute(tPage);
        // assert
        expect(result, Right(tMovies));
        verify(mockMovieRepository.getTopRatedMovies(page: tPage));
        verifyNoMoreInteractions(mockMovieRepository);
      },
    );

    test(
      'should return ServerFailure when repository call fails with server error',
          () async {
        // arrange
        when(
          mockMovieRepository.getTopRatedMovies(page: anyNamed('page')),
        ).thenAnswer((_) async => Left(ServerFailure('Server error')));

        // act
        final result = await usecase.execute(tPage);

        // assert
        expect(result, Left(ServerFailure('Server error')));
        verify(mockMovieRepository.getTopRatedMovies(page: tPage));
        verifyNoMoreInteractions(mockMovieRepository);
      },
    );

    test(
      'should return ConnectionFailure when there is no internet connection',
          () async {
        // arrange
        when(
          mockMovieRepository.getTopRatedMovies(page: anyNamed('page')),
        ).thenAnswer((_) async => Left(ConnectionFailure('No internet')));

        // act
        final result = await usecase.execute(tPage);

        // assert
        expect(result, Left(ConnectionFailure('No internet')));
        verify(mockMovieRepository.getTopRatedMovies(page: tPage));
        verifyNoMoreInteractions(mockMovieRepository);
      },
    );

    test(
      'should return CacheFailure when cached data is not available',
          () async {
        // arrange
        when(
          mockMovieRepository.getTopRatedMovies(page: anyNamed('page')),
        ).thenAnswer((_) async => Left(CacheFailure('Cache error')));

        // act
        final result = await usecase.execute(tPage);

        // assert
        expect(result, Left(CacheFailure('Cache error')));
        verify(mockMovieRepository.getTopRatedMovies(page: tPage));
        verifyNoMoreInteractions(mockMovieRepository);
      },
    );

    test('should handle empty list of movies from repository', () async {
      // arrange
      when(
        mockMovieRepository.getTopRatedMovies(page: anyNamed('page')),
      ).thenAnswer((_) async => Right<Failure, List<Movie>>([]));

      // act
      final result = await usecase.execute(tPage);

      // assert
      expect(result.getOrElse(() => []), isEmpty);
      verify(mockMovieRepository.getTopRatedMovies(page: tPage));
      verifyNoMoreInteractions(mockMovieRepository);
    });

    test('should handle invalid page numbers (negative or zero)', () async {
      // arrange
      when(
        mockMovieRepository.getTopRatedMovies(page: anyNamed('page')),
      ).thenAnswer((_) async => Left(ServerFailure('Invalid page')));

      // act
      final resultNegative = await usecase.execute(-1);
      final resultZero = await usecase.execute(0);

      // assert
      expect(resultNegative, Left(ServerFailure('Invalid page')));
      expect(resultZero, Left(ServerFailure('Invalid page')));
      verify(mockMovieRepository.getTopRatedMovies(page: -1));
      verify(mockMovieRepository.getTopRatedMovies(page: 0));
      verifyNoMoreInteractions(mockMovieRepository);
    });

    test('should return error when page number is too large', () async {
      // arrange
      const largePage = 999999;
      final serverFailure = ServerFailure("Invalid page");

      when(
        mockMovieRepository.getTopRatedMovies(page: largePage),
      ).thenAnswer((_) async => Left(serverFailure));

      // act
      final result = await usecase.execute(largePage);

      // assert
      expect(result, Left(serverFailure));
      verify(mockMovieRepository.getTopRatedMovies(page: largePage));
      verifyNoMoreInteractions(mockMovieRepository);
    });
  });
}