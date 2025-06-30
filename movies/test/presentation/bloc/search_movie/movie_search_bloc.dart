import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../../helpers/test_helper_movie.mocks.dart';

void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovies;

  final tMovieModel = Movie(
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
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';
  const tInvalidQuery = 'spiderman!';

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(movieSearchBloc.state, MovieSearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Empty] when query is empty or just spaces',
    build: () => movieSearchBloc,
    act: (bloc) => bloc.add(const MovieSearchEvent.onQueryChanged('  ')),
    // Tidak perlu wait karena validasi ini terjadi sebelum debounce
    expect: () => [const MovieSearchState.movieSearchEmpty()],
    verify: (_) {
      // Pastikan use case tidak pernah dipanggil
      verifyZeroInteractions(mockSearchMovies);
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Error] when query contains invalid characters',
    build: () => movieSearchBloc,
    act:
        (bloc) =>
            bloc.add(const MovieSearchEvent.onQueryChanged(tInvalidQuery)),
    // Tidak perlu wait karena validasi ini terjadi sebelum debounce
    expect:
        () => [
          const MovieSearchState.movieSearchError(
            'Query contains invalid characters',
          ),
        ],
    verify: (_) {
      // Pastikan use case tidak pernah dipanggil
      verifyZeroInteractions(mockSearchMovies);
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(
        mockSearchMovies.execute(tQuery),
      ).thenAnswer((_) async => Right(tMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    // wait: const Duration(milliseconds: 100),

    // Tunggu durasi debounce agar event diproses
    wait: const Duration(milliseconds: 500),
    expect: () => [MovieSearchLoading(), MovieSearchHasData(tMovieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Loading, HasData with empty list] when data is empty',
    build: () {
      when(
        mockSearchMovies.execute(tQuery),
      ).thenAnswer((_) async => const Right(<Movie>[]));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(MovieSearchEvent.onQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect:
        () => [
          const MovieSearchState.movieSearchLoading(),
          const MovieSearchState.movieSearchHasData(<Movie>[]),
        ],
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(
        mockSearchMovies.execute(tQuery),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [MovieSearchLoading(), MovieSearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
