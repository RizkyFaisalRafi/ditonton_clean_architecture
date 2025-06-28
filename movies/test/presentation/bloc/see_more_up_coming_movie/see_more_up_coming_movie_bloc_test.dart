import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../../dummy_data/dummy_objects_movie.dart';
import '../../../helpers/test_helper_movie.mocks.dart';

void main() {
  late SeeMoreUpcomingMovieBloc seeMoreUpcomingMovieBloc;
  late MockGetUpComingMovies mockGetUpComingMovies;

  setUp(() {
    mockGetUpComingMovies = MockGetUpComingMovies();
    seeMoreUpcomingMovieBloc = SeeMoreUpcomingMovieBloc(
      getUpComingMovies: mockGetUpComingMovies,
    );
  });

  tearDown(() {
    seeMoreUpcomingMovieBloc.close();
  });

  test('initial state should be Initial', () {
    expect(
      seeMoreUpcomingMovieBloc.state,
      const SeeMoreUpcomingMovieState.initialUpComingMSeeMore(),
    );
  });

  group('FetchInitialUpComingMovies', () {
    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // Arrange
        when(
          mockGetUpComingMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));

        // Assert
        // We expect the BLoC to emit Loading, then Loaded.
        final expected = [
          const SeeMoreUpcomingMovieState.loadingUpComingMSeeMore(),
          SeeMoreUpcomingMovieState.loadedUpComingMSeeMore(
            upComing: testMovieList,
            upComingPage: 2,
            hasMoreUpComing: true,
          ),
        ];
        expectLater(seeMoreUpcomingMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreUpcomingMovieBloc.add(
          const SeeMoreUpcomingMovieEvent.fetchInitialUpComingMovies(),
        );
      },
    );

    test(
      'should emit [Loading, Error] when get upComing movies is unsuccessful',
      () async {
        // Arrange
        when(
          mockGetUpComingMovies.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // Assert
        final expected = [
          const SeeMoreUpcomingMovieState.loadingUpComingMSeeMore(),
          const SeeMoreUpcomingMovieState.errorUpComingMSeeMore(
            'Server Failure',
          ),
        ];
        expectLater(seeMoreUpcomingMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreUpcomingMovieBloc.add(
          const SeeMoreUpcomingMovieEvent.fetchInitialUpComingMovies(),
        );
      },
    );
  });

  group('FetchMoreUpComingMovies', () {
    test(
      'should emit new Loaded state with more data when successful',
      () async {
        // Arrange
        // Mock for the initial fetch
        when(
          mockGetUpComingMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));
        // Mock for the "load more" fetch
        when(
          mockGetUpComingMovies.execute(2),
        ).thenAnswer((_) async => Right(testMovieList));

        // Assert
        final expected = [
          const SeeMoreUpcomingMovieState.loadingUpComingMSeeMore(),
          SeeMoreUpcomingMovieState.loadedUpComingMSeeMore(
            upComing: testMovieList,
            upComingPage: 2,
            hasMoreUpComing: true,
          ),
          SeeMoreUpcomingMovieState.loadedUpComingMSeeMore(
            upComing: [...testMovieList, ...testMovieList],
            upComingPage: 3,
            hasMoreUpComing: true,
          ),
        ];
        expectLater(seeMoreUpcomingMovieBloc.stream, emitsInOrder(expected));

        // Act
        // First, get the initial data to put the BLoC into a Loaded state
        seeMoreUpcomingMovieBloc.add(
          const SeeMoreUpcomingMovieEvent.fetchInitialUpComingMovies(),
        );
        // Then, trigger the fetch more event
        await Future.delayed(
          Duration.zero,
        ); // allow the first event to be processed
        seeMoreUpcomingMovieBloc.add(
          const SeeMoreUpcomingMovieEvent.fetchMoreUpComingSeeMoreMovies(),
        );
      },
    );

    test(
      'should emit Loaded with hasMoreUpComing false when no more data',
      () async {
        // Arrange
        when(
          mockGetUpComingMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));
        when(
          mockGetUpComingMovies.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return empty list

        // Assert
        final expected = [
          const SeeMoreUpcomingMovieState.loadingUpComingMSeeMore(),
          SeeMoreUpcomingMovieState.loadedUpComingMSeeMore(
            upComing: testMovieList,
            upComingPage: 2,
            hasMoreUpComing: true,
          ),
          SeeMoreUpcomingMovieState.loadedUpComingMSeeMore(
            upComing: testMovieList,
            upComingPage: 3,
            hasMoreUpComing: false,
          ),
        ];
        expectLater(seeMoreUpcomingMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreUpcomingMovieBloc.add(
          const SeeMoreUpcomingMovieEvent.fetchInitialUpComingMovies(),
        );
        await Future.delayed(Duration.zero);
        seeMoreUpcomingMovieBloc.add(
          const SeeMoreUpcomingMovieEvent.fetchMoreUpComingSeeMoreMovies(),
        );
      },
    );

    test('should not call usecase when hasMoreUpComing is false', () async {
      // Arrange
      when(
        mockGetUpComingMovies.execute(1),
      ).thenAnswer((_) async => Right(testMovieList));
      when(
        mockGetUpComingMovies.execute(2),
      ).thenAnswer((_) async => Right([])); // Page 2 has no data

      // Act
      // Load initial data, then load more (which will return empty)
      seeMoreUpcomingMovieBloc.add(
        const SeeMoreUpcomingMovieEvent.fetchInitialUpComingMovies(),
      );
      await seeMoreUpcomingMovieBloc.stream.firstWhere(
        (state) => state is LoadedUpComingMSeeMore,
      ); // Wait until loaded
      seeMoreUpcomingMovieBloc.add(
        const SeeMoreUpcomingMovieEvent.fetchMoreUpComingSeeMoreMovies(),
      );
      await seeMoreUpcomingMovieBloc.stream.firstWhere(
        (state) => (state as LoadedUpComingMSeeMore).hasMoreUpComing == false,
      ); // Wait until hasMore is false

      // Now the state is Loaded with hasMoreUpComing: false. Try to fetch again.
      seeMoreUpcomingMovieBloc.add(
        const SeeMoreUpcomingMovieEvent.fetchMoreUpComingSeeMoreMovies(),
      );

      // Assert
      // We verify that execute(3) was never called.
      verifyNever(mockGetUpComingMovies.execute(3));
    });
  });
}
