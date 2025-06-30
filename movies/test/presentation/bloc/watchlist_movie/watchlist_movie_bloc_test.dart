import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../../dummy_data/dummy_objects_movie.dart';
import '../../../helpers/test_helper_movie.mocks.dart';

void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    // Inisialisasi mock class dari file .mocks.dart
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  /// Initial State
  test('initial state should be Initial', () {
    expect(watchlistMovieBloc.state, InitialWatchlistMovie());
  });

  group('Get Watchlist Movies', () {
    /// Loading - Loaded Success
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      setUp: () {
        when(
          mockGetWatchlistMovies.execute(),
        ).thenAnswer((_) async => Right(testMovieList));
      },
      build: () => watchlistMovieBloc,
      act:
          (bloc) =>
              bloc.add(const WatchlistMovieEvent.fetchInitialWatchlistMovies()),
      expect:
          () => <WatchlistMovieState>[
            const WatchlistMovieState.loadingWatchlistMovie(),
            WatchlistMovieState.loadedWatchlistMovie(
              watchlistMovie: testMovieList,
            ),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    /// Loading - Error Unsuccessfully
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when get watchlist is unsuccessful',
      setUp: () {
        when(
          mockGetWatchlistMovies.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      },
      build: () => watchlistMovieBloc,
      act:
          (bloc) =>
              bloc.add(const WatchlistMovieEvent.fetchInitialWatchlistMovies()),
      expect:
          () => <WatchlistMovieState>[
            const WatchlistMovieState.loadingWatchlistMovie(),
            const WatchlistMovieState.errorWatchlistMovie('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
