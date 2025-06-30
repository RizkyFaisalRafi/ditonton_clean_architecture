import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../../dummy_data/dummy_objects_movie.dart';
import '../../../helpers/test_helper_movie.mocks.dart';

void main() {
  late SeeMoreTopRatedMovieBloc seeMoreTopRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    seeMoreTopRatedMovieBloc = SeeMoreTopRatedMovieBloc(
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  tearDown(() {
    seeMoreTopRatedMovieBloc.close();
  });

  test('initial state should be Initial', () {
    expect(
      seeMoreTopRatedMovieBloc.state,
      const SeeMoreTopRatedMovieState.initialTopRatedMSeeMore(),
    );
  });

  group('FetchInitialTopRatedMovies', () {
    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // Arrange
        when(
          mockGetTopRatedMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));

        // Assert
        // We expect the BLoC to emit Loading, then Loaded.
        final expected = [
          const SeeMoreTopRatedMovieState.loadingTopRatedMSeeMore(),
          SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore(
            topRated: testMovieList,
            topRatedPage: 2,
            hasMoreTopRated: true,
          ),
        ];
        expectLater(seeMoreTopRatedMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedMovieBloc.add(
          const SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies(),
        );
      },
    );

    test(
      'should emit [Loading, Error] when get top rated movies is unsuccessful',
      () async {
        // Arrange
        when(
          mockGetTopRatedMovies.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // Assert
        final expected = [
          const SeeMoreTopRatedMovieState.loadingTopRatedMSeeMore(),
          const SeeMoreTopRatedMovieState.errorTopRatedMSeeMore(
            'Server Failure',
          ),
        ];
        expectLater(seeMoreTopRatedMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedMovieBloc.add(
          const SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies(),
        );
      },
    );
  });

  group('FetchMoreTopRatedMovies', () {
    test(
      'should emit new Loaded state with more data when successful',
      () async {
        // Arrange
        // Mock for the initial fetch
        when(
          mockGetTopRatedMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));
        // Mock for the "load more" fetch
        when(
          mockGetTopRatedMovies.execute(2),
        ).thenAnswer((_) async => Right(testMovieList));

        // Assert
        final expected = [
          const SeeMoreTopRatedMovieState.loadingTopRatedMSeeMore(),
          SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore(
            topRated: testMovieList,
            topRatedPage: 2,
            hasMoreTopRated: true,
          ),
          SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore(
            topRated: [...testMovieList, ...testMovieList],
            topRatedPage: 3,
            hasMoreTopRated: true,
          ),
        ];
        expectLater(seeMoreTopRatedMovieBloc.stream, emitsInOrder(expected));

        // Act
        // First, get the initial data to put the BLoC into a Loaded state
        seeMoreTopRatedMovieBloc.add(
          const SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies(),
        );
        // Then, trigger the fetch more event
        await Future.delayed(
          Duration.zero,
        ); // allow the first event to be processed
        seeMoreTopRatedMovieBloc.add(
          const SeeMoreTopRatedMovieEvent.fetchMoreTopRatedSeeMoreMovies(),
        );
      },
    );

    test(
      'should emit Loaded with hasMoreTopRated false when no more data',
      () async {
        // Arrange
        when(
          mockGetTopRatedMovies.execute(1),
        ).thenAnswer((_) async => Right(testMovieList));
        when(
          mockGetTopRatedMovies.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return empty list

        // Assert
        final expected = [
          const SeeMoreTopRatedMovieState.loadingTopRatedMSeeMore(),
          SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore(
            topRated: testMovieList,
            topRatedPage: 2,
            hasMoreTopRated: true,
          ),
          SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore(
            topRated: testMovieList,
            topRatedPage: 3,
            hasMoreTopRated: false,
          ),
        ];
        expectLater(seeMoreTopRatedMovieBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedMovieBloc.add(
          const SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies(),
        );
        await Future.delayed(Duration.zero);
        seeMoreTopRatedMovieBloc.add(
          const SeeMoreTopRatedMovieEvent.fetchMoreTopRatedSeeMoreMovies(),
        );
      },
    );

    test('should not call usecase when hasMoreTopRated is false', () async {
      // Arrange
      when(
        mockGetTopRatedMovies.execute(1),
      ).thenAnswer((_) async => Right(testMovieList));
      when(
        mockGetTopRatedMovies.execute(2),
      ).thenAnswer((_) async => Right([])); // Page 2 has no data

      // Act
      // Load initial data, then load more (which will return empty)
      seeMoreTopRatedMovieBloc.add(
        const SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies(),
      );
      await seeMoreTopRatedMovieBloc.stream.firstWhere(
        (state) => state is LoadedTopRatedMSeeMore,
      ); // Wait until loaded
      seeMoreTopRatedMovieBloc.add(
        const SeeMoreTopRatedMovieEvent.fetchMoreTopRatedSeeMoreMovies(),
      );
      await seeMoreTopRatedMovieBloc.stream.firstWhere(
        (state) => (state as LoadedTopRatedMSeeMore).hasMoreTopRated == false,
      ); // Wait until hasMore is false

      // Now the state is Loaded with hasMoreTopRated: false. Try to fetch again.
      seeMoreTopRatedMovieBloc.add(
        const SeeMoreTopRatedMovieEvent.fetchMoreTopRatedSeeMoreMovies(),
      );

      // Assert
      // We verify that execute(3) was never called.
      verifyNever(mockGetTopRatedMovies.execute(3));
    });
  });
}
