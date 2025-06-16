import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/search_movies.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_search_bloc.mocks.dart';

@GenerateMocks([SearchMovies])
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
    expect(movieSearchBloc.state, SearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Empty] when query is empty or just spaces',
    build: () => movieSearchBloc,
    act: (bloc) => bloc.add(const MovieSearchEvent.onQueryChanged('  ')),
    // Tidak perlu wait karena validasi ini terjadi sebelum debounce
    expect: () => [const MovieSearchState.searchEmpty()],
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
          const MovieSearchState.searchError(
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
    expect: () => [SearchLoading(), SearchHasData(tMovieList)],
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
          const MovieSearchState.searchLoading(),
          const MovieSearchState.searchHasData(<Movie>[]),
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
    expect: () => [SearchLoading(), SearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
