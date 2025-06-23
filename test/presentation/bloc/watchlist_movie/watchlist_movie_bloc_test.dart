import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
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
    expect(watchlistMovieBloc.state, Initial());
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
            const WatchlistMovieState.loading(),
            WatchlistMovieState.loaded(watchlistMovie: testMovieList),
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
            const WatchlistMovieState.loading(),
            const WatchlistMovieState.error('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
