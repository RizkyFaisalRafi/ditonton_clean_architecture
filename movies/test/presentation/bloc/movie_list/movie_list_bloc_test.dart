import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../../helpers/test_helper_movie.mocks.dart';

void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetUpComingMovies mockGetUpComingMovies;

  final tMovies = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = <Movie>[tMovies];

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetUpComingMovies = MockGetUpComingMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetPopularMovies = MockGetPopularMovies();

    movieListBloc = MovieListBloc(
      getUpComingMovies: mockGetUpComingMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
    );
  });

  // Tes untuk memastikan state awal adalah Initial
  test('initial state should be Initial', () {
    expect(movieListBloc.state, const MovieListState.initialMovieList());
  });

  group('FetchInitialMovies', () {
    // Tes untuk kasus sukses saat pertama kali fetch data
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        // Atur mock untuk mengembalikan data sukses
        when(
          mockGetNowPlayingMovies.execute(1),
        ).thenAnswer((_) async => Right(tMovieList));
        when(
          mockGetPopularMovies.execute(1),
        ).thenAnswer((_) async => Right(tMovieList));
        when(
          mockGetUpComingMovies.execute(1),
        ).thenAnswer((_) async => Right(tMovieList));
        when(
          mockGetTopRatedMovies.execute(1),
        ).thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },

      act: (bloc) => bloc.add(const MovieListEvent.fetchInitialMovies()),

      expect:
          () => <MovieListState>[
            const MovieListState.loadingMovieList(),
            MovieListState.loadedMovieList(
              // DataList
              nowPlaying: tMovieList,
              popular: tMovieList,
              topRated: tMovieList,
              upcoming: tMovieList,

              // Halaman berikutnya adalah 2
              nowPlayingPage: 2,
              popularPage: 2,
              topRatedPage: 2,
              upcomingPage: 2,

              // Masih ada data karena list tidak kosong
              hasMoreNowPlaying: true,
              hasMorePopular: true,
              hasMoreTopRated: true,
              hasMoreUpcoming: true,
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman pertama (1)
        verify(mockGetNowPlayingMovies.execute(1));
        verify(mockGetUpComingMovies.execute(1));
        verify(mockGetTopRatedMovies.execute(1));
        verify(mockGetPopularMovies.execute(1));
      },
    );

    // Tes untuk kasus sukses tapi data yang diterima kosong
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Loaded] with empty list and no more data when fetched data is empty',
      build: () {
        // Atur mock untuk mengembalikan list kosong
        when(
          mockGetNowPlayingMovies.execute(1),
        ).thenAnswer((_) async => const Right([]));
        when(
          mockGetPopularMovies.execute(1),
        ).thenAnswer((_) async => const Right([]));
        when(
          mockGetUpComingMovies.execute(1),
        ).thenAnswer((_) async => const Right([]));
        when(
          mockGetTopRatedMovies.execute(1),
        ).thenAnswer((_) async => const Right([]));

        return movieListBloc;
      },
      act: (bloc) => bloc.add(const MovieListEvent.fetchInitialMovies()),

      expect:
          () => <MovieListState>[
            const MovieListState.loadingMovieList(),
            const MovieListState.loadedMovieList(
              // Data Empty
              nowPlaying: [],
              popular: [],
              upcoming: [],
              topRated: [],

              // Page
              nowPlayingPage: 2,
              popularPage: 2,
              upcomingPage: 2,
              topRatedPage: 2,

              // Tidak ada data lagi
              hasMoreNowPlaying: false,
              hasMorePopular: false,
              hasMoreUpcoming: false,
              hasMoreTopRated: false,
            ),
          ],
    );

    // Tes untuk kasus kegagalan (misal: error server)
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Error] when data fetching fails',
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetNowPlayingMovies.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetPopularMovies.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetUpComingMovies.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetTopRatedMovies.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return movieListBloc;
      },
      act: (bloc) => bloc.add(const MovieListEvent.fetchInitialMovies()),
      expect:
          () => <MovieListState>[
            const MovieListState.loadingMovieList(),
            const MovieListState.errorMovieList('Server Failure'),
          ],
    );
  });

  group('RefreshMovies', () {
    // Tes untuk pull-to-refresh. Logikanya sama dengan fetch awal.
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Loaded] when RefreshMovie is added',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(1),
        ).thenAnswer((_) async => Right(tMovieList));
        when(
          mockGetPopularMovies.execute(1),
        ).thenAnswer((_) async => Right(tMovieList));
        when(
          mockGetTopRatedMovies.execute(1),
        ).thenAnswer((_) async => Right(tMovieList));
        when(
          mockGetUpComingMovies.execute(1),
        ).thenAnswer((_) async => Right(tMovieList));

        return movieListBloc;
      },

      // Trigger event refresh
      act: (bloc) => bloc.add(const MovieListEvent.refreshMovies()),

      // Karena RefreshMovies hanya memanggil FetchInitialMovies,
      // urutan state yang di-emit akan sama persis.
      expect:
          () => <MovieListState>[
            const MovieListState.loadingMovieList(),
            MovieListState.loadedMovieList(
              nowPlaying: tMovieList,
              popular: tMovieList,
              topRated: tMovieList,
              upcoming: tMovieList,

              nowPlayingPage: 2,
              popularPage: 2,
              topRatedPage: 2,
              upcomingPage: 2,

              hasMoreNowPlaying: true,
              hasMorePopular: true,
              hasMoreTopRated: true,
              hasMoreUpcoming: true,
            ),
          ],
      verify: (_) {
        // Verifikasi bahwa proses fetch dari halaman pertama terjadi
        verify(mockGetNowPlayingMovies.execute(1));
        verify(mockGetPopularMovies.execute(1));
        verify(mockGetTopRatedMovies.execute(1));
        verify(mockGetUpComingMovies.execute(1));
      },
    );
  });

  group('FetchMoreNowPlayingMovies', () {
    // Definisikan initialState sebagai Loaded
    final initialState = MovieListState.loadedMovieList(
      nowPlaying: tMovieList,
      popular: const [],
      topRated: const [],
      upcoming: const [],
      nowPlayingPage: 2,
      popularPage: 1,
      topRatedPage: 1,
      upcomingPage: 1,
      hasMoreNowPlaying: true,
      hasMorePopular: false,
      hasMoreTopRated: false,
      hasMoreUpcoming: false,
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit new Loaded state with updated nowPlaying list when successful',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(2),
        ).thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      seed: () => initialState,
      // Mulai dari state Loaded
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreNowPlayingMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              nowPlaying: [
                ...tMovieList,
                ...tMovieList,
              ], // Data lama + data baru
              nowPlayingPage: 3,
              hasMoreNowPlaying: true,
            ),
          ],
      verify: (_) => verify(mockGetNowPlayingMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit Loaded state with minorError when fetch more fails',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(2),
        ).thenAnswer((_) async => Left(ServerFailure('Load More Failed')));
        return movieListBloc;
      },
      seed: () => initialState,
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreNowPlayingMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              minorError: 'Load More Failed',
            ),
          ],
      verify: (_) => verify(mockGetNowPlayingMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should update hasMoreNowPlaying to false when fetch more returns empty list',
      build: () {
        when(
          mockGetNowPlayingMovies.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return list kosong
        return movieListBloc;
      },
      seed: () => initialState,
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreNowPlayingMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              nowPlayingPage: 3,
              hasMoreNowPlaying: false, // Flag menjadi false
            ),
          ],
      verify: (_) => verify(mockGetNowPlayingMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should not emit new state when hasMoreNowPlaying is false',
      build: () => movieListBloc,
      seed:
          () => (initialState as LoadedMovieList).copyWith(
            hasMoreNowPlaying: false,
          ),
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreNowPlayingMovies()),
      expect: () => [],
      // Tidak ada state baru yang di-emit
      verify: (_) => verifyNever(mockGetNowPlayingMovies.execute(any)),
    );
  });

  group('FetchMorePopularMovies', () {
    // Definisikan initialState sebagai Loaded
    final initialState = MovieListState.loadedMovieList(
      nowPlaying: const [],
      popular: tMovieList,
      topRated: const [],
      upcoming: const [],
      nowPlayingPage: 1,
      popularPage: 2,
      topRatedPage: 1,
      upcomingPage: 1,
      hasMoreNowPlaying: false,
      hasMorePopular: true,
      hasMoreTopRated: false,
      hasMoreUpcoming: false,
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit new Loaded state with updated popular list when successful',
      build: () {
        when(
          mockGetPopularMovies.execute(2),
        ).thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      seed: () => initialState,
      // Mulai dari state Loaded
      act: (bloc) => bloc.add(const MovieListEvent.fetchMorePopularMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              popular: [...tMovieList, ...tMovieList], // Data lama + data baru
              popularPage: 3,
              hasMorePopular: true,
            ),
          ],
      verify: (_) => verify(mockGetPopularMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit Loaded state with minorError when fetch more fails',
      build: () {
        when(
          mockGetPopularMovies.execute(2),
        ).thenAnswer((_) async => Left(ServerFailure('Load More Failed')));
        return movieListBloc;
      },
      seed: () => initialState,
      act: (bloc) => bloc.add(const MovieListEvent.fetchMorePopularMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              minorError: 'Load More Failed',
            ),
          ],
      verify: (_) => verify(mockGetPopularMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should update hasMorePopular to false when fetch more returns empty list',
      build: () {
        when(
          mockGetPopularMovies.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return list kosong
        return movieListBloc;
      },
      seed: () => initialState,
      act: (bloc) => bloc.add(const MovieListEvent.fetchMorePopularMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              popularPage: 3,
              hasMorePopular: false, // Flag menjadi false
            ),
          ],
      verify: (_) => verify(mockGetPopularMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should not emit new state when hasMorePopular is false',
      build: () => movieListBloc,
      seed:
          () =>
              (initialState as LoadedMovieList).copyWith(hasMorePopular: false),
      act: (bloc) => bloc.add(const MovieListEvent.fetchMorePopularMovies()),
      expect: () => [],
      // Tidak ada state baru yang di-emit
      verify: (_) => verifyNever(mockGetPopularMovies.execute(any)),
    );
  });

  group('FetchMoreTopRatedMovies', () {
    // Definisikan initialState sebagai Loaded
    final initialState = MovieListState.loadedMovieList(
      nowPlaying: const [],
      popular: const [],
      topRated: tMovieList,
      upcoming: const [],
      nowPlayingPage: 1,
      popularPage: 1,
      topRatedPage: 2,
      upcomingPage: 1,
      hasMoreNowPlaying: false,
      hasMorePopular: false,
      hasMoreTopRated: true,
      hasMoreUpcoming: false,
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit new Loaded state with updated topRated list when successful',
      build: () {
        when(
          mockGetTopRatedMovies.execute(2),
        ).thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      seed: () => initialState,
      // Mulai dari state Loaded
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreTopRatedMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              topRated: [...tMovieList, ...tMovieList], // Data lama + data baru
              topRatedPage: 3,
              hasMoreTopRated: true,
            ),
          ],
      verify: (_) => verify(mockGetTopRatedMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit Loaded state with minorError when fetch more fails',
      build: () {
        when(
          mockGetTopRatedMovies.execute(2),
        ).thenAnswer((_) async => Left(ServerFailure('Load More Failed')));
        return movieListBloc;
      },
      seed: () => initialState,
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreTopRatedMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              minorError: 'Load More Failed',
            ),
          ],
      verify: (_) => verify(mockGetTopRatedMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should update hasMoreTopRated to false when fetch more returns empty list',
      build: () {
        when(
          mockGetTopRatedMovies.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return list kosong
        return movieListBloc;
      },
      seed: () => initialState,
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreTopRatedMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              topRatedPage: 3,
              hasMoreTopRated: false, // Flag menjadi false
            ),
          ],
      verify: (_) => verify(mockGetTopRatedMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should not emit new state when hasMoreTopRated is false',
      build: () => movieListBloc,
      seed:
          () => (initialState as LoadedMovieList).copyWith(
            hasMoreTopRated: false,
          ),
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreTopRatedMovies()),
      expect: () => [],
      // Tidak ada state baru yang di-emit
      verify: (_) => verifyNever(mockGetTopRatedMovies.execute(any)),
    );
  });

  group('FetchMoreUpComingMovies', () {
    // Definisikan initialState sebagai Loaded
    final initialState = MovieListState.loadedMovieList(
      nowPlaying: const [],
      popular: const [],
      topRated: const [],
      upcoming: tMovieList,
      nowPlayingPage: 1,
      popularPage: 1,
      topRatedPage: 1,
      upcomingPage: 2,
      hasMoreNowPlaying: false,
      hasMorePopular: false,
      hasMoreTopRated: false,
      hasMoreUpcoming: true,
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit new Loaded state with updated upcoming list when successful',
      build: () {
        when(
          mockGetUpComingMovies.execute(2),
        ).thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      seed: () => initialState,
      // Mulai dari state Loaded
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreUpcomingMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              upcoming: [...tMovieList, ...tMovieList], // Data lama + data baru
              upcomingPage: 3,
              hasMoreUpcoming: true,
            ),
          ],
      verify: (_) => verify(mockGetUpComingMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit Loaded state with minorError when fetch more fails',
      build: () {
        when(
          mockGetUpComingMovies.execute(2),
        ).thenAnswer((_) async => Left(ServerFailure('Load More Failed')));
        return movieListBloc;
      },
      seed: () => initialState,
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreUpcomingMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              minorError: 'Load More Failed',
            ),
          ],
      verify: (_) => verify(mockGetUpComingMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should update hasMoreUpcoming to false when fetch more returns empty list',
      build: () {
        when(
          mockGetUpComingMovies.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return list kosong
        return movieListBloc;
      },
      seed: () => initialState,
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreUpcomingMovies()),
      expect:
          () => [
            (initialState as LoadedMovieList).copyWith(
              upcomingPage: 3,
              hasMoreUpcoming: false, // Flag menjadi false
            ),
          ],
      verify: (_) => verify(mockGetUpComingMovies.execute(2)),
    );

    blocTest<MovieListBloc, MovieListState>(
      'should not emit new state when hasMoreUpcoming is false',
      build: () => movieListBloc,
      seed:
          () => (initialState as LoadedMovieList).copyWith(
            hasMoreUpcoming: false,
          ),
      act: (bloc) => bloc.add(const MovieListEvent.fetchMoreUpcomingMovies()),
      expect: () => [],
      // Tidak ada state baru yang di-emit
      verify: (_) => verifyNever(mockGetUpComingMovies.execute(any)),
    );
  });
}
