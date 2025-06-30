import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../../dummy_data/dummy_objects_movie.dart';
import '../../../helpers/test_helper_movie.mocks.dart';

void main() {
  late SeeMorePopularMovieBloc seeMorePopularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    seeMorePopularMovieBloc = SeeMorePopularMovieBloc(
      getPopularMovies: mockGetPopularMovies,
    );
  });

  tearDown(() {
    seeMorePopularMovieBloc.close();
  });

  test('initial state should be Initial', () {
    expect(
      seeMorePopularMovieBloc.state,
      const SeeMorePopularMovieState.initialPopularMSeeMore(),
    );
  });

  group('FetchInitialPopularMovies', () {
    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // Arrange
        when(
          mockGetPopularMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));

        // Assert
        // We expect the BLoC to emit Loading, then Loaded.
        final expected = [
          const SeeMorePopularMovieState.loadingPopularMSeeMore(),
          SeeMorePopularMovieState.loadedPopularMSeeMore(
            popular: testMovieList,
            popularPage: 2,
            hasMorePopular: true,
          ),
        ];
        expectLater(seeMorePopularMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMorePopularMovieBloc.add(
          const SeeMorePopularMovieEvent.fetchInitialPopularMovies(),
        );
      },
    );

    test(
      'should emit [Loading, Error] when get popular movies is unsuccessful',
      () async {
        // Arrange
        when(
          mockGetPopularMovies.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // Assert
        final expected = [
          const SeeMorePopularMovieState.loadingPopularMSeeMore(),
          const SeeMorePopularMovieState.errorPopularMSeeMore('Server Failure'),
        ];
        expectLater(seeMorePopularMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMorePopularMovieBloc.add(
          const SeeMorePopularMovieEvent.fetchInitialPopularMovies(),
        );
      },
    );
  });

  group('FetchMorePopularMovies', () {
    test(
      'should emit new Loaded state with more data when successful',
      () async {
        // Arrange
        // Mock for the initial fetch
        when(
          mockGetPopularMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));
        // Mock for the "load more" fetch
        when(
          mockGetPopularMovies.execute(2),
        ).thenAnswer((_) async => Right(testMovieList));

        // Assert
        final expected = [
          const SeeMorePopularMovieState.loadingPopularMSeeMore(),
          SeeMorePopularMovieState.loadedPopularMSeeMore(
            popular: testMovieList,
            popularPage: 2,
            hasMorePopular: true,
          ),
          SeeMorePopularMovieState.loadedPopularMSeeMore(
            popular: [...testMovieList, ...testMovieList],
            popularPage: 3,
            hasMorePopular: true,
          ),
        ];
        expectLater(seeMorePopularMovieBloc.stream, emitsInOrder(expected));

        // Act
        // First, get the initial data to put the BLoC into a Loaded state
        seeMorePopularMovieBloc.add(
          const SeeMorePopularMovieEvent.fetchInitialPopularMovies(),
        );
        // Then, trigger the fetch more event
        await Future.delayed(
          Duration.zero,
        ); // allow the first event to be processed
        seeMorePopularMovieBloc.add(
          const SeeMorePopularMovieEvent.fetchMorePopularSeeMoreMovies(),
        );
      },
    );

    test(
      'should emit Loaded with hasMorePopular false when no more data',
      () async {
        // Arrange
        when(
          mockGetPopularMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));
        when(
          mockGetPopularMovies.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return empty list

        // Assert
        final expected = [
          const SeeMorePopularMovieState.loadingPopularMSeeMore(),
          SeeMorePopularMovieState.loadedPopularMSeeMore(
            popular: testMovieList,
            popularPage: 2,
            hasMorePopular: true,
          ),
          SeeMorePopularMovieState.loadedPopularMSeeMore(
            popular: testMovieList,
            popularPage: 3,
            hasMorePopular: false,
          ),
        ];
        expectLater(seeMorePopularMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMorePopularMovieBloc.add(
          const SeeMorePopularMovieEvent.fetchInitialPopularMovies(),
        );
        await Future.delayed(Duration.zero);
        seeMorePopularMovieBloc.add(
          const SeeMorePopularMovieEvent.fetchMorePopularSeeMoreMovies(),
        );
      },
    );

    test('should not call usecase when hasMorePopular is false', () async {
      // Arrange
      when(
        mockGetPopularMovies.execute(1),
      ).thenAnswer((_) async => Right(testMovieList));
      when(
        mockGetPopularMovies.execute(2),
      ).thenAnswer((_) async => Right([])); // Page 2 has no data

      // Act
      // Load initial data, then load more (which will return empty)
      seeMorePopularMovieBloc.add(
        const SeeMorePopularMovieEvent.fetchInitialPopularMovies(),
      );
      await seeMorePopularMovieBloc.stream.firstWhere(
        (state) => state is LoadedPopularMSeeMore,
      ); // Wait until loaded
      seeMorePopularMovieBloc.add(
        const SeeMorePopularMovieEvent.fetchMorePopularSeeMoreMovies(),
      );
      await seeMorePopularMovieBloc.stream.firstWhere(
        (state) => (state as LoadedPopularMSeeMore).hasMorePopular == false,
      ); // Wait until hasMore is false

      // Now the state is Loaded with hasMorePopular: false. Try to fetch again.
      seeMorePopularMovieBloc.add(
        const SeeMorePopularMovieEvent.fetchMorePopularSeeMoreMovies(),
      );

      // Assert
      // We verify that execute(3) was never called.
      verifyNever(mockGetPopularMovies.execute(3));
    });
  });
}
