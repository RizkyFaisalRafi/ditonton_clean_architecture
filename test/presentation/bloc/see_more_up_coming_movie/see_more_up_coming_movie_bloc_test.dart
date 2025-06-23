import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_up_coming_movies.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/see_more_upcoming/see_more_upcoming_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'see_more_up_coming_movie_bloc_test.mocks.dart';

@GenerateMocks([GetUpComingMovies])
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
      const SeeMoreUpcomingMovieState.initial(),
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
          const SeeMoreUpcomingMovieState.loading(),
          SeeMoreUpcomingMovieState.loaded(
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
          const SeeMoreUpcomingMovieState.loading(),
          const SeeMoreUpcomingMovieState.error('Server Failure'),
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
          const SeeMoreUpcomingMovieState.loading(),
          SeeMoreUpcomingMovieState.loaded(
            upComing: testMovieList,
            upComingPage: 2,
            hasMoreUpComing: true,
          ),
          SeeMoreUpcomingMovieState.loaded(
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
          const SeeMoreUpcomingMovieEvent.fetchMoreUpComingMovies(),
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
          const SeeMoreUpcomingMovieState.loading(),
          SeeMoreUpcomingMovieState.loaded(
            upComing: testMovieList,
            upComingPage: 2,
            hasMoreUpComing: true,
          ),
          SeeMoreUpcomingMovieState.loaded(
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
          const SeeMoreUpcomingMovieEvent.fetchMoreUpComingMovies(),
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
        (state) => state is Loaded,
      ); // Wait until loaded
      seeMoreUpcomingMovieBloc.add(
        const SeeMoreUpcomingMovieEvent.fetchMoreUpComingMovies(),
      );
      await seeMoreUpcomingMovieBloc.stream.firstWhere(
        (state) => (state as Loaded).hasMoreUpComing == false,
      ); // Wait until hasMore is false

      // Now the state is Loaded with hasMoreUpComing: false. Try to fetch again.
      seeMoreUpcomingMovieBloc.add(
        const SeeMoreUpcomingMovieEvent.fetchMoreUpComingMovies(),
      );

      // Assert
      // We verify that execute(3) was never called.
      verifyNever(mockGetUpComingMovies.execute(3));
    });
  });
}
